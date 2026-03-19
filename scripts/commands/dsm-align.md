Align a DSM spoke project's folder structure with the canonical standard and push unpushed feedback to DSM Central. Idempotent: safe to run on new or existing projects. Creates missing folders, adds missing done/ subfolders, installs template files, detects naming collisions, checks file lifecycle compliance, and pushes ripe feedback.

## Git Pre-Step: Ensure Git Initialized

Before starting alignment, check if git is initialized:

1. Run: `git rev-parse --is-inside-work-tree 2>/dev/null`
2. If **not** a git repo:
   a. Run: `git init`
   b. Run: `git branch -m main`
   c. Ask: "Remote repository? (GitHub URL or 'none' for local-only)"
   d. If URL provided: `git remote add origin {url}`
   e. Create initial commit: `git add .` then `git commit -m "Initialize DSM project"`
   f. Report: "Git initialized. All DSM projects require a local git repository."
3. Continue to Step 1 below.

## Steps

1. **Detect project type** using DSM_0.2 Project Type Detection table:
   - `notebooks/` only, no `src/` → Data Science (DSM 1.0)
   - `src/`, `tests/`, `app.py` → Application (DSM 4.0)
   - Both `notebooks/` and `src/` → Hybrid
   - `dsm-docs/`, markdown-only, no `notebooks/` or `src/` → Documentation (DSM 5.0)
   - `contributions-docs/{project}/` in DSM Central → External Contribution (DSM_3 Section 6.6)
   State the detected type.

2. **Check and fix `_inbox/` at project root:**
   - If `dsm-docs/backlog/` exists: move to `_inbox/` at project root. Send migration confirmation to DSM Central's inbox (`~/dsm-agentic-ai-data-science-methodology/_inbox/{project-name}.md`).
   - If `dsm-docs/inbox/` exists: move to `_inbox/` at project root. Send migration confirmation to DSM Central's inbox.
   - If `_inbox/` does not exist: create it.
   - If `_inbox/done/` does not exist: create it.
   - If `_inbox/README.md` does not exist: create it from the Inbox Template below.

3. **Check and fix each canonical dsm-docs/ folder.** For each folder in the table below:
   a. Check if it exists. If missing, create it.
   b. Check for name collisions (e.g., `plan/` when canonical is `dsm-docs/plans/`, or `docs/checkpoint/` when canonical is `dsm-docs/checkpoints/`). If collision found, **report to user** but do NOT auto-rename.
   c. If the folder should have `done/`: check `done/` exists inside it. Create if missing.
   d. If the folder should have a template file: check if it exists. Create from templates below if missing.

   | Folder | Has done/? | Template file(s) |
   |--------|-----------|-------------------|
   | `plan/backlog/` | Yes | README.md |
   | `dsm-docs/blog/` | Yes | journal.md |
   | `dsm-docs/checkpoints/` | Yes | README.md |
   | `dsm-docs/decisions/` | No | None |
   | `dsm-docs/feedback-to-dsm/` | Yes | README.md |
   | `dsm-docs/guides/` | No | None |
   | `dsm-docs/handoffs/` | Yes | README.md |
   | `dsm-docs/plans/` | Yes | README.md |
   | `dsm-docs/research/` | Yes | README.md |

4. **Check feedback file compliance:**
   - `dsm-docs/feedback-to-dsm/` should contain per-session files (`YYYY-MM-DD_sN_backlogs.md`, `YYYY-MM-DD_sN_methodology.md`), `technical.md`, `README.md`, and `done/`
   - If legacy `backlogs.md` or `methodology.md` exist (append-only format), **report as warning**: "Legacy feedback files found (`backlogs.md` / `methodology.md`). Consider migrating to per-session format: split entries into `YYYY-MM-DD_sN_{type}.md` files and move originals to `done/`."
   - If `dsm-docs/feedback-to-dsm/README.md` does not exist, create from Feedback README Template below
   - Do NOT auto-delete or auto-migrate legacy files; report for user action.

5. **Check for consumed handoffs:**
   - List files in `dsm-docs/handoffs/` (excluding `done/` and `.gitkeep`)
   - If any handoff files exist that are NOT from the current session, **report as warning**: "Consumed handoff(s) found outside done/. Run `/dsm-go` to move them, or move manually."
   - Do NOT auto-move; report for user action.

