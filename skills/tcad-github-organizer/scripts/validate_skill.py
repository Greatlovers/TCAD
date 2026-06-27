#!/usr/bin/env python3
"""Validate the TCAD GitHub Organizer skill package.

This helper checks that the skill contains the minimum files expected for an
open-source, maintainable skill package.
"""

from pathlib import Path
import json
import sys


REQUIRED_FILES = [
    "SKILL.md",
    "README.md",
    "skill.json",
    "examples/rc_igbt_upload_request.md",
    "templates/project_readme.md",
    "templates/pr_description.md",
    "templates/file_review_checklist.md",
]


def validate_skill(root: Path) -> list[str]:
    errors: list[str] = []

    for relative_path in REQUIRED_FILES:
        path = root / relative_path
        if not path.is_file():
            errors.append(f"Missing required file: {relative_path}")

    metadata_path = root / "skill.json"
    if metadata_path.is_file():
        try:
            metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
        except json.JSONDecodeError as exc:
            errors.append(f"Invalid skill.json: {exc}")
        else:
            for key in ["name", "version", "description", "entrypoint", "license"]:
                if not metadata.get(key):
                    errors.append(f"Missing metadata key: {key}")

            if metadata.get("entrypoint") != "SKILL.md":
                errors.append("skill.json entrypoint should be SKILL.md")

    skill_path = root / "SKILL.md"
    if skill_path.is_file():
        content = skill_path.read_text(encoding="utf-8")
        required_terms = [
            "Sentaurus",
            "TCAD",
            "GitHub",
            "Upload Suitability",
            "Filename Rules",
        ]
        for term in required_terms:
            if term not in content:
                errors.append(f"SKILL.md should mention: {term}")

    return errors


def main() -> int:
    root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1]
    errors = validate_skill(root)

    if errors:
        print("Skill validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print("Skill validation passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
