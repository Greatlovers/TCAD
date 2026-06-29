from __future__ import annotations

import argparse
import csv
import re
import sys
from pathlib import Path


NUMBER = re.compile(r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[Ee][-+]?\d+)?")


def parse(path: Path) -> tuple[list[str], list[list[float]]]:
    text = path.read_text(encoding="ascii", errors="strict")
    datasets_match = re.search(r"datasets\s*=\s*\[(.*?)\]", text, re.S)
    data_match = re.search(r"Data\s*\{(.*?)\}\s*$", text, re.S)
    if not datasets_match or not data_match:
        raise ValueError(f"bad DF-ISE plot format: {path}")
    datasets = re.findall(r'"([^"]+)"', datasets_match.group(1))
    values = [float(token) for token in NUMBER.findall(data_match.group(1))]
    rows = [
        values[index : index + len(datasets)]
        for index in range(0, len(values), len(datasets))
    ]
    return datasets, rows


def interpolate_x_at_y(xs: list[float], ys: list[float], target: float) -> float | None:
    for index in range(1, len(ys)):
        y0, y1 = ys[index - 1], ys[index]
        if (y0 <= target <= y1) or (y1 <= target <= y0):
            if y1 == y0:
                return xs[index]
            ratio = (target - y0) / (y1 - y0)
            return xs[index - 1] + ratio * (xs[index] - xs[index - 1])
    return None


def summarize(paths: list[Path], x_axis: str, currents: list[float]) -> list[dict[str, object]]:
    output_rows: list[dict[str, object]] = []
    for path in paths:
        datasets, rows = parse(path)
        columns = {name.lower(): index for index, name in enumerate(datasets)}
        required = [
            "gate outervoltage",
            "collector outervoltage",
            "collector innervoltage",
            "collector totalcurrent",
        ]
        missing = [name for name in required if name not in columns]
        if missing:
            raise ValueError(f"{path}: missing {missing}")

        gate = [row[columns["gate outervoltage"]] for row in rows]
        outer = [row[columns["collector outervoltage"]] for row in rows]
        inner = [row[columns["collector innervoltage"]] for row in rows]
        current = [row[columns["collector totalcurrent"]] for row in rows]
        order = sorted(range(len(current)), key=current.__getitem__)
        current_sorted = [current[index] for index in order]
        outer_sorted = [outer[index] for index in order]
        inner_sorted = [inner[index] for index in order]

        result: dict[str, object] = {
            "file": path.name,
            "gate_v": gate[-1],
            "points": len(rows),
            "current_max": max(current),
            "outer_v_max": max(outer),
            "inner_v_max": max(inner),
        }
        gate_sorted = [gate[index] for index in order]
        for target in currents:
            label = f"{target:g}"
            if x_axis == "gate":
                result[f"gate_v_at_i_{label}"] = interpolate_x_at_y(
                    gate_sorted, current_sorted, target
                )
            else:
                result[f"outer_v_at_i_{label}"] = interpolate_x_at_y(
                    outer_sorted, current_sorted, target
                )
                result[f"inner_v_at_i_{label}"] = interpolate_x_at_y(
                    inner_sorted, current_sorted, target
                )
        output_rows.append(result)
    return output_rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--x-axis", choices=["collector", "gate"], default="collector")
    parser.add_argument("--currents", nargs="+", type=float, default=[0.001, 0.005, 0.010, 0.040])
    parser.add_argument("plots", nargs="*", type=Path)
    args = parser.parse_args()
    paths = args.plots or [Path("n18_des.plt"), Path("n19_des.plt")]
    rows = summarize(paths, args.x_axis, args.currents)
    writer = csv.DictWriter(sys.stdout, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)


if __name__ == "__main__":
    main()