6. **Push unpushed feedback to DSM Central:**
   The DSM Central repo path is the parent directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@` import in this project's CLAUDE.md. Target: `{dsm-central-path}/_inbox/{this-project-name}.md`.
   a. **Per-session files:** Scan `dsm-docs/feedback-to-dsm/` for files matching `YYYY-MM-DD_sN_backlogs.md` or `YYYY-MM-DD_sN_methodology.md` that are NOT in `done/`. For each ripe file (see DSM_0.2 Session-End Inbox Push ripe criteria), append its content to the inbox file and move the source to `dsm-docs/feedback-to-dsm/done/`.
   b. **Legacy files:** If `dsm-docs/feedback-to-dsm/backlogs.md` or `dsm-docs/feedback-to-dsm/methodology.md` exist with unpushed entries, push using the old `**Pushed:**` marker model.
   c. **Technical progress:** Scan `dsm-docs/feedback-to-dsm/technical.md` for entries without a `**Pushed:**` date. Push using the `**Pushed:**` marker model.
   d. Group all entries under a single inbox entry header:
      ```
      ### [YYYY-MM-DD] Feedback from {project-name}

      **Type:** Methodology Observation
      **Priority:** Medium
      **Source:** {project-name}

      [backlog proposals + methodology scores, grouped by type]
      ```
   e. If no pushable entries exist, skip this step.
   f. Do NOT push entries that lack structure (no problem statement, no score).
   g. Report pushed count in the report.

7. **Validate CLAUDE.md `@` reference:**
   - Read `.claude/CLAUDE.md` (if it exists)
   - Check for an `@` line referencing `DSM_0.2_Custom_Instructions_v1.1.md`
   - If missing: **report as critical warning**: "No `@` reference to DSM_0.2 found in CLAUDE.md. Without it, all inherited DSM protocols are silently disabled."
   - If present but the path does not resolve to an existing file: **report as critical warning**: "Stale `@` reference, DSM_0.2 path does not exist: [path]"
   - If valid: report "CLAUDE.md `@` reference OK"
   - Do NOT auto-fix; report for user action (path depends on local filesystem layout)

8. **Check `.gitattributes`:**
   - If `.gitattributes` does not exist at project root: create it with the template below.
   - If it exists: check that it contains `* text=auto eol=lf`. If missing, **report as warning**: "`.gitattributes` exists but does not enforce LF line endings. CRLF can break the Edit tool on WSL."
   - Report result in the summary.

9. **Check .claude/ files:**
   - If `.claude/session-transcript.md` does not exist: create it (empty file).
   - If `.claude/dsm-ecosystem.md` does not exist: create it from the Ecosystem Pointers Template below. Resolve `dsm-central` path from the `@` reference in `.claude/CLAUDE.md`. Leave `portfolio` path as a placeholder for the user to fill in. Report: "Created `.claude/dsm-ecosystem.md` with ecosystem pointers. Update the `portfolio` path."

10. **Check command file drift (DSM Central only):**
   - Skip this step if the project is not DSM Central (no `scripts/commands/` directory).
   - For each `.md` file in `scripts/commands/`:
     - Compare against `~/.claude/commands/{same filename}` using `diff -q`
     - If identical: count as OK
     - If different: **report as warning**: "Command {name} has drifted from tracked source. Review and resolve: update tracked source or run `scripts/sync-commands.sh --deploy`."
     - If runtime copy missing: **report as warning**: "Command {name} exists in tracked source but not in ~/.claude/commands/. Run `scripts/sync-commands.sh --deploy` to install."
   - Report drift summary in the report.
   - Reference: BACKLOG-130 (Command File Version Tracking)

11. **Report** results in this format:
   ```
   /dsm-align report:
   - Project type: [detected type]
   - Created: [list of folders and files created]
   - Already correct: [count of items that needed no changes]
   - Fixed: [list of repairs made]
   - Collisions: [list of naming conflicts for user to resolve, or "none"]
   - Warnings: [feedback file violations, consumed handoffs, or "none"]
   - .gitattributes: [OK | Created | Warning: missing LF enforcement]
   - Command sync: [OK: N | Drifted: N | Missing: N, or "N/A (not DSM Central)"]
   - Feedback pushed: [count of entries pushed to DSM Central, or "none pending"]
   ```

12. **Persist report:** Write the alignment report to `dsm-docs/decisions/YYYY-MM-DD_sN_align-report.md`
   so it survives session end. The file uses this header:
   ```markdown
   # Alignment Report — Session N

   **Date:** YYYY-MM-DD
   **Project:** [project name]
   **Project type:** [detected type]

   ---
   ```
   Followed by the full report from Step 11. This step is silent (no user approval
   needed); the file is a mechanical record of the alignment check.

## Templates

### Inbox Template (`_inbox/README.md`)

```markdown
# Project Inbox

