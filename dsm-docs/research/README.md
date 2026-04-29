# Research

Research files from Phase 0.5 and ad-hoc research. Processed research moves
to `done/` after findings are integrated into the target outcome.
Reference: DSM_0.2 Module D (Phase 0.5: Research and Grounding).

## Naming

`YYYY-MM-DD_{topic}.md`

## Lifecycle

1. Create during research phase with standard header (Purpose / Topic, Linked BL if any, Date, Status)
2. Integrate findings into sprint plan or deliverables
3. Move to `done/` with `Status: Done` and `Date Completed: YYYY-MM-DD`

## Active research

Linked BL column resolves to the BL that consumes or is informed by the file.
"(none)" = research finding not yet promoted to a BL. "(input → BL-N)" = file
informs an active BL but is not its primary deliverable.

### Tied to an active backlog item

| Date | Topic | Linked BL | Status |
|------|-------|-----------|--------|
| 2026-04-14 | [DSM dual-audience language (Phase 1 research)](2026-04-14_dsm-dual-audience-language-phase1-research.md) | BL-295 | Phase 1+2 done; Phase 3 pending main session |
| 2026-04-14 | [DSM dual-audience language (Phase 2 audit)](2026-04-14_dsm-dual-audience-language-phase2-audit.md) | BL-295 | Phase 1+2 done; Phase 3 pending main session |
| 2026-04-17 | [BL-236f beta-framing patterns](2026-04-17_bl236f-beta-framing-patterns.md) | BL-236f | BL still pending (MEMORY) |
| 2026-04-17 | [BL-236h README link audit](2026-04-17_bl236h-readme-link-audit.md) | BL-236h | BL still pending (MEMORY) |
| 2026-04-17 | [Skill-file testing methodology](2026-04-17_skill-file-testing-methodology.md) | BL-374 | Proposed |
| 2026-04-21 | [Heating-systems S8 first-ever Sonnet session (preliminary)](<2026-04-21 preliminary-research Heating-systems S8 is the ecosystem's first-ever Sonnet session.txt>) | BL-411 | Active; filename non-standard, rename pending |
| 2026-04-21 | [Claude usage metrics API](2026-04-21_claude-usage-metrics-api.md) | BL-412 | Open |
| 2026-04-24 | [Böckeler "Harness Engineering" vs TAB/DSM](2026-04-24_boeckeler-harness-engineering-vs-tab-dsm.md) | BL-423 | Feeds Thread 1 of BL-423 |
| 2026-02-27 | [Literate CQRS Knowledge Architecture (folder, 6 files)](Literate-CQRS-Knowledge/) | Literate-CQRS-knowledge-architecture-plan.md | Active research stream |

### Informs an active BL but is not its primary deliverable

| Date | Topic | Input → | Status |
|------|-------|---------|--------|
| 2026-04-16 | [BMAD-METHOD vs DSM comparison](2026-04-16_bmad-method-comparison.md) | BL-423 | Active |
| 2026-04-19 | [Opus 4.7 vs TAB positioning](2026-04-19_opus-4-7-vs-tab-positioning.md) | BL-423 | Active |
| 2026-04-21 | [PMO role parallels with TAB/DSM creator (v2)](2026-04-21_pmo-role-parallels-tab-dsm-creator-v2.md) | BL-423 | Active (v1 superseded) |

### Findings ready for promotion to a BL (no BL filed yet)

| Date | Topic | Suggested action | Status |
|------|-------|------------------|--------|
| 2026-04-14 | [LinkedIn post: JetBrains MCP refactoring vs Claude Code](2026-04-14_linkedin-post-jetbrains-mcp-refactoring.md) | File BL "AST-based refactoring tool integration evaluation" or move to done | Promoted from QA, no follow-up |
| 2026-04-19 | [Deep memory retrieval feasibility](2026-04-19_deep-memory-retrieval-feasibility.md) | File BL on memory retrieval design | Self-marked "ready for promotion" |
| 2026-04-19 | [Humanizer vs Wikipedia "Signs of AI writing"](2026-04-19_humanizer-vs-wikipedia-signs-of-ai-writing.md) | File BL "Humanizer alignment with Wikipedia AI-writing signs" | Self-marked "input for BL" |

### Tool / methodology assessments awaiting decision

| Date | Topic | Decision needed | Status |
|------|-------|-----------------|--------|
| 2026-04-17 | [Caveman compression assessment](2026-04-17_caveman-compression-assessment.md) | Adopt / fork / drop | Tool decision likely reached, verify and move |
| 2026-04-17 | [lean-ctx applicability assessment](2026-04-17_lean-ctx-assessment.md) | Run 2nd behavioral pass on DSM files? | 2nd pass recommended, not yet done |
| 2026-04-17 | [Plan framing across DSM spoke projects](2026-04-17_plan-framing-across-projects.md) | Did this feed an implemented BL? | Ambiguous; verify and move or file BL |
| 2026-04-19 | [Which BLs are parallel-session candidates](2026-04-19_which-bls-parallel-candidates.md) | Snapshot is stale; recurring or one-off? | Likely move to done or file recurring-audit BL |

### Untracked (S201 carryover, not committed)

| Date | Topic | Decision needed | Status |
|------|-------|-----------------|--------|
| 2026-04-23 | [PMBOK knowledge areas vs DSM](2026-04-23_pmbok-knowledge-areas-vs-dsm.md) | Commit-as-research + file BL, or discard | Untracked since S201 |
| 2026-04-23 | [PMBOK process groups vs DSM](2026-04-23_pmbok-process-groups-vs-dsm.md) | Commit-as-research + file BL, or discard | Untracked since S201 |

## Index Maintenance

This index must be kept in sync with the contents of this folder, in the same
way `dsm-docs/plans/README.md` is maintained alongside backlog item creation
and completion.

**Use the skills (preferred):**

- `/dsm-research-add` , create a new research file with a header stub and add a row to the appropriate sub-table above. Validates filename convention and linked BL existence.
- `/dsm-research-done` , annotate `Status: Done` + `Date Completed:`, move the file to `done/`, and remove its row from the active index. Handles the BL-370 `git mv` + `git add` staging sequence.

**Manual edits are allowed but discouraged.** When the linked BL changes status (Open → Implemented, Proposed → Active), update the Status column directly; the skills do not handle status transitions on existing rows.

The "Active research" section is the source of truth for what
`dsm-docs/research/` contains; stale rows are a §22 protocol violation signal.
