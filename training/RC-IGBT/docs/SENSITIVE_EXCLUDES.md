# Sensitive Excludes

This public package intentionally excludes:

- Sentaurus material parameter files: `*.par`, `sdevice.par`, `Silicon.par`, `Oxide.par`, `PolySi.par`, `pp*.par`.
- Backup directories: `backup_codex_*`.
- Temporary editor files: `*~`.
- Runtime logs/jobs with host paths or process details: `*.log`, `*.out`, `*.job`.
- License files, material databases, `MaterialDB`, `datexcodes`, tokens, passwords, and personal/server absolute paths.

The project can be inspected with the included decks and results. Re-running requires a legal local Sentaurus installation and local material parameter files.

Additional public-safety exclusion: raw `*.tdr` and `*.sav` binary states were omitted after byte-level scans found embedded local VM/Sentaurus installation paths.
