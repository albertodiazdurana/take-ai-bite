Create a DSM checkpoint document for this session.

## Steps

1. Read `DSM_0_START_HERE_Complete_Guide.md` to get the current version number from the header
2. Ask the user: "What is this checkpoint for?" (brief description)
3. Get today's date in YYYY-MM-DD format
4. Create the checkpoint file at `docs/checkpoints/YYYY-MM-DD_vX.Y.Z_description_checkpoint.md`

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
