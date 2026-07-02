# GitHub Handoff Probe

This is a connector feasibility probe for the Sentaurus external GPT handoff workflow.

Source local handoff archive used for shape only:

`D:\sentaurus_gpt_handoff\Trench-IGBT\dryrun_switch_n14_20260702_170737`

Expected text payload types for real handoff:

- `n14_des.out`
- `switch_des.cmd`
- `sde_dvs.cmd`
- `prompt_draft.md`
- `bundle_manifest.json`

Diagnostic binary payloads such as `.tdr` require either Git data API tree/commit support or a fallback zip/artifact strategy.

Probe status: OK.
