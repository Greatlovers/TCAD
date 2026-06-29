# Reproduce / Import Notes

## Import

Use `RC-IGBT_swb_project_sanitized.zip` as the lightweight Workbench import package. It contains Workbench metadata, source decks, generated command decks, scripts, PLT data, and status files.

## Re-run requirements

The public package does not include Sentaurus material parameter files. Before rerunning, provide the equivalent local files in your licensed Sentaurus environment, then inspect `gexec.cmd` and generated `pp*.cmd` paths if Workbench regenerates node commands.

## Suggested run order

1. `sde` structure/mesh generation.
2. `IcVg` and `IcVc` DC validation.
3. `BV` breakdown check.
4. `tran_reverse_recovery` mixed-mode double-pulse.
5. `snapback` continuation scan.

## Results

Use `results/plt/` for curve reconstruction and `results/status/` for public-safe node status inspection. Raw `*.tdr` and `*.sav` files are not included because they may embed local VM or Sentaurus installation paths.
