Create a DSM checkpoint document for this session.

## Steps

1. **Determine the current DSM version using a fallback chain (BL-236e):**
   a. Read `DSM_0.0_START_HERE_Complete_Guide.md` from the current working directory; extract the version from the header.
   b. If absent in CWD, resolve `dsm-central` from `.claude/dsm-ecosystem.md`. If it resolves to a path containing `DSM_0.0_START_HERE_Complete_Guide.md`, extract the version from there.
   c. If both reads fail (file missing in CWD AND no usable `dsm-central` resolution OR registry-resolved path lacks the file), warn `"Could not determine DSM version; checkpoint will use 'unknown'."` and use `vX.Y.Z=unknown` as a placeholder for the checkpoint filename. Do not halt; proceed with the remaining checkpoint steps.
2. Ask the user: "What is this checkpoint for?" (brief description)
3. Get today's date in YYYY-MM-DD format
4. Create the checkpoint file at `dsm-docs/checkpoints/YYYY-MM-DD_vX.Y.Z_description_checkpoint.md`

## Checkpoint Template

Use this structure:

```markdown
# Checkpoint: vX.Y.Z [Description]

**Date:** YYYY-MM-DD
**Version:** vX.Y.Z
**Session Focus:** [user's description]

---

## What Was Done

[Summarize work completed this session]

## Current State

[Describe the current state of the project]

## Next Steps

[What should be done next]

## Key Decisions

[Any decisions made during this session]
```

5. After creating the file, stage it with `git add` but do NOT commit (let the user decide when to commit)