Transit point for hub-spoke communication. Entries arrive, get processed, and
are removed. Reference: DSM_3 Section 6.4.

## Entry Template

### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

### Git Attributes Template (`.gitattributes`)

```
# Enforce LF line endings for all text files.
# Prevents CRLF issues on WSL that break the Edit tool.
* text=auto eol=lf
```

### Spoke Backlog Template (`plan/backlog/README.md`)

```markdown
# Project Backlog

Enhancement proposals and technical debt items for this project.
Completed items move to `done/`.

| BL# | Title | Priority |
|-----|-------|----------|
```

### Blog Journal Template (`dsm-docs/blog/journal.md`)

```markdown
# Blog Journal

Append-only capture file for blog-worthy observations. Entries accumulate
across sessions and are extracted into materials files at project/epoch end.
Reference: DSM_0.1 Blog Artifacts (three-document pipeline).

## Entry Template

### [YYYY-MM-DD] {Title}
{Observation, story, pattern, or insight}
```

### Feedback README Template (`dsm-docs/feedback-to-dsm/README.md`)

```markdown
# DSM Feedback

Per-session feedback files with a lifecycle. Each session creates its own
file(s); processed files move to `done/`.

## File Types

| File pattern | Content | Lifecycle |
|-------------|---------|-----------|
| `YYYY-MM-DD_sN_backlogs.md` | Backlog proposals for DSM | Per-session -> done/ |
| `YYYY-MM-DD_sN_methodology.md` | Methodology effectiveness scores | Per-session -> done/ |
| `technical.md` | Technical progress reports | Append-only + Pushed marker |

## Lifecycle

1. **Create:** Agent writes feedback during session
2. **Notify:** At wrap-up, inbox notification to DSM Central references the file
3. **Process:** DSM Central reads and acts on the feedback
4. **Done:** Processed file moves to `done/`

Only create a file when there is feedback to record. No empty files.
Reference: DSM_0.2 DSM Feedback Tracking.
```

### Checkpoints README Template (`dsm-docs/checkpoints/README.md`)

```markdown
# Checkpoints

Milestone snapshots with detailed context (rationale, session state, next steps).
Consumed at next session start and moved to `done/`.
Reference: DSM_0.2 (via /dsm-go Step 3.5).

## Naming

`YYYY-MM-DD_vX.Y.Z_release_checkpoint.md` or `YYYY-MM-DD_sN_{description}.md`
```

### Handoffs README Template (`dsm-docs/handoffs/README.md`)

```markdown
# Handoffs

Session-end resumption documents. Created when a session has complex pending
work that the next session needs to continue. Consumed at next session start
and moved to `done/`.
Reference: DSM_0.2 (via /dsm-go Step 3).

## Naming

`YYYY-MM-DD_{description}.md` or `YYYY-MM-DD_sN_{description}.md`
```

### Plans README Template (`dsm-docs/plans/README.md`)

```markdown
# Plans

Sprint plans, project plans, and phase plans. Completed plans move to `done/`.
Reference: DSM_2.0 (PM Guidelines).

## Naming

`YYYY-MM-DD_{plan-type}.md` or descriptive name (e.g., `sprint-3-plan.md`)
```

### Research README Template (`dsm-docs/research/README.md`)

```markdown
# Research

Research files from Phase 0.5 and ad-hoc research. Processed research moves
to `done/` after findings are integrated into the target outcome.
Reference: DSM_0.2 Module D (Phase 0.5: Research and Grounding).

## Naming

`YYYY-MM-DD_{topic}_research.md`

## Lifecycle

1. Create during research phase with standard header (Purpose, Target Outcome, Status)
2. Integrate findings into sprint plan or deliverables
3. Move to `done/` with Status: Done and Date Completed
```

### Ecosystem Pointers Template (`.claude/dsm-ecosystem.md`)

```markdown
# DSM Ecosystem Path Registry

Local configuration mapping logical ecosystem names to filesystem paths.
This file is gitignored and instance-specific.

## Paths

| Name | Path | Description | Mirror |
|------|------|-------------|--------|
| dsm-central | {resolved from @ reference} | Hub repository | - |
| portfolio | {UPDATE THIS PATH} | Portfolio project | - |
```

## Notes

- This skill is idempotent: running it multiple times produces the same result
- Name collisions are reported, not auto-fixed, because the user may have intentional naming
- The canonical folder list comes from DSM_0.1 (Canonical Spoke Folder Names section)
- This skill absorbs the former `/dsm-feedback` functionality (feedback template creation)
- Reference: DSM_0.1, DSM_0.2 Session-Start Inbox Check, DSM_3 Section 6.4
