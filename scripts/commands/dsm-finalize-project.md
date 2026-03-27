Execute the DSM project finalization protocol. Runs after the final `/dsm-wrap-up` of a completed project to capture cross-session knowledge, run retrospectives, and archive project artifacts. $ARGUMENTS

**IMPORTANT:** This is a project-end skill, not a session-end skill. Do NOT run this during regular sessions. The project's final `/dsm-wrap-up` must be complete (committed, pushed, merged) before finalization begins. May run in the same session as the final wrap-up or in a dedicated session.

## Prerequisites

Before starting, verify:
1. The most recent session was wrapped up (`/dsm-wrap-up` completed)
2. No open Level 3 branches remain for this project
3. The working tree is clean (`git status --porcelain` returns empty)

If any prerequisite fails, stop and explain what needs to be resolved first.

## Project Size Detection

Classify the project to determine which checklist sections are required:

1. Count session transcripts in `.claude/transcripts/` (or fall back to handoffs in `dsm-docs/handoffs/`)
2. Classify:
   - **Small (1-3 sessions):** Sections D, E, G, H, I required; B, C optional
   - **Medium (4-10 sessions):** Sections A, B, D, E, G, H, I required; C, F optional
   - **Large (10+ sessions):** All sections required
3. Report: "This is a [size] project ([N] sessions). Required sections: [list]. Optional: [list]."
4. Ask the user: "Include optional sections? (y/n/pick)"

## Steps

Run sections in the order below. Sections marked with the project size minimum are skippable for smaller projects per the scaling table above.

### A. Knowledge Extraction (medium+)

**Context budget gate:** Count total lines across all transcripts in `.claude/transcripts/`. If the total exceeds 2000 lines, present options before proceeding:
- (a) Full analysis of all transcripts (high context cost)
- (b) Sample only sessions flagged "STAA recommended: yes" in reasoning lessons
- (c) Sample the 3 most recent and 3 longest transcripts
- (d) Defer to a dedicated STAA session

Then:

1. **Project-level STAA:** Analyze archived transcripts for cross-session patterns that per-session auto-extraction missed. Look for:
   - Recurring decision types across sessions
   - Methodology gaps that appeared repeatedly
   - Techniques or approaches that evolved over the project
   - Collaboration patterns (human-agent interaction quality over time)
   Save findings to `dsm-docs/feedback-to-dsm/YYYY-MM-DD_project-staa.md`.

2. **Reasoning lesson routing:** Read `.claude/reasoning-lessons.md` and classify each entry:
   - **Project-specific** (`project` scope): Leave in place or move to archive
   - **DSM-methodology-relevant** (`ecosystem`/`pattern` scope): Push to DSM Central's inbox as a structured feedback entry, referencing the spoke's reasoning-lessons file as source
   Format the inbox entry per DSM_0.2 Module A (Reasoning Lessons Protocol).

3. **Final feedback push:** Scan `dsm-docs/feedback-to-dsm/` for any files NOT in `done/`. For each unpushed file, push to DSM Central's inbox and move the source to `done/`. This catches anything the session-end pushes missed.

### B. Retrospective (medium+)

1. **Project retrospective:** Create `dsm-docs/feedback-to-dsm/YYYY-MM-DD_project-retrospective.md` using the Project Retrospective Template (see Templates section below).
   - Fill in sections by reading the project's README, MEMORY.md, feedback files, and decision log
   - Present the draft to the user for review before saving

2. **Epoch retrospective check:** If the project used epoch-based sprints, check whether all epoch boundaries have retrospectives. For any missing epoch retrospective, create it using the Epoch Retrospective Template (see Templates section below).

3. **Push retrospective to DSM Central:** Append a summary inbox entry to `{dsm-central-path}/_inbox/{this-project-name}.md`:
   ```
   ### [YYYY-MM-DD] Project retrospective: {project-name}

   **Type:** Methodology Observation
   **Priority:** Medium
   **Source:** {project-name}

   Project finalized. [1-2 sentence summary of key findings].
   Full retrospective: {project-path}/dsm-docs/feedback-to-dsm/YYYY-MM-DD_project-retrospective.md
   ```

### C. Communication (large only, optional for medium)

1. **Blog content:** Check `dsm-docs/blog/` for draft or seed posts. Ask the user:
   - "Create a final blog post or case study summarizing the project? (y/skip)"
   - If yes, create a seed file in `dsm-docs/blog/YYYY-MM-DD_retrospective-{project-name}.md` with an outline based on the project retrospective
2. **Case study:** If the project produced notable results, ask: "Flag this as an exemplary case study for the portfolio? (y/n)"

### D. Documentation Closure (all sizes)

1. **README review:** Read `README.md` and check:
   - Project description reflects final state (not "in progress" language)
   - Status section updated to "Complete" or "Archived"
   - Outcomes/results section populated
   - No stale references to in-progress work
   Present proposed changes to the user before editing.

2. **Decision log closure:** If a decision log exists (`dsm-docs/decisions/` or similar), check for open decisions without resolution. Flag any that need closing.

3. **Guides review:** Scan `dsm-docs/guides/` for references to in-progress work or future plans that are now resolved. Flag stale content.

4. **Research closure:** If `dsm-docs/research/` contains active research files (not in `done/`), move completed research to `dsm-docs/research/done/` with outcome references.

### E. Backlog Cleanup (all sizes)

