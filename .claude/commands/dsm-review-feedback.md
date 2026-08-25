Review feedback from a completed DSM spoke project.

**Audience:** Run only in DSM Central. This skill triages spoke feedback that does not apply in standalone TAB or other spokes.

**Early-stop:** If `plan/backlog/` does not exist in the current working directory, refuse with: `"Run only in DSM Central; this skill triages spoke feedback that does not apply here."` Do not proceed.

## Input

The user provides the project path (e.g., `~/sql-query-agent-ollama`).

## Steps

Feedback exists in **two shapes**, and this skill reads both. The naming mirrors
`/dsm-wrap-up` Step 6 deliberately, so the skill that writes feedback and the skill
that consumes it describe the same shapes in the same terms.

1. **Per-session files (current shape).** Scan `{project-path}/dsm-docs/feedback-to-dsm/`
   for every file matching `YYYY-MM-DD_sN_*.md` that is NOT in `done/`. Read
   newest-first. A project may carry several, or files of one kind and none of the
   other; do not assume a matched pair. Files already in `done/` were pushed to Central
   by the spoke's own wrap-up and are out of scope here unless the user asks for them
   by name.

   **Match on the date-and-session prefix, not on the suffix.** `_backlogs` and
   `_methodology` are the two suffixes the convention names, but spokes also write
   topically-named per-session feedback: measured 2026-08-24, the portfolio carries
   `2026-07-25_s130_reasoning-lessons-intake-cap.md` and
   `2026-07-25_s130_staa-gitignore-assumption.md`, both carrying the full feedback
   header (Date / Session / Spoke / Type / Severity). A suffix-specific scan reads
   neither. Classify by suffix *after* matching, so a topical file is read and reported
   rather than silently skipped.
2. **Technical progress.** Read `technical.md` if present. It is genuinely append-only
   and is NOT legacy; it uses the `**Pushed:**` marker model by design.
3. **Legacy files (still live, not vestigial).** Read the bare
   `feedback-to-dsm/backlogs.md` and `feedback-to-dsm/methodology.md` if they exist, and
   label them as legacy in the report. This is not a deprecated afterthought: measured
   2026-08-24, the External Contribution project `IronCalc` carries 282 lines of
   `backlogs.md` and 832 lines of `methodology.md` in exactly this shape, and it is the
   kind of project this skill exists to review. `/dsm-wrap-up` Step 6c carries the same
   fallback for the same reason.
4. **Other artifacts.** Read `blog.md` if it exists, plus any finalization artifacts
   (see Finalization Context below).

**Report what was read, before triaging anything.** Name every file read, with its line
count, and say explicitly when a category was empty:

```
Feedback read from {project-path}:
  per-session (backlogs/methodology): 2026-08-04_s58_backlogs.md (150 lines), 2026-08-04_s58_methodology.md (88 lines)
  per-session (topical):              (none)
  technical:                          (none)
  legacy / project-lifecycle:         (none)
  other:                              (none)
```

An empty read must never look like an empty inbox. Before this step existed, a project
with no feedback and a project whose feedback the skill could not find produced the same
empty triage table, which is DSM_0.2 §19.1's second question failing at the skill grain:
a wrong result looked exactly like a right one. If **every** category is empty, say
"No feedback files found at {path}" and stop; do not present an empty triage table.

## Triage Backlog Proposals

For each proposal in the backlog-proposal files read in Steps 1 and 3:

1. **Check for duplicates:** Search **both** backlog trees for existing items that address the same issue, `dsm-docs/plans/` (including `done/`) and `plan/backlog/` (all subdirectories including `done/`). Searching the legacy tree alone misses every item filed since the migration and reports a genuine duplicate as novel
2. **Decide:**
   - **Accept:** Create a new BACKLOG-XXX file using the `/dsm-backlog` template
   - **Reject:** Note the reason (already addressed, out of scope, insufficient evidence)
   - **Defer:** Note the dependency or prerequisite
3. Present the triage table to the user for approval before creating any files

## Assess Methodology Scores

For each entry with an average score below 3, across every methodology file read in
Steps 1 and 3:

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
