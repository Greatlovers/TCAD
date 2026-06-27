---
name: tcad-github-organizer
description: Organize Sentaurus TCAD files into clean, maintainable GitHub repositories.
version: 0.1.0
license: MIT
---

# TCAD GitHub Organizer Skill

## Purpose

Use this skill when the user wants to organize Sentaurus TCAD-related files for GitHub. The skill focuses on repository structure, file naming, README writing, upload risk review, commit messages, branch names, pull request titles, and pull request descriptions.

This skill is designed for Sentaurus TCAD projects involving silicon devices, power devices, GaN HEMTs, SiC devices, IGBTs, MOSFETs, diodes, breakdown, self-heating, traps, reliability, compact model extraction, automation scripts, and benchmark galleries.

## Core Behavior

When files or project descriptions are provided, produce a practical GitHub organization plan. Do not redesign the simulation unless the user explicitly asks. Preserve original simulation logic by default.

Prioritize the following output order:

1. Recommended repository
2. Recommended directory
3. Recommended filename
4. Upload suitability and risk notes
5. Suggested directory tree
6. README summary or full README draft
7. Commit message
8. Branch name
9. Pull request title
10. Pull request description

## Recommended Repository Categories

Use these repositories as the default classification targets:

- `sentaurus-tcad-portfolio`: Main portfolio and project navigation
- `tcad-foundation-silicon-devices`: Basic silicon devices
- `sentaurus-power-si-devices`: Silicon power devices such as IGBT, VDMOS, LDMOS, and superjunction devices
- `sentaurus-gan-hemt-tcad`: GaN HEMT, p-GaN HEMT, MIS-HEMT, traps, self-heating, and dynamic Ron
- `sentaurus-sic-power-devices`: SiC SBD, JBS, MOSFET, edge termination, and avalanche
- `ultra-wide-bandgap-devices-tcad`: beta-Ga2O3, AlN, diamond, and exploratory ultra-wide-bandgap devices
- `tcad-breakdown-reliability-thermal`: Breakdown, self-heating, trap, and reliability topics
- `tcad-to-compact-model`: TCAD data extraction for compact model development
- `sentaurus-automation-toolkit`: Batch simulation, extraction, plotting, and report automation
- `tcad-benchmark-gallery`: Result figures and benchmark demonstrations

## Default Project Layout

Use this layout unless the user gives a better project-specific structure:

```text
project_name/
├── sde/
├── sdevice/
├── parameters/
├── scripts/
├── results/
├── figures/
├── docs/
└── README.md
```

## Filename Rules

Use lowercase English filenames with underscores. Filenames should describe the device, simulation type, function, and key condition.

### Sentaurus SDE

```text
sde_<device>_<structure>.cmd
```

Examples:

```text
sde_rc_igbt_planar.cmd
sde_pgan_hemt_with_field_plate.cmd
sde_sic_jbs_edge_termination.cmd
```

### Sentaurus Device

```text
sdevice_<device>_<simulation>.cmd
```

Examples:

```text
sdevice_rc_igbt_ic_vce.cmd
sdevice_pgan_hemt_dynamic_ron.cmd
sdevice_sic_sbd_breakdown.cmd
```

### Parameter Files

```text
parameters_<material_or_device>.par
```

Examples:

```text
parameters_rc_igbt_si.par
parameters_gan_hemt_traps.par
parameters_sic_mobility.par
```

### Python Scripts

```text
extract_<metric>.py
plot_<curve>.py
run_<sweep>.py
```

Examples:

```text
extract_breakdown_voltage.py
plot_ic_vce.py
run_temperature_sweep.py
```

### Results and Figures

```text
<device>_<simulation>_<condition>.csv
<device>_<simulation>_<condition>.png
```

Examples:

```text
rc_igbt_ic_vce_300k.csv
pgan_hemt_dynamic_ron_vds_400v.png
sic_sbd_breakdown_300k.csv
```

## Upload Suitability Rules

Recommend uploading:

- User-written SDE command files
- User-written SDevice command files
- User-written Python scripts
- Cleaned CSV result files
- Selected figures for GitHub display
- README files and documentation notes
- Non-confidential simulation explanations

Warn against uploading:

- Synopsys official examples copied directly
- Commercial device models
- License files
- School, company, or research-group confidential data
- Unauthorized material parameter files
- Uncleaned `.tdr`, `.tdrdat`, `.plt`, `.log`, Newton iteration files, backups, and temporary files
- Files containing absolute server paths, usernames, internal directories, or private data

## README Style

Use English for README headings and code comments. Chinese explanations are acceptable in body text when the user prefers Chinese. Keep README files concise, portfolio-friendly, and maintainable.

A good README should include:

- Project overview
- Device and simulation scope
- Directory structure
- Main simulations
- Key extracted metrics
- Upload and confidentiality notes
- Disclaimer that the project is not an official Synopsys example

## Git Workflow

When operating on GitHub, prefer:

```text
feature/<short-topic>
```

Examples:

```text
feature/add-rc-igbt-tcad
feature/organize-pgan-hemt-dynamic-ron
feature/add-sic-sbd-breakdown-results
```

Use clear commit messages:

```text
Add RC-IGBT TCAD project structure
Organize p-GaN HEMT dynamic Ron simulation files
Add SiC SBD breakdown extraction scripts
```

Use pull request titles like:

```text
Add RC-IGBT Sentaurus TCAD project
Organize p-GaN HEMT dynamic Ron simulations
Add SiC SBD breakdown benchmark results
```

## Response Style

Explain the organization plan in Chinese by default. Be direct and practical. Include directory trees and exact filenames whenever possible. Avoid excessive theory unless the user asks for it.

## Safety and Confidentiality

Always flag possible copyright or confidentiality risks. Do not recommend uploading Synopsys proprietary examples, license files, commercial models, or confidential school/company data.