1. **Triage remaining items:** Read the backlog README and list all open items. For each:
   - **Close:** If completed but not moved to done/, run the equivalent of `/dsm-backlog-done`
   - **Defer:** If valuable but not for this project, move to `plan/backlog/deferred/` with a Reason field
   - **Transfer:** If relevant to another project, note the target project for manual transfer
   - **Drop:** If no longer relevant, move to done/ with Status: Dropped
   Present the triage table to the user for approval before acting.

2. **Backlog README:** Update to reflect final state (should be empty or minimal after triage).

### F. Vocabulary Transfer (large only, optional for medium)

1. Scan decision records, feedback files, and blog posts for coined terms or recurring domain-specific language
2. Flag candidates for DSM vocabulary intake
3. Push candidates to DSM Central's inbox as a vocabulary proposal entry

### G. Profile and Registry (all sizes)

1. **Contributor profile:** Read `.claude/contributor-profile.md` and assess skills exercised across the entire project (cross-reference with feedback files and session artifacts). Update proficiency levels if warranted. Present changes to the user before editing.

2. **Project registry:** Remind the user: "Update DSM_3 Section 7 project registry to mark this project as complete."

3. **Portfolio notification:** Send a project completion milestone to the portfolio inbox:
   ```
   ### [YYYY-MM-DD] Project completed: {project-name}

   **Type:** Notification
   **Priority:** Medium
   **Source:** {project-name}

   Project finalized after [N] sessions. [1-sentence summary of outcomes].
   ```
   Target: `{portfolio-path}/_inbox/{this-project-name}.md` (from Ecosystem Path Registry).

### H. Archive (all sizes)

1. **Transcripts:** Move all files from `.claude/transcripts/` to `.claude/transcripts/done/`. Create `done/` if it does not exist.
2. **Reasoning lessons:** Append `**Finalized:** YYYY-MM-DD` as a header line at the top of `.claude/reasoning-lessons.md`.
3. **Feedback files:** Move all remaining files in `dsm-docs/feedback-to-dsm/` (except `done/` contents) to `dsm-docs/feedback-to-dsm/done/`.
4. **Handoffs:** If `dsm-docs/handoffs/` contains active handoffs, move them to `dsm-docs/handoffs/done/` (project is complete, no continuation needed).

### I. Environment and Data Cleanup (all sizes)

**Gate:** Verify that Section A (Knowledge Extraction) is complete before deleting any transcripts or data. Do NOT delete transcripts that have not been analyzed.

1. **Virtual environment:** Check for `.venv/`, `venv/`, or project-specific env directories. If found, ask: "Delete virtual environment at {path}? (y/n)"
2. **Data artifacts:** Check for `data/raw/`, `data/interim/`, downloaded datasets. If found, ask: "Delete raw/intermediate data? Processed results (`data/results/`, `data/final/`) and sample data (`data/sample/`) will be retained. (y/n)"
3. **Build artifacts:** Delete `__pycache__/`, `.pytest_cache/`, `dist/`, `build/` without asking (these are always safe to remove).
4. **Gitignore verification:** Check `.gitignore` excludes all deleted artifact types to prevent accidental re-creation.

## Templates

### Epoch Retrospective Template

```markdown
# Epoch N Retrospective

**Project:** [project name]
**Epoch:** N
**Sprints covered:** [sprint range]
**Date:** YYYY-MM-DD

## What worked across sprints
- [Cross-sprint patterns that proved effective]

## What didn't work
- [Approaches that required mid-epoch course corrections]

## Methodology effectiveness
- [Which DSM sections were most/least useful at epoch scale]
- [Any gaps that appeared repeatedly across sprints]

## Key decisions and outcomes
- [DEC-NNN references with retrospective assessment: was the decision right?]

## Recommendations for DSM
- [Backlog proposals or methodology observations, if any]
```

### Project Retrospective Template

```markdown
# Project Retrospective: [project name]

**Date:** YYYY-MM-DD
**Duration:** [start date] to [end date]
**Sessions:** [count]
**Project type:** [spoke / external contribution / private]

## Project summary
- [What was built, one paragraph]

## DSM effectiveness across the project
- [Which DSM tracks were used: 1.0, 4.0, both]
- [Overall methodology score: how well did DSM serve this project?]

## Phase-level assessment
| Phase | What worked | What was missing |
|-------|------------|-----------------|
| Research/Grounding | | |
| Planning | | |
| Implementation | | |
| Communication | | |

## Cross-project transferability
- [What patterns from this project should inform other projects?]
- [What was project-specific and should NOT be generalized?]

## Recommendations for DSM
- [Backlog proposals, methodology observations, vocabulary candidates]
```

## Notes

- No co-author lines in commits
- No session transcript entries (this may run outside a regular session)
- Resolve cross-repo paths from the Ecosystem Path Registry (`.claude/dsm-ecosystem.md`)
- If `dsm-central` path is not configured, warn and skip all inbox pushes
- If `portfolio` path is not configured, warn and skip portfolio notification
- Existing skills handle sub-tasks: `/dsm-staa` for deep transcript analysis, `/dsm-review-feedback` for structured feedback triage, `/dsm-backlog-done` for individual BL closure
- Follow `.claude/CLAUDE.md` conventions for this project (punctuation, text conventions, format rules)
- The finalization commit message format: "Project finalization: [project-name] ([N] sessions)"
