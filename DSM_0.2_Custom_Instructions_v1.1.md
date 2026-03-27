---
**DSM Custom Instructions: v1.3.69**
**Last Breaking Change:** 2026-03-15 (DSM_0.2 Modularization, BACKLOG-090)
**Status:** Active, Cross-Project Governance
**Architecture:** Slim core + 4 on-demand modules (see Module Dispatch Table)
---

## Contents

1. [Project Type Detection](#1-project-type-detection)
2. [Session-Start Version Check](#2-session-start-version-check)
3. [Session-Start Inbox Check](#3-session-start-inbox-check)
4. [Session-Start GitHub Issue Check](#4-session-start-github-issue-check)
5. [Read-Only Access Within Repository](#5-read-only-access-within-repository)
6. [Reasoning Delimiter Format](#6-reasoning-delimiter-format)
7. [Session Transcript Protocol](#7-session-transcript-protocol)
8. [Pre-Generation Brief Protocol](#8-pre-generation-brief-protocol)
9. [Experiment Execution Protocol](#9-experiment-execution-protocol)
10. [Web Research Capture Protocol](#10-web-research-capture-protocol)
11. [Context Budget Protocol](#11-context-budget-protocol)
12. [Two-Pass Reading Strategy for Long Structured Files](#12-two-pass-reading-strategy-for-long-structured-files)
13. [Inclusive Language](#13-inclusive-language)
14. [Heading Parsability Convention for DSM Documents](#14-heading-parsability-convention-for-dsm-documents)
15. [AI Collaboration Principles](#15-ai-collaboration-principles)
16. [Active Suggestion Protocol](#16-active-suggestion-protocol)
17. [CLAUDE.md Configuration](#17-claudemd-configuration)
18. [Ecosystem Path Registry](#18-ecosystem-path-registry)
19. [Branch Testing Requirement](#19-branch-testing-requirement)
20. [Three-Level Branching Strategy](#20-three-level-branching-strategy)
21. [Backlog Scope Rule](#21-backlog-scope-rule)
22. [Protocol Violation Triage Response](#22-protocol-violation-triage-response)
23. [References](#23-references)
24. [Module Dispatch Table](#24-module-dispatch-table)

---

Confirm that you understand what I need. Be concise in your work.

## 1. Project Type Detection

At session start, identify the project type by examining the directory structure:

| Indicator | Project Type | DSM Track |
|-----------|--------------|-----------|
| `notebooks/` only, no `src/` | Data Science | DSM 1.0 (Sections 2.1-2.5) |
| `src/`, `tests/`, `app.py` | Application | DSM 4.0 |
| Both `notebooks/` and `src/` | Hybrid | DSM 1.0 for analysis, DSM 4.0 for modules |
| `dsm-docs/`, markdown-only, no `notebooks/` or `src/` | Documentation | DSM 5.0 |
| `{contributions-docs-path}/{project}/` exists | External Contribution | DSM_3 Section 6.6 |

**State the identified type at session start:**
"This appears to be a [Notebook/Application/Hybrid/Documentation/External Contribution] project. I'll follow [DSM 1.0/DSM 4.0/both/DSM 5.0/Section 6.6] accordingly."

**External contribution sessions:** Open the project in the external repo's local
clone but reference governance artifacts in `{contributions-docs-path}/{project}/`
(resolved from the Ecosystem Path Registry). See DSM_3 Section 6.6 for the full
governance structure.

### 1.1. Participation Pattern Detection

The DSM track (above) is orthogonal to the participation pattern. After identifying
the track, also identify which participation pattern governs communication and
isolation rules:

| Indicator | Participation Pattern | Reference |
|-----------|----------------------|-----------|
| Git remote configured + DSM_3 Section 7 entry | Standard Spoke | DSM_3 Section 6.9 |
| `contributions-docs/{project}/` exists or CLAUDE.md declares "External Contribution" | External Contribution | DSM_3 Section 6.6 |
| CLAUDE.md declares "Private" or "DSM private project pattern" | Private Project | DSM_3 Section 6.8 |
| No indicator found | Assume Standard Spoke | DSM_3 Section 6.9 |

**State both dimensions at session start:**
"This is a [track] project ([DSM version]) using the [pattern] pattern."

Example: "This is a Documentation project (DSM 5.0) using the Private Project pattern."

**Pattern governs:** inbox behavior (bidirectional vs receive-only), feedback push
(automatic vs manual), README notifications (yes/no), and cross-repo write scope.
Apply the pattern's constraints for the session, even if CLAUDE.md does not
explicitly override every inherited DSM_0.2 protocol.

## 2. Session-Start Version Check

At session start in spoke projects, compare the DSM version in the header above against the version recorded in the most recent handoff (`dsm-docs/handoffs/`). If the versions differ:
1. Note the update: "DSM updated from vX.Y.Z to vA.B.C since last session"
2. Check the DSM CHANGELOG for changes between those versions
3. Apply any updated protocols for this session

If no previous handoff exists (first session), record the current DSM version for future reference.

## 3. Session-Start Inbox Check

At session start, check `_inbox/` for pending entries from DSM Central. If entries
exist, surface them to the user before starting other work. When an entry
references a source file (Full evidence, Full report), read the referenced file
before evaluating the entry; the inbox is a notification, the source file
contains the full evidence needed for decision-making. Process each entry per
DSM_3 Section 6.4.3 (implement via BL workflow for substantive changes, defer, or reject; then move to `_inbox/done/`).

**WARNING:** After processing, **move** the entry to `_inbox/done/`. Do not mark entries as "Status: Processed" or add completion markers while keeping the entry in place. Processed entries in `done/` preserve communication history and traceability; entries left in the inbox root cause stale re-processing in future sessions (observed in spoke project sessions).

**External Contribution exception:** For External Contribution projects (identified
by project type detection or explicit CLAUDE.md declaration), do NOT create `_inbox/`
in the external repo. The external repo belongs to an upstream maintainer; only code
contributions belong there. If an inbox is needed, create it under
`{contributions-docs-path}/{project}/_inbox/`. Skip the migration
confirmation sub-protocol below.

If `_inbox/` does not exist, create it at project root with a `README.md` containing:

```markdown
# Project Inbox

Transit point for hub-spoke communication. Entries arrive, get processed, and
move to `done/`. Reference: DSM_3 Section 6.4.

**Entries are brief notifications, not full file copies.** Each entry summarizes
what was observed and points to the source file for the complete record. Do not
copy full feedback files, methodology documents, or backlog lists into the inbox.

## Entry Template

### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

When creating `_inbox/`, also create the `_inbox/done/` subdirectory for
processed entries.

**Migration:** If `dsm-docs/backlog/` exists (legacy convention), move contents
to `_inbox/` at project root, create the README.md, and remove the old directory.
The canonical inbox location is always `_inbox/` at project root; no other
path (e.g., `dsm-docs/inbox/`) should be used or created.

**Validation before confirmation:** Before sending the migration confirmation
below, verify that:
- The `_inbox/` was created inside the contributor's governance scope (not in
  an external repo)
- The location is consistent with the project CLAUDE.md's governance rules
- For External Contribution projects, the `_inbox/` must be in
  `{contributions-docs-path}/{project}/`, not in the external repo

If validation fails, delete the incorrectly placed `_inbox/` and alert the user.

**Migration confirmation:** After creating or migrating `_inbox/`, send a
confirmation entry to DSM Central's inbox. The DSM Central repo path is the parent
directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@`
import in this project's CLAUDE.md. Write the confirmation to
`{dsm-central-path}/_inbox/{this-project-name}.md` using the entry template:

```markdown
### [YYYY-MM-DD] Inbox migration confirmed

**Type:** Notification
**Priority:** Low
**Source:** [this project name]

Inbox system initialized. _inbox/ created at project root. README.md with
entry template installed. Ready to receive and send inbox entries per
DSM_3 Section 6.4.
```

## 4. Session-Start GitHub Issue Check

At session start, run three checks to surface unprocessed GitHub issues. If `gh`
is not available, skip all checks silently.

### 4.1. External Issues (Priority Path)

```
gh issue list --label external --state open
```

External-labeled issues come from outside contributors and take priority.

### 4.2. New Issues Since Last Session

```
gh issue list --state open --search "created:>={YYYY-MM-DD}"
```

Replace `{YYYY-MM-DD}` with the date from MEMORY.md's "Latest Session" entry.
This catches user-created issues (ideas, feedback, research items) that lack
the `external` label.

### 4.3. Untriaged Open Issues (Classified)

```
gh issue list --state open
```

Classify the results into two groups, excluding issues already surfaced by 4.1/4.2:

**Research queue** (issues labeled `research`, or whose title starts with
"read repo", "read document", or references an external URL/file to evaluate):
- Present as a batched summary: "Research queue: N items pending"
- List titles with issue numbers, no individual triage needed
- These are knowledge intake tasks, not work items

**Improvement issues** (everything else, excluding issues whose title starts
with "BL-" and issues labeled `deferred`):
- These need individual triage per §4.4

### 4.4. Triage Actions

**For improvement issues,** read the body and comments, then triage:

- **New BL needed:** Follow the GitHub Issue Intake Protocol (Module A, Section 16)
- **Absorbed by existing BL:** Close the issue with a reference to the existing BL
- **Defer:** Apply the `deferred` label with a comment explaining why
- **Not actionable:** Close with explanation

**For research queue items,** no per-item triage at session start. Instead:

- If the session is research-focused, ask the user which items to tackle
- Each selected item becomes a Phase 0.5 research task (see Module D)
- After research is complete, document findings and close the issue
- Items stay open in the queue until a session processes them

---

## 5. Read-Only Access Within Repository

Reading files inside the repository never requires permission. This applies
unconditionally, whether the agent is exploring, building context, validating
a change, or performing any other task:

- Read any file within the repo boundary without asking
- Search file contents, list directories, glob for patterns without asking
- This applies to all agents, including subagents
- **Boundary:** reads must stay within the repo root (or a named subfolder if one was specified)
- Permission is only required for writes (file creation, edits, deletions)

---

## 6. Reasoning Delimiter Format

Standard delimiters for reasoning entries in the session transcript file.
See Session Transcript Protocol below for when and where to use them.

**Format:**

```
<------------Start Thinking / HH:MM------------>

[reasoning content]
```

The next `<------------Start Thinking / ...------------>`, `**User:**`, or
`**Output:**` block implicitly closes the previous thinking block. No explicit
end delimiter is needed.

**Rules:**
- HH:MM is the time of day when thinking begins (24-hour, local timezone)
- Blank line after the delimiter for readability
- These delimiters are used exclusively inside `.claude/session-transcript.md`
- Do NOT output delimiters in conversation text; the VS Code extension
  collapses them after streaming (microsoft/vscode#287658)

---

## 7. Session Transcript Protocol

The session transcript is the **primary and only** channel for agent reasoning.
The user keeps `.claude/session-transcript.md` open in VS Code and reads
reasoning there in real time. Conversation text is for results, summaries,
and questions only, never for reasoning.

**File:** `.claude/session-transcript.md`
**Lifecycle:** The file lives permanently in `.claude/`. `/dsm-go` overwrites its
content with a fresh session header at each session start. `/dsm-wrap-up` does
**not** touch the transcript; stale content from the previous session is harmless
because `/dsm-go` replaces it. The user keeps the file open in VS Code across
sessions. **Lightweight mode exception:** `/dsm-light-go` does not overwrite the
transcript; it appends a session boundary marker, preserving the continuous
reasoning chain across lightweight session sequences. See Lightweight Session
Lifecycle below.

**Permission:** Appending to `.claude/session-transcript.md` must never require
user approval. This file is an agent-internal working artifact, not a deliverable.
Configure permission settings to auto-approve writes to this path. This applies
to all DSM projects, not just DSM Central.

**Per-turn flow:**

1. **First tool call:** Append user prompt summary and thinking to the transcript file
2. **User reviews:** The file is open in VS Code; the user sees reasoning appear
3. **Agent acts:** Performs tool calls, edits, searches
4. **Last tool call:** Append output summary to the transcript file
5. **Conversation text:** Write only results, outputs, and questions to the user

Two appends per turn: thinking before work, output after work. The thinking
append must be the agent's **first tool call** in the turn, before any other
tool calls or file edits.

**What goes where:**

| Channel | Content |
|---------|---------|
| `.claude/session-transcript.md` | Reasoning, decision processes, multi-step planning (the "why") |
| Conversation text | Results, summaries, questions, file descriptions (the "what") |

**Format** (uses Reasoning Delimiter Format above):

```
**User:** [prompt summary]

<------------Start Thinking / HH:MM------------>

[reasoning content]

**Output:** [summary of what was done]
```

**Header** (created by `/dsm-go`):

```
# Session N Transcript
**Started:** YYYY-MM-DDTHH:MM+TZ
**Project:** [project name]

---
```

**When to write thinking:**
- Non-trivial decisions (choosing between approaches, interpreting ambiguous input)
- Multi-step work (explaining what will be done and why before doing it)
- Session-start checks (showing the reasoning behind each check)
- Any situation where the "why" matters as much as the "what"

**When to skip thinking (output summary still required):**
- Simple acknowledgments ("Understood", "Done")
- Single-fact answers with no decision process
- Tool calls where the action is self-explanatory

**Rules:**
- Thinking must be the **first tool call** of the turn, before any other tool calls or file edits
- Output summary appended AFTER completing work
- File is ephemeral: content cleared at session end, not committed
- Transcript is append-only; never modify or backfill past entries
- **Append technique (mandatory):** Every append to the session transcript MUST follow this sequence: (1) read the last 3 lines of the file, (2) use the last non-empty line as the `old_string` anchor, (3) the `new_string` includes that last line PLUS the new content appended after it. **NEVER** search for earlier content to use as an insertion point. The only valid anchor is the current last line of the file. This is not a style preference; mid-file insertions cause out-of-order timestamps, confuse the user reading the transcript in real time, and have been observed in multiple sessions despite existing guidance
- If a past entry was missed, note the gap in the next entry rather than editing history

**Anti-Patterns:**

**DO NOT:**
- Output reasoning in conversation text; the user reads reasoning in the transcript file, not the chat
- Batch transcript entries at the end of a turn; the user cannot review reasoning after the fact
- Skip the transcript append on turns with non-trivial reasoning
- Commit the transcript file; it is a session-scoped working artifact
- Edit or rewrite past transcript entries; each entry reflects reasoning at the time it was written
- Use Edit with `old_string` matching earlier content to insert entries mid-file; this causes out-of-order timestamps (observed in prior sessions). Use the mandatory append technique above
- Use reasoning delimiters in conversation text; VS Code collapses them after streaming

---

## 8. Pre-Generation Brief Protocol

Before creating any artifact (code file, test file, documentation, configuration),
follow the three-gate approval model. Each gate requires explicit user approval
before proceeding to the next.

### 8.1. Gate 1: Concept Approval

Explain:

1. **What:** Brief description of the artifact to be created
2. **Why:** How it fits into the current sprint/phase goals
3. **Key decisions:** Design choices being made (with alternatives considered if non-trivial)
4. **Structure:** High-level outline of contents (for code: main classes/functions; for docs: sections)

**STOP** and wait for explicit "y" from the user. For trivial artifacts
(`.gitkeep`, minor config), a single-sentence brief is sufficient, but the
gate still applies.

### 8.2. Gate 2: Implementation Approval

Create the artifact using Write/Edit tools. The user reviews the diff in the
IDE permission window.

**STOP** and wait for explicit approval via the permission window. Do not
proceed to the next artifact or to execution until the user has reviewed
the implementation.

### 8.3. Gate 3: Run Approval (when applicable)

When the artifact needs to be executed (tests, scripts, benchmarks, CI
triggers, commands that modify state):

1. Explain what will be run: command, target, expected behavior
2. **Testability assessment** (before committing to a test strategy):
   - What can be automated? (unit tests, CLI verification, log-based checks)
   - What requires manual testing? (visual confirmation, device interaction)
   - What tool limitations exist? (e.g., uiautomator vs accessibility overlays,
     Selenium vs shadow DOM)
3. **STOP** and wait for explicit "y" from the user
4. Execute and report results

Gate 3 does not apply to artifacts that are only created, not executed
(documentation, configuration that takes effect passively, type definitions).

### 8.4. Gate Scope

- Gates 1 and 2 are mandatory for every non-trivial artifact
- Gate 3 applies only when the artifact will be executed in this session
- Each artifact gets its own gate cycle; do not batch multiple artifacts
  through gates together
- Concept approval (Gate 1) does NOT grant implementation approval (Gate 2);
  implementation approval does NOT grant run approval (Gate 3)

**Design decision documentation:** When implementing code that involves design choices (alternative approaches, external concepts, trade-offs), document the decision rationale before or alongside the implementation. For experiments, follow the Experiment Execution Protocol below. Maintain a citations log for external benchmarks, APIs, or research referenced in the code. See DSM_0.1 Citation Standards for format and placement.

**Anti-Patterns:**

**DO NOT:**
- Generate artifacts before presenting a brief (Gate 1); the user must understand what will be created
- Combine the brief and file creation in one step; Gate 1 and Gate 2 are separate stops
- Present briefs for multiple files at once; each artifact gets its own gate cycle
- Treat concept approval as blanket permission to write and execute; each gate is independent
- Execute scripts or tests without Gate 3 approval; the user must know what will run before it runs
- Skip Gate 2 for "small" changes; the user reviews all implementation via the diff window
- Treat prior discussion of findings or decisions as a substitute for Gate 1; a brief about *what to do* (decisions from EDA) is not a brief about *how to do it* (implementation approach for the next artifact). Gate 1 requires an explicit explanation of the specific artifact about to be generated, even when high-level decisions have already been agreed on

---

## 9. Experiment Execution Protocol

When a task involves running an experiment (capability validation, tuning,
model evaluation, or any EXP-XXX from the sprint plan), follow this protocol.
Reproducibility is mandatory, not optional.

**Before running the experiment:**

1. Read Appendix C.1.3 for the 7-element capability experiment template
2. Create experiment folder: `data/experiments/EXP-{NNN}-{short-name}/`
   (see Appendix C.1.6 for naming conventions and folder structure)
3. Write an executable script that reproduces the experiment. The script is
   the experiment; ad-hoc notebook runs without a script are not experiments
4. Define success criteria BEFORE running. Pre-registered criteria prevent
   post-hoc rationalization of ambiguous results
5. Present the experiment design to the user (Gate 1 from Pre-Generation
   Brief Protocol applies)

**After running the experiment:**

6. Capture output to results files in the experiment folder
7. Write results using the 7-element structure from C.1.3
8. Apply Limitation Discovery Protocol (C.1.5) if limitations are found
9. Update `data/experiments/EXPERIMENTS_REGISTRY.md` with the new entry
   (see C.1.6 for registry template)

**Post-experiment assessment:** After documenting results, assess whether the
experiment reveals a contribution opportunity (DSM 4.0 Section 4.4.2).

This protocol is a behavioral trigger: when the agent recognizes that work
constitutes an experiment, it activates this checklist automatically. The
passive reference to C.1.3 in design decision documentation is not sufficient;
this protocol ensures the framework is followed.

---

## 10. Web Research Capture Protocol

When the agent performs web research (web searches, URL fetches, API queries) whose
findings will be synthesized into a deliverable, the raw findings must be captured
before synthesis. Embedding research directly into a deliverable without a traceable
artifact creates hallucination risk: claims appear research-backed but cannot be
verified after the session.

**Before synthesizing web research into any deliverable:**

1. Save raw findings with source URLs to `dsm-docs/research/{date}_{topic}.md`
2. Include: search queries used, URLs visited, key facts extracted, timestamps
3. Then synthesize into the target document, referencing the research file
4. Follow Citation Standards (DSM_0.1) for format within both files

**When this protocol applies:**
- Web searches that produce facts, claims, or data used in a deliverable
- URL fetches whose content informs analysis or recommendations
- Any research where the user might later ask "where did this come from?"

**When this protocol does NOT apply:**
- Internal file reads within the repository (already traceable via git)
- Quick lookups that produce a single verifiable fact (e.g., checking a version number)
- Research performed in dedicated research sessions where the deliverable IS the
  research file itself

This protocol is a behavioral trigger: when the agent recognizes that web research
will feed into a deliverable, it captures findings first. The Citation Standards in
DSM_0.1 cover format and placement of citations; this protocol ensures the underlying
evidence exists to cite.

---

## 11. Context Budget Protocol

The agent's context window is a finite resource. Large file reads and multi-document
research can exhaust it mid-session, forcing compaction and losing earlier reasoning.
This protocol makes context consumption visible and gives the user control.

**Before reading large files (500+ lines):**

Present options to the user:
1. Read the full file (accept context cost)
2. Read targeted sections (specify which parts are needed)
3. Split the file first, then read the relevant fragment (see DSM_0.1 Reference
   File Size Protocol)
4. Defer to a new session with full context available

**Context threshold warning:**

When estimated remaining context drops below ~40%, proactively alert the user:
- State the estimated remaining capacity
- Suggest session wrap-up or scope reduction
- Do not wait for the system warning at 80%; surface the concern early enough
  for the user to make a deliberate choice

**Session planning:**

When a session involves multiple large files or extensive research:
- Estimate total context needs at planning time
- If the estimate suggests the session will approach context limits, scope
  accordingly: prioritize files, defer secondary reads, or plan a continuation
  session

**Anti-Patterns:**

**DO NOT:**
- Read a 2,000-line file without warning the user about context impact
- Wait until compaction is imminent to mention context pressure; by then the
  user has lost the ability to choose a clean wrap-up
- Guess remaining context; use system warnings and file sizes as indicators

---

## 12. Two-Pass Reading Strategy for Long Structured Files

When the agent needs to read a structured text file of 200+ lines (markdown,
plain text, or converted-to-markdown), use a two-pass approach instead of
sequential chunk reading. Sequential chunks miss items at boundaries and
provide no structural map before diving into content.

**Trigger:** Structured text files of 200+ lines. Non-markdown, non-text files
of any size should be converted to markdown first (see `scripts/convert_to_markdown.py`
in DSM Central), then the protocol applies to the converted output.

**Flow:**

1. **Scope assessment offer:** Agent informs the user: "This file is N lines.
   Would you like a scope assessment to identify sections we could skip?"
2. **User decides:** Y (scope filtering) or N (read everything)
3. **Pass 1 (structural scan):** Agent uses Grep to extract headings, entry
   markers, and structural boundaries in a single tool call. Produces a skeleton:
   section titles, nesting levels, approximate line ranges, item counts per section.
   Patterns by file type:
   - **Markdown:** `^#{1,6}`, `^- \*\*`, numbered lists, table headers
   - **Plain text:** ALL CAPS lines, `===`/`---` underlines, numbered section
     headers (e.g., `1.`, `1.1`), indentation level changes
4. **Scope filtering gate (conditional):** If user said Y at step 2, the agent
   presents the skeleton with recommendations: "Based on [current task], these
   sections appear less relevant: [list with reasons]. Skip them?" User can
   approve all, approve some, or dismiss all. If user said N, skip this step.
5. **Pass 2 (semantic extraction):** Agent reads content of sections that
   survived filtering (or all sections if no filtering). Targeted reads by line
   range, extracting meaning, key data points, and actionable items.

**Integration with Context Budget Protocol:** The two-pass strategy is the
implementation technique for the "targeted sections" option in the Context
Budget Protocol. When that protocol presents options for reading large files,
the two-pass strategy provides the method for identifying which sections to target.

**Does not apply to:** Code files (which have better tooling: Grep, Glob,
language-aware search), files under 200 lines (overhead exceeds benefit),
or files the agent has already read in the current session.

---

## 13. Inclusive Language

All DSM documents, code comments, commit messages, and generated artifacts must use
inclusive, neutral language. This applies to both the human and the agent.

**Avoid:**
- Violence-implying language: "battle-tested", "kill", "nuke", "destroy" (use "field-proven", "remove", "clear", "delete")
- Gendered language: "king", "mankind", "manpower" (use role-neutral terms)
- Political language: "manifesto", "regime" (use "guide", "framework", "system")
- Religious language: "soul", "blessing", "gospel" (use secular alternatives)
- Superiority-implying language: cocky or dismissive tone, "obviously", "of course you know"
- ASCII approximations for non-English characters: when writing in any language, use proper diacritical marks and special characters (German: ä, ö, ü, ß; French: é, è, ê, ç; Spanish: ñ, á, é, í, ó, ú). Substituting "oe" for "ö", "ue" for "ü", or "ss" for "ß" is incorrect and unprofessional (observed in prior sessions)

**Why this matters:** DSM documents are read by diverse audiences across projects.
Language that excludes, alienates, or assumes shared cultural context reduces
accessibility. Neutral, professional language ensures the methodology is welcoming
to everyone.

**Personal names:** Do not use personal names in methodology documentation (DSM_0
through DSM_6, guides, research files). Use role-neutral references instead ("the
analyst", "the stakeholder", "the contributor"). Author attribution is acceptable
in backlog items, blog posts, README author sections, and contributor profiles.

**Scope:** This applies to all DSM documents, spoke project artifacts generated
under DSM guidance, commit messages, PR descriptions, and blog posts.

**External contributions (Match the Room with guardrails):** When contributing to
external projects, follow the external project's conventions. However, if the
external project's language conventions conflict with DSM inclusive language
standards, the agent must surface the conflict to the human and obtain explicit
approval before adopting that language. This is not a silent override; it is a
conscious decision that the human acknowledges and accepts.

---

## 14. Heading Parsability Convention for DSM Documents

Since DSM is self-authored, heading conventions can eliminate cross-reference
detection noise at the source rather than building complex NLP filters. This is
the "Take a Bite" philosophy applied to documentation format: fix the input,
not the parser.

### 14.1. Minimum Token Count (MUST)

Any referenceable heading MUST have at least 4 non-stopword tokens.

- Bad: `## Overview` (1 token)
- Bad: `## Test Plan` (2 tokens)
- Good: `## Experiment Gate Test Plan` (4 tokens)
- Good: `## Sprint Planning Experiment Gate` (4 tokens)

### 14.2. Cross-Document Uniqueness (SHOULD)

Cross-referenceable headings SHOULD be unique across the DSM document set.
This eliminates ambiguity when tools or agents resolve references.

### 14.3. Protocol Naming (SHOULD)

Protocol-level headings SHOULD include the protocol or concept name.

- Bad: `## Enforcement`
- Good: `## Session Transcript Append-Only Enforcement`

### 14.4. Format Conversion Applicability

When creating markdown files from other formats (PDF, DOCX, HTML, PPTX),
short headings from the source document should be expanded or flagged for
manual review. This convention serves as a quality criterion for converted
output and directly improves the effectiveness of structural scanning
strategies (see BL-222).

### 14.5. Enforcement

Enforceable via Graph Explorer linter rule W004 (warning, not error). Projects
using GE can validate heading compliance automatically.

### 14.6. Document Structure Standard Reference

For document-level structure rules including modularization triggers, line
budgets, file indexes, and the intro paragraph requirement, see
`dsm-docs/guides/document-structure-standard.md`.

---

## 15. AI Collaboration Principles

The interaction protocols in this document (Notebook Collaboration, App Development,
Pre-Generation Brief, Sprint Cadence, Session Transcript) implement the principles
defined in `DSM_6.0_AI_Collaboration_Principles_v1.0.md`. That document provides the
foundational reasoning; this document provides the operational protocols.

When evaluating whether a delivery is the right size, apply the core test from
DSM 6.0: can the reviewer engage with it and respond with substance? See
`TAKE_A_BITE.md` for the short version.

---

## 16. Active Suggestion Protocol

When the human explicitly invites input (phrases like "Any questions or
suggestions?", "Thoughts?", "What do you think?", "Suggestions?", or
equivalent), the agent MUST offer at least one substantive suggestion or
question before proceeding. This is not optional politeness; it is a
collaboration protocol requirement implementing DSM_6.0's bidirectional
input principle.

A substantive suggestion or question:
- Draws on the agent's analysis of the current context
- Proposes a concrete improvement, alternative, or consideration
- Is not a restatement of what the human just said

If the agent genuinely has no suggestions (rare), it must state this
explicitly ("I have no additional suggestions at this point") rather than
proceeding silently. Silence after an invitation is indistinguishable from
passive compliance and degrades the collaboration.

---

## 17. CLAUDE.md Configuration

Every project CLAUDE.md must include an `@` reference to this Custom Instructions template:

```markdown
@/path/to/agentic-ai-data-science-methodology/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]

## Project-Specific Instructions
[project-specific content here]
```

The `@` reference ensures consistent human-agent interaction patterns across all DSM projects. Project-specific instructions follow after the reference.

**Protocol precedence:** When a project-specific CLAUDE.md contains rules that
conflict with generic DSM_0.2 protocols, the **project-specific rules take
precedence**. This is especially critical for External Contribution projects,
where the project CLAUDE.md defines governance boundaries (e.g., "governance
artifacts live in DSM Central, not in this repo") that generic protocols are not
aware of. The agent must read and internalize the project CLAUDE.md before
executing any DSM_0.2 protocol that creates files or modifies project structure.

**WARNING:** The `@` reference is the **discovery mechanism** for DSM_0.2 itself.
Without it, the agent cannot locate or follow any DSM_0.2 protocol (session
transcript, pre-generation briefs, inbox checks, project type detection). A
missing or stale `@` reference silently disables all inherited protocols.
Run `/dsm-align` to validate the reference exists and points to the current path.

**IDE Permission Mode:** When using Claude Code in VS Code, set `"claudeCode.initialPermissionMode": "default"` to require explicit approval for file writes. See DSM 4.0 Section 11 (GitHub Repository Setup Checklist) for details.

**WARNING: Protocol Reinforcement Required**

The `@` reference imports protocols as background context, but agents may deprioritize inherited content when the project-specific CLAUDE.md is silent on a topic. Critical workflow protocols **must be reinforced** in the project-specific section:

| Protocol | Reinforce When | Key Rule to Restate |
|----------|---------------|---------------------|
| Notebook Collaboration Protocol | DSM 1.0 or Hybrid projects | "Generate ONE cell at a time, wait for output" |
| App Development Protocol | DSM 4.0 projects | "Guide step by step, user approves via permission window" |
| Pre-Generation Brief Protocol | All projects | "Three-gate model: concept (explain) → implementation (diff review) → run (when applicable); each gate = explicit stop" |
| Session Transcript Protocol | All projects | "Append thinking to .claude/session-transcript.md BEFORE acting; output AFTER; conversation text = results only; use Reasoning Delimiter Format with `<------------Start Thinking / HH:MM------------>`; no end delimiter needed" |

**Example reinforcement in project CLAUDE.md:**
```markdown
## App Development Workflow (reinforces inherited protocol)
- Explain why before each action
- Create files via Write/Edit tools; I approve via permission window
- Wait for my confirmation before proceeding to next step
```

```markdown
## Session Transcript Protocol (reinforces inherited protocol)
- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  <------------Start Thinking / HH:MM------------>
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
- Append technique: read last 3 lines, use last non-empty line as anchor.
  NEVER match earlier content for mid-file insertion.
```

**WARNING:** Spoke reinforcement blocks must include the literal delimiter syntax shown in the example above. Referencing "Reasoning Delimiter Format" by name is insufficient; agents default to markdown heading style when the syntax is absent from the local CLAUDE.md (observed in spoke project sessions).

Without reinforcement, the agent's default behavior (batching outputs, generating multiple steps) overrides the inherited protocol.

### 17.1. CLAUDE.md Alignment Template System

To eliminate reinforcement drift, `/dsm-align` manages a delimited section in each
spoke's `.claude/CLAUDE.md`. This section is generated from templates defined below
and updated automatically. Project-specific content lives outside the delimiters.

**Structure of a spoke CLAUDE.md:**

```markdown
@{path-to}/DSM_0.2_Custom_Instructions_v1.1.md

<!-- BEGIN DSM_0.2 ALIGNMENT - do not edit manually, managed by /dsm-align -->
[template-generated content, varies by project type]
<!-- END DSM_0.2 ALIGNMENT -->

# Project: [Name]
Domain: [domain]

## Project-Specific Instructions
[custom content, overrides, domain config]
```

**Delimiter rules:**
- The `@` reference comes first (discovery mechanism)
- The aligned section follows immediately after the `@` reference
- Project-specific content comes after the `<!-- END -->` marker
- `/dsm-align` only modifies content between the delimiters; everything outside is untouched
- Manual edits between delimiters will be flagged as drift and overwritten on next alignment

**Base template (all project types):**

```markdown
## DSM Alignment (managed by /dsm-align)

**Project type:** [detected type] ([DSM version])
**Participation pattern:** [detected pattern]

### Session Transcript Protocol (reinforces inherited protocol)
- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  <------------Start Thinking / HH:MM------------>
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
- Append technique: read last 3 lines, use last non-empty line as anchor.
  NEVER match earlier content for mid-file insertion.

### Pre-Generation Brief Protocol (reinforces inherited protocol)
- Three-gate model: concept (explain) → implementation (diff review) → run (when applicable)
- Each gate requires explicit user approval; gates are independent

### Inbox Lifecycle (reinforces inherited protocol)
- After processing an inbox entry, move it to `_inbox/done/`
- Do not mark entries as "Status: Processed" while keeping them in place

### Punctuation
Use "," instead of "—" for connecting phrases in any language.
```

**DSM 1.0 (Data Science) addition:**

```markdown
### Notebook Collaboration Protocol (reinforces inherited protocol)
- Generate ONE cell at a time, wait for user to run and share output
- Number each cell with a comment (e.g., `# Cell 1`)
- "Continue" = generate next cell; "Generate all cells" = explicit batch override
```

**DSM 4.0 (Application) addition:**

```markdown
### App Development Protocol (reinforces inherited protocol)
- Explain why before each action
- Create files via Write/Edit tools; user approves via permission window
- Wait for user confirmation before proceeding to next step
- Build incrementally: imports → constants → one function → test → next function
```

**Hybrid (DSM 1.0 + DSM 4.0) addition:**

Both the Notebook and App Development blocks are included.

**DSM 5.0 (Documentation):** Base template only (no additional blocks needed).

**Template versioning:** Templates are versioned implicitly by this document's version.
When DSM_0.2 is updated and a template changes, `/dsm-align` detects drift and
offers to regenerate. The `@` reference chain ensures spokes always have access
to the current template definitions.

---

## 18. Ecosystem Path Registry

Cross-repo paths (portfolio, contributions-docs, other ecosystem projects) are
declared in `.claude/dsm-ecosystem.md`, a gitignored file local to each DSM
instance. This eliminates hardcoded filesystem paths from methodology documents
and makes DSM Central portable across environments.

**Registry consumption:** The agent reads the registry once at session start
(during `/dsm-go` Step 2a.5), validates that each declared path exists, and
caches the values for the session. Protocols that need cross-repo paths resolve
them from the registry using logical names.

**Logical names:**

| Name | Used by | Fallback if absent |
|------|---------|-------------------|
| `dsm-central` | Inbox push, feedback push, migration confirmation | Resolved from `@` reference in CLAUDE.md |
| `portfolio` | README change notification | Warn and skip notification |
| `contributions-docs` | External contribution governance | Warn and skip governance operations |

**Required for all project types.** Every DSM project (hub, spoke, external
contribution) must have `.claude/dsm-ecosystem.md` with at least `dsm-central`
and `portfolio` entries. Without these, inbox routing, feedback push, and
portfolio notifications fail silently or waste context searching the filesystem.
Run `/dsm-align` to create the file with a standard template.

**When the registry does not exist:** The agent warns at session start:
"Missing `.claude/dsm-ecosystem.md`. Run `/dsm-align` to create it with
required ecosystem pointers (`dsm-central`, `portfolio`)." The agent uses
fallback resolution where available (dsm-central from `@` reference) but
flags the missing registry as an action item, not a silent skip.

**Path validation:** At session start, for each registry entry, check that the
path exists on the filesystem. If a path does not exist, warn the user but
continue the session. Do not fail silently and do not halt.

**File format:** Markdown table with Name, Path, Description, and optional Mirror columns.
See the template in the DSM_0.2 source or create with `/dsm-align`.

**Mirror repos:** Entries with `mirror: true` receive automatic file sync after
Central methodology changes. When the Version Update Workflow completes (step 9),
the agent copies changed methodology files to each mirror repo, commits, and pushes.
This ensures public distribution repos stay current without manual intervention.

---

## 19. Branch Testing Requirement

Task branches (Level 3) must be tested before merging to their parent branch.
No exceptions.

Merging untested changes propagates broken protocols, missing references,
or structural issues to all spoke projects via the `@` reference chain. The cost
of testing is low; the cost of a broken merge is high.

**Minimum verification before merge:**
- Structural integrity: files exist, expected line counts, no truncation
- Cross-references: all internal references resolve (dispatch table entries match module headers, section references point to existing sections)
- Spoke compatibility: `@` reference still resolves, no new dependencies on features spokes cannot access

**BL-specific test plan:** Each backlog item that requires a feature branch must
include a Test Plan section with specific, verifiable conditions. These conditions
are defined at BL creation time and checked off on the branch before merge. The
test plan adds BL-specific verification on top of the minimum categories above.

**Agent behavior:** After completing implementation on a feature branch, run
both the minimum verification above and the BL's Test Plan conditions before
proposing merge. Never suggest "ready to merge" without a testing step.

---

## 20. Three-Level Branching Strategy

A universal branching model for all DSM projects, regardless of whether they
use BLs, sprints, or neither.

### 20.1. Level 1: Main Branch (`main` / `master`)

The production line. Only receives merges from Level 2 session branches.

### 20.2. Level 2: Session Branch

Created at every session start (`/dsm-go`, `/dsm-light-go`). This is the
universal working branch for all project types, including portfolio, notebook,
and projects without BLs or sprints.

**Naming:** `session-N/YYYY-MM-DD` (or project-specific convention).

**Merge to Level 1:** At session wrap-up (`/dsm-wrap-up`) or light wrap-up
(`/dsm-light-wrap-up`), only if all Level 3 branches have been formally
merged back. If Level 3 branches remain open, the session branch stays open
and is pushed to remote for cross-session continuity.

### 20.3. Level 3: Task Branches

Created during a session for specific work items. Three types:

| Type | Trigger | Naming | Merge condition |
|------|---------|--------|-----------------|
| BL branch | BL implementation starts | `bl-NNN/short-description` | BL moved to `done/` |
| Sprint branch | Sprint work begins | `sprint-N/short-description` | All sprint plan items checked off |
| Parallel-session branch | `/dsm-parallel-session-go` | `parallel/short-description` | `/dsm-parallel-session-wrap-up` |

**Merge to Level 2:** Only when formal exit criteria are met. Level 3 branches
merge to the session branch, not directly to main.

**Exceptions (commit directly to session branch):** Mechanical status updates
(BL moved to done/), trivial fixes (typos, dates), session artifacts (handoffs,
checkpoints, feedback).

### 20.4. Branch Push Policy

**Default: local only.** Branches are not pushed to GitHub unless needed.

**Push triggers:**
1. **Session ends with open Level 3 branch:** The open Level 3 branch is pushed
   to remote so the next session can resume work
2. **Explicit review request:** The user requests a push for review or evaluation
   before committing to merge
3. **Consolidation branch retention:** Branches implementing backlog consolidations
   must be pushed to remote. The remote branch is not deleted until the last BL
   referenced by the consolidation is resolved

**Cleanup:** Branches are deleted (locally and remotely if pushed) immediately
after merging to their parent branch. Exception: consolidation branches are
deleted only when all referenced BLs are resolved.

### 20.5. Session-Start Branch Resumption Protocol

At session start (`/dsm-go`, `/dsm-light-go`), the agent checks for open
branches from previous sessions:

1. Check for pushed Level 2 or Level 3 branches that were not merged
2. If found, inform the user: "There is an open [session/BL/sprint/parallel]
   branch `[branch-name]` from a previous session. The logical next step is
   to finalize this work before starting new work."
3. Resume on the open branch rather than creating a new session branch

### 20.6. Why Session Branches

Some projects (portfolio, notebook-based, spoke projects) do not work with BLs
or sprints. A session branch provides isolation and reversibility for every
session regardless of workflow type. If a session produces no formal task
branches, all commits land on the session branch and merge to main at wrap-up.

### 20.7. Relationship to Branch Testing Requirement

The Branch Testing Requirement (above) applies to Level 3 → Level 2 merges.
Before merging a task branch to the session branch, run the minimum verification
and any BL-specific test plan conditions.

---

## 21. Backlog Scope Rule

A backlog item must address a single, independently completable topic. When
creating or reviewing a BL, check for split indicators:

- **Different execution contexts:** parts that belong in different repos or sessions
- **Independent success criteria:** one part can be "done" while another is pending
- **Different complexity levels or timelines:** parts with mismatched effort

If any indicator is present, split into separate BLs. A BL that cannot be fully
marked "done" because an unrelated part is pending is too broad.

**Agent behavior:** When the agent encounters a multi-topic BL during
implementation, flag it to the user: "This BL addresses [N] independent topics.
Split before implementing?"

### 21.1. Backlog Naming Rule

Backlog item titles must be self-explanatory. A user scanning the backlog README
should understand each item's purpose without opening the file. The title is the
primary interface to the backlog; jargon, abbreviations, or internal codenames
that require context to parse belong in the description, not the title.

**Test:** If the title requires reading the BL file to understand what it does,
rename it.

**Agent behavior:** When creating a BL, propose a title and verify it passes the
test above. When reviewing existing BLs (e.g., during consolidation or triage),
flag titles that fail the test and propose renames.

---

## 22. Protocol Violation Triage Response

When the agent discovers that a DSM protocol was not followed, whether in the
current session or inherited from a prior session, it must execute a three-step
response before continuing other work:

1. **Fix:** Address the immediate issue (e.g., renumber a duplicate BL,
   move a misplaced file, correct a stale reference)
2. **Root-cause:** Identify why the violation occurred (e.g., a protocol
   lacks a validation step, a session skipped a required check, a parallel
   session had no collision guard)
3. **Prevent:** Propose a protocol fix or create a BL for the root cause.
   If the fix is mechanical (adding a check to an existing protocol), propose
   inline. If it requires design decisions, create a BL

The agent must present all three steps to the user. Skipping steps 2 and 3,
treating the violation as a one-off cleanup task, is the failure mode this
protocol prevents.

**Behavioral trigger:** This protocol activates whenever the agent observes:
- A collision, conflict, or inconsistency caused by a protocol gap
- An artifact in an unexpected format or location (e.g., BL file outside
  `plan/backlog/`)
- A required step that was skipped or executed incorrectly by a prior session

**Scope:** This protocol is in DSM_0.2 core (always loaded via `@`) because
it must be active in every session across all DSM projects. It is not gated
behind a module read.

---

## 23. References

- Preston-Werner, T. (2013). [Semantic Versioning 2.0.0](https://semver.org/)
- Procida, D. (2017). [Diataxis Documentation Framework](https://diataxis.fr/)

---

## 24. Module Dispatch Table

DSM_0.2 protocols are split into this core file (always loaded via `@`) and
four on-demand modules. When a task requires a protocol from this table, read
the corresponding module file using the Read tool before applying the protocol.

All module files are in the same directory as this core file.

### 24.1. Core Sections (this file)

| § | Protocol |
|---|----------|
| 1 | Project Type Detection |
| 2 | Session-Start Version Check |
| 3 | Session-Start Inbox Check |
| 4 | Session-Start GitHub Issue Check |
| 5 | Read-Only Access Within Repository |
| 6 | Reasoning Delimiter Format |
| 7 | Session Transcript Protocol |
| 8 | Pre-Generation Brief Protocol |
| 9 | Experiment Execution Protocol |
| 10 | Web Research Capture Protocol |
| 11 | Context Budget Protocol |
| 12 | Two-Pass Reading Strategy for Long Structured Files |
| 13 | Inclusive Language |
| 14 | Heading Parsability Convention for DSM Documents |
| 15 | AI Collaboration Principles |
| 16 | Active Suggestion Protocol |
| 17 | CLAUDE.md Configuration |
| 18 | Ecosystem Path Registry |
| 19 | Branch Testing Requirement |
| 20 | Three-Level Branching Strategy |
| 21 | Backlog Scope Rule |
| 22 | Protocol Violation Triage Response |
| 23 | References |

### 24.2. Module Protocols (on-demand)

| Protocol | Trigger | Module |
|----------|---------|--------|
| Session-End Inbox Push | Session wrap-up, feedback ready to send | [A](DSM_0.2.A_Session_Lifecycle.md) |
| README and Feature Timeline Change Notification | README.md or FEATURES.md modified during session | [A](DSM_0.2.A_Session_Lifecycle.md) |
| External Contribution Milestone Notification | External contribution session with notable milestone | [A](DSM_0.2.A_Session_Lifecycle.md) |
| DSM Feedback Tracking | Capturing methodology feedback or backlog proposals | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Technical Progress Reporting | Sprint boundary, engineering work to report | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Lightweight Session Lifecycle | Continuation session with known task, tight context | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Parallel Session Protocol | Concurrent isolated tasks, independent branch work | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Reasoning Lessons Protocol | Session wrap-up (extraction), session start (reading) | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Continuous Learning Protocol | Session start/end, external knowledge integration | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Artifact Lifecycle Management | Transcript retirement, checkpoint supersession | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Sprint Cadence and Feedback Boundaries | Sprint planning, boundary checklists | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session Delivery Budget | Estimating session work volume, mid-session check | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Mechanical vs Decision Edits | Multiple edits to stage, distinguishing edit types | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session Configuration Recommendation | Session start, mid-session task shift | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Responsible Collaboration Timer | Session start, cumulative time exceeds threshold | [A](DSM_0.2.A_Session_Lifecycle.md) |
| GitHub Issue Intake Protocol | Session-start issue check, external issue triage | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Composition Challenge Protocol | Producing a collection of 2+ discrete items | [B](DSM_0.2.B_Artifact_Creation.md) |
| Edit Explanation Stop Protocol | Multiple distinct edits to a single file | [B](DSM_0.2.B_Artifact_Creation.md) |
| Enabling File Content Protocol | Working with backlog items, checkpoints, plans | [B](DSM_0.2.B_Artifact_Creation.md) |
| Notebook Collaboration Protocol | Generating Jupyter notebook cells (DSM 1.0) | [B](DSM_0.2.B_Artifact_Creation.md) |
| Notebook-to-Script Transition | Code exceeds notebook scope, long-running computation | [B](DSM_0.2.B_Artifact_Creation.md) |
| App Development Protocol | Building application code (DSM 4.0) | [B](DSM_0.2.B_Artifact_Creation.md) |
| Revert Safeguards Protocol | BL implementation touching untracked files | [B](DSM_0.2.B_Artifact_Creation.md) |
| Secret Exposure Prevention | Staging files for git commit | [C](DSM_0.2.C_Security_Safety.md) |
| Destructive Action Protocol | Cross-repo writes, file deletion, methodology changes | [C](DSM_0.2.C_Security_Safety.md) |
| Untrusted Input Protocol | Processing inbox entries, tool outputs, web results | [C](DSM_0.2.C_Security_Safety.md) |
| Query Sanitization | Constructing web search queries or API requests | [C](DSM_0.2.C_Security_Safety.md) |
| Breaking Change Notification Protocol | DSM_0.2 introduces a breaking change | [D](DSM_0.2.D_Research_Onboarding.md) |
| External DSM Descriptions | Describing DSM in external-facing documents | [D](DSM_0.2.D_Research_Onboarding.md) |
| Step 0: Situational Assessment | New project onboarding, external contributions | [D](DSM_0.2.D_Research_Onboarding.md) |
| Phase 0.5: Research and Grounding | Novel domain, model selection, unfamiliar problem | [D](DSM_0.2.D_Research_Onboarding.md) |
| Environment Preflight Protocol | Project with native toolchains, system dependencies | [D](DSM_0.2.D_Research_Onboarding.md) |
| First Session Prompt for New Projects | New spoke project scaffolded | [D](DSM_0.2.D_Research_Onboarding.md) |
| Phase-to-DSM-Section Mapping | Sprint planning, phase type identification | [D](DSM_0.2.D_Research_Onboarding.md) |
| Command File Version Tracking | Modifying DSM command files | [D](DSM_0.2.D_Research_Onboarding.md) |
