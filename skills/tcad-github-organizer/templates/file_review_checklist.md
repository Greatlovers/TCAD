# TCAD File Review Checklist

Use this checklist before uploading Sentaurus TCAD projects to GitHub.

## Suitable for Upload

- [ ] User-written SDE command files
- [ ] User-written SDevice command files
- [ ] User-written parameter files without confidential data
- [ ] User-written Python post-processing scripts
- [ ] Cleaned CSV result files
- [ ] Selected figures for documentation
- [ ] README files and notes

## Review Carefully

- [ ] Material parameter files
- [ ] Calibrated device parameters
- [ ] Files derived from papers or internal projects
- [ ] Any file containing absolute local/server paths
- [ ] Any file containing personal, school, company, or lab information

## Do Not Upload

- [ ] Synopsys official examples copied directly
- [ ] Commercial device models
- [ ] License files
- [ ] Confidential data
- [ ] Large intermediate files: `.tdr`, `.tdrdat`, `.plt`
- [ ] Logs, Newton iteration files, backups, and temporary files

## Common Cleanup Commands

```bash
find . -name "*.log" -delete
find . -name "*_Newton_*.tdr" -delete
find . -name "*.bak" -delete
find . -name "*.old" -delete
```
