Create a DSM checkpoint document for this session.

## Steps

1. **Determine the current DSM version using a fallback chain:**
   a. Read `DSM_0.0_START_HERE_Complete_Guide.md` from the current working directory; extract the version from the header.
   b. If absent in CWD, resolve `dsm-central` from `.claude/dsm-ecosystem.md`. If it resolves to a path containing `DSM_0.0_START_HERE_Complete_Guide.md`, extract the version from there.
   c. If both reads fail (file missing in CWD AND no usable `dsm-central` resolution OR registry-resolved path lacks the file), warn `"Could not determine DSM version; checkpoint will use 'unknown'."` and use `vX.Y.Z=unknown` as a placeholder for the checkpoint filename. Do not halt; proceed with the remaining checkpoint steps.
2. Ask the user: "What is this checkpoint for?" (brief description)
2.5. **Identifier convention (per DSM_0.2.A §10.2.1):** while drafting the
   checkpoint body in Step 4, use resolvable identifiers: `§X.Y` or
   `DSM_X.Y §N` for section references; protocol or concept names (e.g.,
   "the Strongest Counter-Evidence requirement"); session or file
   references (e.g., `S194`, `dsm-docs/research/{file}.md`). Do NOT use
   bare BL numbers as identifiers in prose, bullets, next-steps, or
   key-decisions sections. Narrow exception: checkpoints specifically
   about an in-flight BL implementation MAY cite the BL number as the
   canonical artifact identifier (see §10.2.1 for the two-condition
   exception clause).
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

[What should be done next, authored causal-forward: for each item state what the
continuation requires and why, what it depends on, what order the dependencies
force, and what breaks if it is skipped. Not a flat task list.
Use resolvable identifiers per DSM_0.2.A §10.2.1: §X.Y, protocol/concept names,
session/file references. Not bare BL numbers.]

## Key Decisions

[Any decisions made during this session. Same identifier convention as above.]
```

## Causal-Forward Next Steps (Delegating face of Forward the Why, DSM_6.0 §1.13)

A checkpoint's Next Steps are read by a session that inherits only this document.
A flat list forwards the "what" and strands the "why", so the receiver re-derives
reasoning this session already holds, or re-opens a decision already settled
because nothing recorded that it was settled.

| Backward inventory (anti-pattern) | Causal-forward |
|---|---|
| "Done: rules module. Next: schema change, endpoint, workflow." | "Resume at the schema change, because `create_all` will not ALTER, so the stack must be up and the table recreated first; the endpoint and workflow follow because both consume the new columns." |

The form is longer by exactly the causal links the receiver would otherwise
rebuild, and no longer. An item with no dependency, ordering constraint, or
consequence-if-skipped is stated plainly; inventing rationale to satisfy the shape
is the failure mode, not compliance with it.

**Composition with the Step 2.5 identifier convention.** The two rules operate on
different axes and do not conflict: the identifier convention governs how a
dependency is *named*, causal-forward governs whether the dependency is *stated at
all*. Express the causal link and name its target with a resolvable identifier, a
concept or protocol name, a `§X.Y` reference, or a file or session reference,
rather than a bare BL number. "Do the template change before the cadence rule,
because the cadence rule describes the template" satisfies both; "BL-477 after
BL-474" satisfies neither cleanly.

5. After creating the file, stage it with `git add` but do NOT commit (let the user decide when to commit)
