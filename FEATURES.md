# DSM Feature Timeline

A chronological record of capabilities added to the Deliberate Systematic
Methodology (DSM), the human-AI collaboration framework behind
[Take AI Bite](https://github.com/albertodiazdurana/dsm-take-ai-bite). Each
feature is numbered for easy reference (F-001 is the first, newest entries
appear at the top).

**Current count:** 122 features across 11 capability domains.

---

## April 2026

- **F-122 (2026-04-29) Compact reasoning-lessons mirror for agent-facing session-start priming (BL-427, DSM_0.2.A §8.1)** — A derived `.claude/reasoning-lessons-compact.md` file is regenerated at every `/dsm-wrap-up` Step 0 from the live `.claude/reasoning-lessons.md`, and `/dsm-go` Step 1.5 reads the compact mirror in full instead of peeking at the first 10 lines of the live file. Restores §8 design intent ("the lessons feed the agent's priming at session start") that had been reduced to a category-name peek because the live file grew too large for the context budget. Trim-only format drops the live file's first ~20 guideline lines and the inline `[auto] S{N} [{scope}]:` provenance prefix from each lesson; preserves category headings + lesson body text verbatim. Empirical measurement: ~5% savings on a 113-entry / 51 KB file (lower than the projected 25-30%; entry-verbose files do not gain much from trim-only). Compression beyond trim-only is BL-427 Step 5, deferred behind a controlled-experiment requirement that explicitly forbids using productive sessions as A/B subjects.
- **F-121 (2026-04-29) Research folder index maintenance skills (BL-425, `/dsm-research-add` + `/dsm-research-done`)** — Two new skills bring `dsm-docs/research/` to parity with `dsm-docs/plans/` for index maintenance. `/dsm-research-add` creates a research file with a header stub, validates filename convention and linked-BL existence, and inserts a row into the appropriate sub-table of `dsm-docs/research/README.md` (5 categories: BL-tied / informs-BL / ready-for-promotion / tool-assessment / untracked-carryover). `/dsm-research-done` annotates `Status: Done` + `Date Completed:`, runs `git mv` followed by an explicit `git add` on the destination to handle the BL-370 rename-staging pitfall, and removes the row from the active index. CLAUDE.md gains a "Research Index Maintenance" sub-section flagging drift between folder and README as a §22 protocol violation signal. Closes an asymmetry that had existed since the research folder was created: plans/README was actively maintained by `/dsm-backlog` and `/dsm-backlog-done`, while research/README had been a passive convention document never read for "what's active here." S205 surfaced the gap during a 30-file research triage.
- **F-120 (2026-04-24) Checkpoint Authoring Identifiers Rule (BL-420, DSM_0.2.A §10.2.1)** — Checkpoint entries must use resolvable identifiers (section references, protocol/concept names, session/file references) and must not cite bare BL numbers as identifiers. Forward-only rule with a narrow two-condition exception for checkpoints about in-flight BL implementations. Closes the dead-pointer recurrence path at checkpoint-authoring time: since `/dsm-go` Step 3.5 reads checkpoints across sessions and that reader is often a spoke agent without access to `dsm-docs/plans/`, checkpoint BL numbers previously left the next agent with unresolvable pointers precisely where agents most need working pointers. `/dsm-checkpoint` Step 2.5 surfaces the rule at checkpoint-draft time.
- **F-119 (2026-04-24) BL Lookup Index (BL-419, `dsm-docs/plans/done/INDEX.md`)** — New mirrored governance artifact: a BL-number-indexed lookup of every implemented BL, columns BL# / Title / Version / Date / Resolver (§ or concept). Complements CHANGELOG (chronological) and FEATURES (capabilities) on a third axis, by BL number. Mirrored to TAB so downstream readers of CHANGELOG/FEATURES can resolve BL numbers in one hop. `/dsm-backlog-done` gains Step 8 to keep the INDEX current when BLs move to `done/`. 332 rows at release.
- **F-118 (2026-04-24) Mirrored methodology BL-reference scrub (BL-418)** — One-time cleanup removing ~170 BL-NNN anchors from mirrored methodology (DSM_0-7, `scripts/commands/`, `FEATURES.md` prose, `dsm-docs/guides/`) and replacing them with resolvable identifiers (section references, protocol/concept names, session/file references). Closes the spoke-side dead-pointer problem where mirrored methodology carried filing codes that spoke and mirror readers could not resolve (the plan files themselves live only in Central). Pure reference cleanup, no behavioral change; reads cleaner in spoke context. FEATURES F-entry anchors preserved (Option A) for the F→BL trail, resolvable in one hop via BL-419 Index.
- **F-117 (2026-04-23) Checkpoint step in /dsm-wrap-up (BL-414)** — Full and quick wrap-ups now create a session checkpoint in `dsm-docs/checkpoints/` as part of the parallel block. The checkpoint owns "pending next session" items; MEMORY.md drops that list to free space for global context and strategic vision. Closes a gap open since S177 (2026-04-08) where sessions transitioning from light to full wrap-up stopped producing checkpoints silently. `/dsm-go` Step 3.5 reads the checkpoint at next session start, restoring the continuity signal the gap had erased.
- **F-116 (2026-04-22) /dsm-go context efficiency on version-match sessions (BL-413)** — Three changes reduce `/dsm-go` session-start context consumption by an estimated 40-55% on version-match sessions: unconditional hook chmod at Step 0e (independent of `/dsm-align`), conditional `/dsm-align` at Step 1.8 (skipped when last-align version matches CHANGELOG latest), and inbox lazy-load at Step 2b (filenames only, content deferred to user request). Sonnet DSM sessions become economically sustainable; Opus sessions free context for user work.
- **F-115 (2026-04-20) Gate 1 parallel offload analysis with per-task approval (BL-409, DSM_0.2 §8.8 + DSM_6.0 §1.12)** — New Gate 1 sub-section requiring explicit per-task user approval before any parallel subagent spins. Asymmetric trigger (section present only when offload candidates exist), fail-closed default (silence = REJECTED), subscription-aware (flags cost on non-Max plans), explicit ordering with §8.7 and §8.2.1. DSM_6.0 §1.12 "Don't be a Hero, Delegate the Effort" is the foundational principle. Shifts offload from ad-hoc agent delegation to user-approved orchestration.
- **F-114 (2026-04-20) DSM_7.0 AI Platform Collaboration Guide (BL-345 rollout)** — New top-level DSM document centralizing platform-specific collaboration knowledge, so DSM_0-6 can stay platform-agnostic. Five-phase rollout landed end-to-end: Phase 1 scaffold (BL-345), Phase 2 template research (BL-398), Phase 3 TAB/DSM-exclusive patterns audit (BL-399), Phase 4 §2.1 Claude Code filled instance (BL-400, 11 subsections: Overview, Install/Auth, Core Concepts, Capability Surface, DSM Context, Config, Integration, Security, Troubleshooting, Reference, Production Readiness), Phase 5 §3 template + 9 cross-references (BL-401). DSM_7.0 is the first operational instance of the "Read the User's Manual" principle; future `§2.N` platforms (Ollama, GPT, Copilot) follow the §3.12 "How to Instantiate This Template" 8-step procedure. 759 lines, v0.3.
- **F-113 (2026-04-19) Gate 1 token-minimizing config recommendation (BL-402)** — DSM_0.2 §8.7 adds a per-artifact config recommendation layer inside Gate 1, so mechanical edits and architectural decisions don't both run at the same session baseline. Asymmetric trigger (recommendation appears only when artifact demand clearly diverges from baseline, never as "no change" ritualistic compliance), subscription-aware for Sonnet subagent offload cost, and ordered before §8.2.1 counter-evidence because computational decision precedes content decision. Origin: S195 user question "which config for the parallel sessions?" had no Gate-1-visible protocol to answer from.
- **F-112 (2026-04-13) Read the User's Manual foundational principle (DSM_6.0 §1.11, BL-344)** — New foundational principle making external-tool understanding a prerequisite to collaboration design, not an optional afterthought. Grounds in PMP Procurement (acquire from outside before building with it), relates to §1.3 Earn Your Assertions + §1.5 Know Your Context + §1.9 Think Ahead, and routes through DSM_0.2 §8.6 Skill Self-Reference Protocol for the skill-file-scoped instance. DSM_7.0 §2.1 Claude Code is its first full operational instance. Origin: BL-342 platform-assessment research surfaced the mental-model gap between experiential understanding and docs-grounded understanding.
- **F-111 (2026-04-19) PR-merge-to-main permission parity (BL-387)** — DSM_0.2.C §2 now names `gh pr merge {N} --merge|--squash|--rebase` against a main-base PR as equivalent in publication outcome to `git push origin main`, closing the asymmetry where push required confirmation and PR-merge did not. Confirmation may be batched within a larger work-block approval but must be specific to the merge action. DSM_0.2.C §2.2 adds an opt-in `.claude/settings.json` permission pattern (`Bash(gh pr merge:*)` deny) for security-sensitive projects, with honest When-To-Adopt / When-NOT-To-Adopt criteria. Couples with BL-386 Check B to form a target-verify → action-authorize chain for destructive merges.
- **F-110 (2026-04-19) Default-branch verification at session start and PR create (BL-386)** — `/dsm-go` Step 2a.6 resolves the GitHub-configured default branch via `gh repo view` and hard-halts on mismatch with the local main line (overridable by a `**Main branch:**` declaration in CLAUDE.md). DSM_0.2.C §2.1 documents the companion PR-create discipline: always pass `--base` explicitly on `gh pr create` and verify the resolved base with `gh pr view {N} --json baseRefName` before merging. Frames the rule as Earn Your Assertions extended to command defaults. Origin: dsm-jupyter-book S4 lost ~45 minutes to an HTTP 404 cascade because the repo's default branch was a stale session branch.
- **F-109 (2026-04-19) Pre-Generation Brief Gate 2 counter-evidence surfacing (BL-385)** — DSM_0.2 §8.2.1 now requires agents to surface the strongest counter-evidence to their own recommendation before requesting Gate 2 approval, with a concrete format spec, an anti-pattern guard ("No counter-evidence found" must list sources checked), and §22 as the consequence of skipping. Shifts the burden of critical evaluation from user vigilance to protocol. Origin: heating-systems S5, where two ranking errors needed user pushback to surface counter-evidence that was visible at brief time. S194 demonstrated voluntary application in 4 Gate 1 briefs before codification.
- **F-108 (2026-04-19) `/dsm-backlog` sprint-plan template injection (BL-380)** — `/dsm-backlog` now detects sprint-plan intent (title regex `^Sprint\s+\d+\b` or `--sprint` flag) and injects the 5-section DSM_2.0.C §1 Template 8 scaffold (Research Assessment, Deliverables, Phases, Phase Boundary Checklist, Sprint Boundary Checklist) plus header-block fields. `--no-template` suppresses injection for unconventional sprint titles. Preventive companion to BL-378's detective `/dsm-align` Step 3a audit: the pair covers sprint-plan structure at both creation and closure.
- **F-107 (2026-04-16) Mirror clones ship commands tracked (BL-373 F2)** — Closes the cross-platform bootstrap gap where fresh clones on Windows PowerShell couldn't invoke `/dsm-go` because `sync-commands.sh --deploy` required bash + correct HOME resolution. Mirrors now carry the 13 user-level DSM commands in `.claude/commands/` as tracked files; Claude Code reads project-level commands automatically on first clone with zero bash dependency. Enhanced `scripts/sync-take-ai-bite.sh` with a `source >> target` mapping syntax so Central's `scripts/commands/<cmd>.md` (source of truth) ships to mirror's `.claude/commands/<cmd>.md` (runtime location). Central unchanged — runtime deploy copies stay gitignored, regenerated by `sync-commands.sh --deploy`. Fresh TAB clone on any OS + Claude Code + `/dsm-go` now works end-to-end without a pre-deploy step.
- **F-106 (2026-04-16) Git-mv rename-staging warning hook (BL-370)** — New PreToolUse:Bash hook (`.claude/hooks/validate-rename-staging.sh`) catches the recurring pattern where Edit/sed content changes before `git mv` get silently dropped from the commit because `git mv` does not auto-restage prior content deltas. Three sightings (S184 BL-349, S190 IronCalc inbox move, S191 checkpoint annotation) triggered the BL. Filters to `git commit` calls; blocks with clear bypass instructions when a staged rename has unstaged content at the new path; silent otherwise. Companion to the per-turn transcript hooks (BL-319/324) and installed via the same `/dsm-align` Step 10b mechanism.
- **F-105 (2026-04-16) Cloned-Mirror Kick-off Protocol** — Fresh clones of public DSM mirrors (TAB and any downstream fork) now become functional on first `/dsm-go` with zero user prompts and zero manual scaffolding. `/dsm-go` Step 0.8 detects cloned-mirror state (ecosystem registry absent or lacks self-as-central row) and invokes the 14-step Kick-off from DSM_0.2.A §25: auto-derives `{REPO_ROOT}`, `{project_name}`, `{ISO_DATE}` from `pwd`/`basename`/`date`; copies 5 shipped `.claude/*.template` files (CLAUDE.md, settings.json, dsm-ecosystem.md, reasoning-lessons.md, skills-registry.md) to runtime paths with placeholder substitution; self-registers as `dsm-central` so the clone is its own ecosystem hub; deploys slash commands; chmod's hooks; writes a marker so subsequent sessions skip. Design explicitly refuses personal-content collection (no prompt for author/GitHub/LinkedIn) by symmetry with the existing "no personal-content copy" anti-requirement. Closes PR #36 first-clone findings #1 (incomplete scaffold), #2 (commands not registered), #3 (no `.claude/` ships), #9 (no `.gitignore` ships). T7 verified end-to-end on Windows Claude Code v2.1.39 clone.
- **F-104 (2026-04-13) "We Need to Talk" foundational principle (DSM_6.0 §1.10)** — New principle establishing that the conversation defining work IS the collaboration, not a preamble to it. Gate 0 (DSM_0.2 §8.0) is the operational implementation. The principle names why collaborative definition matters: presenting a pre-formed plan for approval reduces the human from collaborator to approver. Origin: S182 Gate 0 improvisation recognized as the missing entry point to all collaboration.
- **F-103 (2026-04-13) Infrastructure File Collaboration Protocol (DSM_0.2.B §8)** — New protocol for collaboratively modifying skill files, hook scripts, settings.json, and command files. Addresses the Gate 2 auto-approve bypass gap where high-blast-radius infrastructure files were modified without individual diff review. Companion guide defines SKILL.md template with 12 frontmatter fields, line budgets, and commands-to-skills migration path. Origin: S182 incident where 7 auto-approved Edit calls modified dsm-go.md and dsm-align.md without user review.
- **F-102 (2026-04-12) DSM_0.2 §7 authorized exception for `/dsm-staa`** — §7 now names `/dsm-staa` as the sole authorized exception to the unconditional Session Transcript Protocol activation, with a precise meta-recursion rationale and an explicit clarification that the archived subject file and the live reasoning log are two different files on disk (so writes to the live log cannot corrupt the archived subject). The `dsm-staa.md` skill file gains a "Two files, do not confuse them" block that distinguishes the archived subject at `.claude/transcripts/{timestamp}-ST.md` from the live reasoning log at `.claude/session-transcript.md`. Origin: S185 STAA session on S184 where the agent landed on the correct behavior (no transcript write) from a wrong rationale (file corruption), a near-miss that would eventually become a miss. Hook/skill collision in STAA sessions deferred to BL-343.
- **F-101 (2026-04-11) DSM_0.2 §22 stop condition on the current output** — §22 Protocol Violation Triage Response now states explicitly that when a violation is detected, the current output-in-progress is itself a stop condition. The agent must name the violation, halt without completing the output, propose corrective action, and wait for user confirmation before resuming. An anti-pattern clause closes the loophole where a violation could be acknowledged as a footnote while the same output keeps rolling. Cross-referenced to DSM_6.0 Earn Your Assertions. Origin: blog-poster S19 incident, where a mid-paragraph acknowledgment did not actually stop the output and the user had to escalate.
- **F-100 (2026-04-11) `/dsm-align` External Contribution governance scaffold** — `/dsm-align` now detects External Contribution projects and scaffolds their governance folder at `{contributions-docs}/{project-name}/` instead of creating spoke folders in the upstream repo. Detection is two-tier: reads both the Project type and Participation pattern fields in the CLAUDE.md alignment section, or falls back to filesystem signals (upstream project markers + absence of `dsm-docs/`) with a user confirmation gate. Cross-repo writes to the governance folder are gated by an explicit confirmation on first scaffold. Closes the gap where external repos either had no governance scaffolding or risked the BL-114 failure mode (accidental `dsm-docs/` creation in an upstream repo). Idempotent: subsequent runs pass through without re-prompting.
- **F-099 (2026-04-10) Minimal troubleshooting boot with /dsm-safe-go** — Zero-dependency, read-only session entry point for diagnosing problems when the normal boot chain is broken. Transcript append is best-effort. No side effects. The escape hatch that makes infrastructure changes safer to ship.
- **F-098 (2026-04-10) Gate 0 Collaborative Definition Protocol** — New gate in the Pre-Generation Brief that governs the collaborative dialog before any artifact is conceived. Three steps (confirm threads, analyze dependencies, package into units), each requiring explicit confirmation. Ensures the human shapes the work structure, not just approves it.
- **F-097 (2026-04-09) Unconditional /dsm-align on every /dsm-go** — `/dsm-go` Step 1.8 now invokes `/dsm-align` on every session start, no marker checks, no version gates, no confirmation. Replaces brittle conditional logic that allowed alignment drift to persist between sessions. Eliminates four distinct failure modes hit during DSM Central S180 (hook scripts at index mode 644, stale marker files, Claude Code window cache, scaffold drift). `/dsm-light-go` remains the explicit lightweight escape hatch for context-pressure continuation sessions.
- **F-096 (2026-04-09) Per-turn transcript hook delivery to spokes** — `/dsm-align` now installs the per-turn transcript hook and the append-only edit validator into each spoke's `.claude/hooks/` and wires them into `.claude/settings.json`. Before this, DSM_0.2 §7 had the rules on paper and nothing enforcing them. Two sessions on the same day paid the cost: portfolio S69 ran six turns without a single transcript append, and blog-poster S17 produced one entry in the whole session.
- **F-095 (2026-04-07) Process narration in transcript thinking blocks** — Thinking blocks now narrate reasoning as it unfolds (loops, doubts, reversals, considered-and-rejected paths) instead of presenting clean post-hoc summaries. The user can now see inefficiency patterns in the agent's reasoning that were previously hidden by curated summaries, enabling reasoning-efficiency analysis.
- **F-094 (2026-04-07) Per-turn transcript append enforcement** — Every turn now triggers a `UserPromptSubmit` hook reminder that forces the agent to append a thinking block to the session transcript before doing any work. Closes the failure mode where the agent silently skipped reasoning logs across multiple consecutive turns despite static doc rules requiring them.
  - **Functional from:** v1.4.13 (after S180 BL-319 follow-up). The hook scripts were stored in the git index at mode `100644`. `core.fileMode = false` on WSL hid the divergence, so every fresh clone of any DSM project got non-executable hooks and the per-turn reminder hook silently failed end-to-end. Resolved via `git update-index --chmod=+x`, `/dsm-align` hub fast-path step 10b inclusion, and step 10b sub-step b re-applying `chmod +x` on every run including byte-identical destinations. See v1.4.13 CHANGELOG entry for the full root-cause chain.
- **F-093 (2026-04-07) Python virtual environment protocol** — Projects with Python code now require `.venv` creation and activation before any `pip install`. Closes a gap where agents could pollute system Python with project dependencies, hiding version conflicts and breaking reproducibility across machines.
- **F-092 (2026-04-07) Runtime register context for register-sensitive skills** — Skills that depend on audience and formality assumptions now receive an explicit runtime context block (audience, formality, domain, constraints) before invocation. Closes a gap where the skill rewrote an academic deliverable into informal register because nothing told it the target reader.
- **F-091 (2026-04-07) Planning pipeline gate in alignment template** — Spoke agents now see an explicit reinforcement that only `dsm-docs/plans/` items are actionable; material in `_reference/`, `docs/`, README, or sprint plan drafts is input to the planning pipeline, not a substitute for it. Closes a gap where agents conflated "understanding scope" with "adopting the plan."
- **F-090 (2026-04-06) Sprint Retrospective Intelligence at sprint boundaries** — At sprint boundaries the agent synthesizes operational data across 6 dimensions (themes, principles, evolution, collaboration, learning, maturity), turning mechanical counts into strategic analysis that informs the next sprint.
- **F-089 (2026-04-06) Cross-repo write safety in alignment template** — Spoke agents now see an explicit reinforcement that cross-repo writes require user confirmation, closing a gap where the rule existed in Module C but was invisible to spoke agents through the template.
- **F-088 (2026-04-06) Wrap-up type marker for session-start guidance** — Each wrap-up variant records its type (full/light/quick). The next session detects mismatches and suggests the appropriate startup command, preventing wasted overhead or skipped checks.
- **F-087 (2026-04-06) Factual accuracy in Code Output Standards** — The alignment template now instructs agents to state uncertainty rather than guess or fabricate, operationalizing DSM_6.0's Earn Your Assertions principle across all spoke projects.
- **F-086 (2026-04-05) Sprint plan cross-reference before completion** — Before suggesting wrap-up, the agent re-reads the sprint plan and checks each deliverable against actual evidence. No more "sprint complete" when experiment gates are unmet or SHOULD items are still open.
- **F-085 (2026-04-05) Figure validation in notebook collaboration** — Cells that generate plots now save figures to disk so the agent can read the image back. The agent actually sees what it drew before moving on.

## March 2026

- **F-084 (2026-03-20) Incomplete wrap-up recovery** — When a session ends
  unexpectedly, the next session detects the gap and offers to reconstruct
  the missing summary and reasoning lessons from the archived transcript,
  plus suggests any remaining actions.

- **F-083 (2026-03-19) Two-Pass Reading Strategy** — Long structured files
  are read in two passes: first a structural scan to build a skeleton, then
  targeted reads of relevant sections. Reduces context waste on large documents.

- **F-082 (2026-03-19) Web Research Capture Protocol** — When web research
  feeds into a deliverable, raw findings are saved with source URLs before
  synthesis, ensuring every claim is traceable.

- **F-081 (2026-03-16) Session configuration recommendation** — Each session
  receives a tailored model/effort/thinking configuration based on the planned
  work scope and the user's subscription limits.

- **F-080 (2026-03-16) Strategic roadmap with GitHub Projects** — A three-layer
  planning system: strategic roadmap document, GitHub Projects board for
  operational tracking, and individual backlog files as source of truth.

- **F-079 (2026-03-16) Phase-gated work** — Backlog items are assigned to
  strategic phases with dependencies. Phase progression is based on completing
  high-priority items before moving to the next phase.

- **F-078 (2026-03-16) Backlog Naming Rule** — Every backlog item title must
  be self-explanatory. If scanning the list requires opening files to understand
  what items do, the titles are renamed.

- **F-077 (2026-03-16) Consolidation branch retention** — Remote branches for
  backlog consolidations are kept until all referenced items are resolved,
  preventing premature cleanup.

- **F-076 (2026-03-15) Backlog Scope Rule** — Each backlog item must address
  a single, independently completable topic. Multi-topic items are split before
  implementation.

- **F-075 (2026-03-15) Mirror repo sync** — Methodology files are automatically
  copied to public distribution repos after changes, keeping them current
  without manual intervention.

- **F-074 (2026-03-15) Branch testing requirement** — Feature branches must be
  tested before merging. No exceptions. Each backlog item includes a specific
  test plan checked off before merge.

- **F-073 (2026-03-15) DSM modularization** — The custom instructions are split
  into a core file plus four on-demand modules, reducing context consumption
  by 78% for tasks that only need specific protocols.

- **F-072 (2026-03-14) Feature branch workflow** — Backlog implementations use
  dedicated branches with naming conventions, test-before-merge policy, and
  automatic cleanup after merge.

- **F-071 (2026-03-14) Situational Assessment (Step 0)** — A pre-methodology
  assessment for new projects: project type, constraints, team composition,
  and prior art review before applying any framework.

- **F-070 (2026-03-14) Scale-Aware Planning** — A research gate that adjusts
  methodology scope based on project scale, preventing over-engineering small
  projects or under-planning large ones.

- **F-069 (2026-03-14) Notebook Cell Output Validation** — Before generating
  the next notebook cell, the actual output of the previous cell is verified,
  preventing cascading errors from assumed results.

- **F-068 (2026-03-14) Session Delivery Budget** — Work volume is estimated
  at session start to prevent overcommitment. Mid-session checks flag when
  planned work exceeds remaining capacity.

- **F-067 (2026-03-13) Stress Testing** — Controlled experiments comparing
  methodology-guided vs unguided AI collaboration, measuring the actual impact
  of structured protocols on output quality.

- **F-066 (2026-03-12) Critical Thinking principle** — The agent must challenge
  assertions, verify claims, and distinguish evidence from assumption rather
  than accepting inputs at face value.

- **F-065 (2026-03-12) DSM acronym disambiguation** — Public-facing content
  uses "Take-AI-Bite's DSM" to avoid confusion with other frameworks sharing
  the DSM abbreviation.

- **F-064 (2026-03-11) 7-Element Experiment Framework** — Structured template
  for capability experiments: question, hypothesis, method, measurement,
  result, interpretation, next steps.

- **F-063 (2026-03-10) External DSM Descriptions** — Canonical short, medium,
  and full descriptions for use in public-facing contexts, ensuring consistent
  messaging across platforms.

- **F-062 (2026-03-10) Communication Channel Framework** — Taxonomy of
  communication channels (blog, portfolio, inbox, social) with audience mapping
  and content guidelines for each.

- **F-061 (2026-03-10) Participation patterns** — Three project patterns
  (Standard Spoke, External Contribution, Private Project) with different
  isolation rules for communication, feedback, and cross-repo writes.

- **F-060 (2026-03-09) Alignment command** — A validation command that checks
  configuration references, ecosystem pointers, and directory structure
  compliance across the project.

- **F-059 (2026-03-07) Public brand (Take AI Bite)** — A public-facing identity
  separate from the internal governance name, allowing the methodology to
  communicate value without exposing implementation details.

- **F-058 (2026-03-05) Communication Channel Framework** — Taxonomy of
  communication channels with audience mapping for structured outreach.

- **F-057 (2026-03-05) Research Re-Validation Gate** — Expiry check on research
  findings before implementation: if research is older than a threshold, it
  must be re-validated before being used as a basis for decisions.

- **F-056 (2026-03-04) Inbox done/ lifecycle** — Processed inbox entries are
  moved (not deleted or marked in place), preserving the full communication
  history while keeping the active inbox clean.

- **F-055 (2026-03-02) Per-session feedback files** — Each session generates
  separate feedback files for methodology observations and backlog proposals,
  with a done/ lifecycle for processed entries.

- **F-054 (2026-03-02) Spoke-to-hub feedback push** — At session end, feedback
  files are automatically pushed to the central repository's inbox, closing
  the learning loop between projects.

- **F-053 (2026-03-02) Lightweight session mode** — Minimal context loading
  for continuation sessions where the task is already known. Preserves the
  transcript across sessions for unbroken reasoning chains.

- **F-052 (2026-03-02) Session baseline snapshot** — Git state is saved at
  session start so that wrap-up can identify exactly which changes belong to
  the current session.

- **F-051 (2026-03-01) Spoke initialization checklist** — Standard scaffold
  for new projects: directory structure, configuration files, and gitignore
  patterns created from a template.

- **F-050 (2026-02-27) Session Transcript reasoning extraction** — Reasoning
  patterns are extracted from session transcripts via dedicated analysis,
  turning one session's insights into reusable guidance for future sessions.

- **F-049 (2026-02-27) Blog seeds** — Draft blog entries with date-prefixed
  naming are collected during regular work, building a content pipeline without
  dedicated writing sessions.

- **F-048 (2026-02-25) Pre-Generation Brief (three gates)** — Before creating
  any artifact: concept approval (explain what and why), implementation
  approval (review the diff), run approval (when executing). Each gate is
  an explicit stop requiring user confirmation.

- **F-047 (2026-02-25) Composition Challenge Protocol** — When producing a
  collection of multiple discrete items, special handling ensures each item
  gets individual attention rather than being batch-generated.

- **F-046 (2026-02-25) Edit Explanation Stop** — Multiple distinct edits to a
  single file require individual explanations, preventing opaque bulk changes.

- **F-045 (2026-02-19) Reasoning Lessons** — Promoted reasoning patterns from
  transcript analysis become formal protocol guidance, accumulating
  institutional knowledge across sessions.

- **F-044 (2026-02-19) Phase 0.5: Research and Grounding** — A formal research
  phase before implementation for novel domains: survey existing work, identify
  gaps, validate approach before writing code.

- **F-043 (2026-02-19) Technical Progress Reporting** — Structured reporting
  at sprint boundaries captures engineering work in a format suitable for
  stakeholder communication.

- **F-042 (2026-02-18) Secret Exposure Prevention** — Files matching sensitive
  patterns (.env, *.key, credentials.*) are automatically refused when staging
  for commits, requiring explicit user override.

- **F-041 (2026-02-18) Untrusted Input Protocol** — Sanitization rules for
  processing inbox entries, tool outputs, and web results, preventing prompt
  injection or data corruption from external sources.

- **F-040 (2026-02-18) Query Sanitization** — Rules for constructing web search
  queries and API requests to prevent information leakage or injection.

- **F-039 (2026-02-18) README Change Notification** — When any project's README
  changes, an automated inbox notification is sent to the portfolio and central
  repository for tracking.

- **F-038 (2026-02-17) Ecosystem Path Registry** — Cross-repo paths are declared
  in a local configuration file with logical names, validated at session start.
  Eliminates hardcoded filesystem paths from methodology documents.

- **F-037 (2026-02-15) Context Budget Protocol** — The context window is treated
  as a finite resource with explicit management: warnings at 40% remaining,
  options presented before reading large files.

- **F-036 (2026-02-14) Take a Bite delivery principle** — Deliver only what the
  reviewer can engage with and respond to with substance. The core test for
  whether an artifact is the right size.

- **F-035 (2026-02-14) Earn Your Assertions** — Every factual claim must be
  independently verified before presenting. No hedging as a substitute for
  checking.

- **F-034 (2026-02-14) External source feedback** — Observations from external
  tools, research, or incidents automatically generate backlog items, capturing
  improvement opportunities from outside the methodology.

- **F-033 (2026-02-11) Transcript as reasoning channel** — The session transcript
  file is the primary output for agent reasoning. Conversation text carries
  only results, summaries, and questions, never reasoning.

- **F-032 (2026-02-10) Capability experiments** — Numbered experiments with
  hypothesis, method, result, and decision. Reproducibility is mandatory:
  each experiment has an executable script.

- **F-031 (2026-02-08) Destructive Command Protocol** — A named list of commands
  that are never auto-approved (force push, hard reset, recursive delete).
  Each requires explicit user request and explanation.

- **F-030 (2026-02-08) Research documents** — Dedicated research directory with
  date-prefixed files and a done/ lifecycle for consumed research. Raw findings
  are preserved alongside synthesized deliverables.

- **F-029 (2026-02-08) Session start protocol** — Multi-step initialization at
  every session: project type detection, inbox check, version comparison,
  ecosystem validation, transcript setup, and baseline snapshot.

- **F-028 (2026-02-07) Session wrap-up checklist** — Structured end-of-session:
  memory update, backup, contributor profile check, commit, push, and handoff
  document if complex work is pending.

- **F-027 (2026-02-07) MEMORY.md** — Persistent file-based memory across
  conversations, indexed with typed files (user, feedback, project, reference).
  Survives context window resets and session boundaries.

- **F-026 (2026-02-07) External Contribution Pattern** — Governance artifacts
  for external projects are stored separately from the upstream repo. The
  external repo receives only code contributions, never methodology files.

- **F-025 (2026-02-07) .git/info/exclude** — Agent configuration files are
  excluded from commits without polluting the project's .gitignore, using
  git's local exclude mechanism.

- **F-024 (2026-02-06) Hub-spoke architecture** — A central governance
  repository with spoke projects that inherit protocols via configuration
  references. Changes propagate automatically to all projects.

- **F-023 (2026-02-06) Project type detection** — At session start, the project
  type is automatically identified (Notebook, Application, Hybrid,
  Documentation, External Contribution) and the appropriate methodology track
  is activated.

- **F-022 (2026-02-06) CLAUDE.md** — Project-specific instructions loaded at
  every session, with reference chaining for inherited protocols. Each project
  can override or extend the base methodology.

- **F-021 (2026-02-06) Gitignored working folders** — The .claude/ directory
  is gitignored in all projects: session transcripts, baselines, and ecosystem
  paths are never committed to the repository.

- **F-020 (2026-02-06) Backlog classification** — Backlog items are classified
  as developments (external projects) or improvements (internal enhancements),
  keeping project definitions separate from methodology changes.

- **F-019 (2026-02-06) Checkpoints** — Milestone snapshots with detailed
  internal context: rationale, session state, next steps. Different from the
  changelog (what changed) — checkpoints capture what was happening.

- **F-018 (2026-02-06) Inbox system** — Inbox directories for hub-spoke
  notification routing. Entries arrive, get processed, and move to done/.
  The inbox is a transit point, not a storage system.

- **F-017 (2026-02-06) Commit message conventions** — Descriptive messages
  referencing backlog item numbers, committed immediately after each
  implementation. No batching multiple items into one commit.

- **F-016 (2026-02-06) Governance isolation** — A dedicated storage repository
  separates governance artifacts from upstream repos. External repos receive
  only code contributions, never methodology files.

- **F-015 (2026-02-04) Epoch structure** — Multi-sprint grouping for larger
  project arcs, providing a higher-level planning horizon above individual
  sprints.

- **F-014 (2026-02-01) Design decisions** — Numbered decision records
  documenting architectural choices with rationale, alternatives considered,
  and consequences accepted.

- **F-013 (2026-02-01) Graph Explorer feedback volume** — A single spoke
  project generated 42 backlog proposals and 53 methodology observations,
  demonstrating the feedback system's capacity at scale.

## February 2026 (continued above)

## January 2026

- **F-012 (2026-01-30) Inter-project feedback** — Spoke projects generate
  backlog proposals and methodology observations for the central repository,
  creating a systematic learning loop across the ecosystem.

- **F-011 (2026-01-26) Backlog system** — Numbered backlog items with markdown
  files as source of truth and a done/ lifecycle. Three-layer tracking:
  strategic roadmap, operational board, and individual files.

- **F-010 (2026-01-22) Semantic versioning** — Content releases follow
  semantic versioning (vX.Y.Z) with consistency tags for post-release cleanup.

- **F-009 (2026-01-22) Version Update Workflow** — A 9-step process from
  change to release: update methodology, changelog, readme, commit, tag,
  push, and sync to mirror repos.

- **F-008 (2026-01-22) CHANGELOG** — A public record of what changed in each
  version, following the Keep a Changelog format with categorized sections.

- **F-007 (2026-01-22) Git tags** — Release tags for content versions and
  checkpoint tags for post-release cleanup, marking recovery points in the
  project history.

- **F-006 (2026-01-08) App Development Protocol** — Step-by-step guided
  development for application code: explain why before each action, create
  files via tools, user approves via the permission window before proceeding.

## December 2025

- **F-005 (2025-12-23) Inclusive language** — Prohibited patterns for
  violence-implying, gendered, political, religious, and superiority-implying
  language. Proper diacritical marks required for non-English text.

- **F-004 (2025-12-23) Handoffs** — Session-end resumption documents consumed
  by the next session start, ensuring complex pending work is not lost between
  sessions.

- **F-003 (2025-12-14) Sprint cadence** — Time-boxed work periods with boundary
  checklists and feedback windows, providing rhythm and review points for
  ongoing work.

- **F-002 (2025-12-14) Code Output Standards** — Print actual values (shapes,
  metrics, counts), not generic confirmations. Let results speak for themselves.

- **F-001 (2025-12-14) File naming standards** — Date-prefixed research, blog,
  and checkpoint files with documented naming conventions for consistency
  across all projects.

## November 2025

- **F-000 (2025-11-13) Notebook Collaboration Protocol** — One cell at a time;
  wait for actual output before generating the next cell. Each cell adapts
  based on real results, not assumptions.

---

*This timeline is maintained as features are added. For the internal
development record with implementation details, see the
[Feature Inventory](dsm-docs/research/2026-03-16_dsm-feature-inventory.md).*
