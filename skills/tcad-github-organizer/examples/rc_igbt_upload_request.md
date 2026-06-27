# Example: RC-IGBT GitHub Organization Request

## User Request

```text
我现在在 RC-IGBT，仓库整理下，我可能不久后就要上传。你帮我整理 GitHub 结构。
```

## Expected Skill Response

### Recommended Repository

```text
sentaurus-power-si-devices
```

### Recommended Directory

```text
rc_igbt/
```

### Suggested Directory Tree

```text
rc_igbt/
├── README.md
├── sde/
│   └── sde_rc_igbt_planar.cmd
├── sdevice/
│   ├── sdevice_rc_igbt_ic_vce.cmd
│   ├── sdevice_rc_igbt_ic_vg.cmd
│   ├── sdevice_rc_igbt_breakdown.cmd
│   └── sdevice_rc_igbt_reverse_conduction.cmd
├── parameters/
│   └── parameters_rc_igbt_si.par
├── scripts/
│   ├── extract_rc_igbt_metrics.py
│   └── plot_rc_igbt_iv_curves.py
├── results/
│   └── rc_igbt_ic_vce_300k.csv
├── figures/
│   ├── rc_igbt_structure_cross_section.png
│   └── rc_igbt_ic_vce_curve.png
└── docs/
    ├── simulation_notes.md
    └── parameter_description.md
```

### Upload Review

Suitable for upload:

- User-written SDE and SDevice files
- User-written Python scripts
- Cleaned CSV results
- Selected result figures
- README and documentation notes

Avoid uploading:

- Synopsys official examples copied directly
- Commercial models
- Confidential parameter files
- `.tdr`, `.tdrdat`, `.plt`, `.log`, and Newton iteration files

### Branch Name

```text
feature/add-rc-igbt-tcad
```

### Commit Message

```text
Add RC-IGBT TCAD project structure
```

### PR Title

```text
Add RC-IGBT Sentaurus TCAD project
```
