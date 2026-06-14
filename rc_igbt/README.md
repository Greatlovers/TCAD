# RC-IGBT Sentaurus TCAD Simulation

This project contains Sentaurus TCAD files for a reverse-conducting insulated gate bipolar transistor (RC-IGBT). The project is organized for long-term GitHub maintenance, portfolio display, and future extension.

## Project Overview

The RC-IGBT integrates the forward conduction behavior of an IGBT with reverse conduction capability. This project focuses on structure generation, static electrical characteristics, reverse conduction, breakdown behavior, and optional self-heating analysis.

## Directory Structure

```text
rc_igbt/
├── sde/          # Sentaurus Structure Editor command files
├── sdevice/      # Sentaurus Device simulation command files
├── parameters/   # Material and physical model parameter files
├── scripts/      # Python post-processing and plotting scripts
├── results/      # Extracted numerical results
├── figures/      # Simulation figures and visualization results
├── docs/         # Notes and documentation
└── README.md
```

## Suggested File Names

### SDE

```text
sde_rc_igbt_planar.cmd
sde_rc_igbt_trench.cmd
sde_rc_igbt_field_stop.cmd
sde_rc_igbt_with_collector_short.cmd
```

### SDevice

```text
sdevice_rc_igbt_ic_vce.cmd
sdevice_rc_igbt_ic_vg.cmd
sdevice_rc_igbt_breakdown.cmd
sdevice_rc_igbt_reverse_conduction.cmd
sdevice_rc_igbt_self_heating.cmd
```

### Parameters

```text
parameters_rc_igbt_si.par
parameters_rc_igbt_physics.par
parameters_rc_igbt_materials.par
```

### Results

```text
rc_igbt_ic_vce_300k.csv
rc_igbt_ic_vg_300k.csv
rc_igbt_breakdown_vge_0v_300k.csv
rc_igbt_reverse_conduction_300k.csv
```

### Figures

```text
rc_igbt_structure_cross_section.png
rc_igbt_ic_vce_curve.png
rc_igbt_ic_vg_curve.png
rc_igbt_breakdown_curve.png
rc_igbt_reverse_conduction_curve.png
rc_igbt_temperature_distribution.png
rc_igbt_electric_field_distribution.png
```

## Simulations

The planned simulation set includes:

- Forward output characteristics, Ic-Vce
- Transfer characteristics, Ic-Vg
- Off-state breakdown simulation
- Reverse conduction characteristics
- Optional self-heating comparison
- Optional transient switching simulation

## Key Metrics

Typical extracted metrics include:

- Threshold voltage
- On-state voltage drop
- Saturation current
- Breakdown voltage
- Reverse conduction voltage drop
- Electric field distribution
- Temperature distribution

## Upload Policy

Suitable files:

- User-written SDE and SDevice command files
- User-written Python scripts
- Cleaned CSV results
- Result figures and documentation
- Non-confidential notes

Avoid uploading:

- Synopsys official examples copied directly
- Commercial models
- License files
- Confidential material parameters
- Large `.tdr`, `.plt`, `.tdrdat`, Newton iteration, and log files

## Disclaimer

This project is not an official Synopsys example. All scripts and simulation settings should be reviewed before being used for publication or production-level device design.
