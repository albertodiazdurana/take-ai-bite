Review feedback from a completed DSM spoke project.

**Audience:** Run only in DSM Central. This skill triages spoke feedback that does not apply in standalone TAB or other spokes.

**Early-stop:** If `plan/backlog/` does not exist in the current working directory, refuse with: `"Run only in DSM Central; this skill triages spoke feedback that does not apply here."` Do not proceed.

## Input

The user provides the project path (e.g., `~/sql-query-agent-ollama`).

## Steps

1. Read `{project-path}/dsm-docs/feedback-to-dsm/backlogs.md`
2. Read `{project-path}/dsm-docs/feedback-to-dsm/methodology.md`
3. Read `{project-path}/dsm-docs/feedback-to-dsm/blog.md` (if it exists)

## Triage Backlog Proposals

For each proposal in `backlogs.md`:

1. **Check for duplicates:** Search `plan/backlog/` (all subdirectories including `done/`) for existing items that address the same issue
2. **Decide:**
   - **Accept:** Create a new BACKLOG-XXX file using the `/dsm-backlog` template
   - **Reject:** Note the reason (already addressed, out of scope, insufficient evidence)
   - **Defer:** Note the dependency or prerequisite
3. Present the triage table to the user for approval before creating any files

## Assess Methodology Scores

For each entry in `methodology.md` with an average score below 3:

1. Check if the gap is already covered by an accepted backlog proposal
2. If not, assess whether a separate DSM improvement is warranted
3. Present findings to the user

## Output

Present a summary table:

```
| # | Proposal | Decision | Reason | BACKLOG |
|---|----------|----------|--------|---------|
| 1 | [title]  | Accept   | [why]  | XXX     |
| 2 | [title]  | Reject   | [why]  | —       |
| 3 | [title]  | Defer    | [why]  | —       |
```

Then create accepted BACKLOG items and confirm with the user.

## Finalization Context

If the project has been finalized (`/dsm-finalize-project`), the feedback
directory may contain additional artifacts from finalization: a project-level
STAA file (`*_project-staa.md`) and a project retrospective
(`*_project-retrospective.md`). Process these alongside the standard
methodology and backlog files.

**Recommended sequence for project closure:**
1. Final `/dsm-wrap-up` in the spoke project
2. `/dsm-finalize-project` in the spoke project
3. `/dsm-review-feedback` in DSM Central (triages all feedback including
   finalization outputs)

See DSM_3 Module F (Project Finalization Protocol) for the full protocol.
