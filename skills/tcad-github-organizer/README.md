# TCAD GitHub Organizer Skill

A reusable skill for organizing Sentaurus TCAD files into clean, maintainable GitHub repositories.

## What This Skill Does

This skill helps turn scattered Sentaurus TCAD files into a professional repository structure. It is intended for TCAD projects involving silicon power devices, GaN HEMTs, SiC devices, IGBTs, MOSFETs, diodes, breakdown, self-heating, traps, reliability, compact model extraction, automation scripts, and benchmark figures.

## Main Use Cases

- Classify TCAD files into the right repository and folder
- Rename messy files into readable lowercase snake_case names
- Build a maintainable GitHub directory structure
- Decide which files are suitable for open-source upload
- Generate README files, directory notes, and documentation drafts
- Generate branch names, commit messages, PR titles, and PR descriptions
- Warn about proprietary, confidential, or oversized files

## Skill Layout

```text
tcad-github-organizer/
├── SKILL.md
├── README.md
├── skill.json
├── examples/
├── templates/
├── scripts/
└── tests/
```

## Example Request

```text
我现在有一个 RC-IGBT Sentaurus TCAD 项目，里面有 SDE、SDevice、参数文件、Python 后处理脚本和仿真结果图。帮我整理成适合上传 GitHub 的仓库结构。
```

## Expected Output

The skill should produce:

1. Recommended repository
2. Recommended directory
3. Recommended filenames
4. Upload suitability review
5. Directory tree
6. README draft
7. Commit message
8. Branch name
9. Pull request title
10. Pull request description

## Open-Source Notes

Before publishing TCAD projects, review files carefully and avoid uploading:

- Synopsys official examples copied directly
- Commercial models
- License files
- Confidential school/company/research-group data
- Unauthorized material parameter files
- Large intermediate simulation files such as `.tdr`, `.plt`, `.tdrdat`, and Newton iteration files

## License

MIT License. See `LICENSE` for details.
