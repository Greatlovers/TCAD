## Summary

This PR adds or reorganizes a Sentaurus TCAD project for `<project_name>`.

## Added / Updated Contents

- Structure generation files in `sde/`
- Device simulation files in `sdevice/`
- Parameter files in `parameters/`
- Post-processing scripts in `scripts/`
- Cleaned result files in `results/`
- Selected figures in `figures/`
- Documentation in `docs/`

## File Organization Notes

- Files are named using lowercase English and underscores.
- Simulation files are separated by device and simulation type.
- Generated intermediate files are excluded from version control.

## Upload Safety Review

The PR should not include:

- Synopsys official examples copied directly
- Commercial device models
- License files
- Confidential school/company/research-group data
- Unauthorized material parameter files
- Large `.tdr`, `.tdrdat`, `.plt`, `.log`, or Newton iteration files

## Checklist

- [ ] File names follow the repository naming convention
- [ ] README is updated
- [ ] Generated intermediate files are excluded
- [ ] Confidential paths or private data are removed
- [ ] Figures and CSV results are cleaned and representative
