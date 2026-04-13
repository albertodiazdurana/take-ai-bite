---
**DSM Custom Instructions: v1.4.1**
**Last Breaking Change:** 2026-03-15 (DSM_0.2 Modularization, BACKLOG-090)
**Status:** Active, Cross-Project Governance
**Architecture:** Slim core + 4 on-demand modules (see Module Dispatch Table)
---

## Contents

1. [Project Type Detection](#1-project-type-detection) → Module A
2. [Session-Start Version Check](#2-session-start-version-check) → Module A
3. [Session-Start Inbox Check](#3-session-start-inbox-check) → Module A
4. [Session-Start GitHub Issue Check](#4-session-start-github-issue-check) → Module A
5. [Read-Only Access Within Repository](#5-read-only-access-within-repository)
6. [Session Transcript Delimiter Format](#6-session-transcript-delimiter-format)
7. [Session Transcript Protocol](#7-session-transcript-protocol)
8. [Pre-Generation Brief Protocol](#8-pre-generation-brief-protocol)
9. [Experiment Execution Protocol](#9-experiment-execution-protocol)
10. [Web Research Capture Protocol](#10-web-research-capture-protocol)
11. [Context Budget Protocol](#11-context-budget-protocol) → Module A
12. [Two-Pass Reading Strategy for Long Structured Files](#12-two-pass-reading-strategy-for-long-structured-files) → Module A
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
23. [Third-Party Skill Governance](#23-third-party-skill-governance)
24. [References](#24-references)
25. [Module Dispatch Table](#25-module-dispatch-table)

---

Confirm that you understand what I need. Be concise in your work.

## 1. Project Type Detection

Moved to [Module A §17](DSM_0.2.A_Session_Lifecycle.md). Read at session start.

## 2. Session-Start Version Check

Moved to [Module A §18](DSM_0.2.A_Session_Lifecycle.md). Read at session start.

## 3. Session-Start Inbox Check

Moved to [Module A §19](DSM_0.2.A_Session_Lifecycle.md). Read at session start.

## 4. Session-Start GitHub Issue Check

Moved to [Module A §20](DSM_0.2.A_Session_Lifecycle.md). Read at session start.

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

## 6. Session Transcript Delimiter Format

Standard delimiters for all entry types in the session transcript file.
See Session Transcript Protocol below for when and where to use them.

**Three delimiter types:**

```
<------------Start Thinking / HH:MM------------>
<------------Start Output / HH:MM------------>
<------------Start User / HH:MM------------>
```

| Type | When to use |
|------|-------------|
| Thinking | Agent reasoning, decision processes, planning (before acting) |
| Output | Summary of completed work (after acting) |
| User | Summary of the user's prompt (start of each turn) |

The next `<------------Start ... / HH:MM------------>` delimiter of any type
implicitly closes the previous block. No explicit end delimiter is needed.

**Rules:**
- HH:MM is the time of day when the block begins (24-hour, local timezone)
- Blank line after the delimiter for readability
- These delimiters are used exclusively inside `.claude/session-transcript.md`
- Do NOT output delimiters in conversation text; the VS Code extension
  collapses them after streaming (microsoft/vscode#287658)
- All three types follow the same format; only the type label differs

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

**Format** (uses Session Transcript Delimiter Format above):

```
<------------Start User / HH:MM------------>

[prompt summary]

<------------Start Thinking / HH:MM------------>

[reasoning content]

<------------Start Output / HH:MM------------>

[summary of what was done]
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

**Unconditional activation (BL-331):** If `.claude/session-transcript.md`
exists in the project, the Session Transcript Protocol is active. No skill
needs to activate it. The presence of the file is the activation signal.
This rule is independent of `/dsm-go` Step 6 and does not depend on any
session-start flow having run successfully. It is the third independent
enforcement layer alongside the per-turn hook (occurrence) and the
PreToolUse shape validator. Any session that finds the file present must
follow the protocol from the first turn, including continuation sessions
that defer from `/dsm-light-go` to `/dsm-go` mid-flight.

**Authorized exception: `/dsm-staa` (BL-351).** The Session Transcript
Analysis Agent (`/dsm-staa`) is the sole authorized exception to the
unconditional activation rule above. STAA sessions intentionally do not
write to `.claude/session-transcript.md`, for a meta-recursion reason
explained in `scripts/commands/dsm-staa.md`: if STAA sessions wrote their
own transcripts, those transcripts would become subjects of future STAA
sessions, and STAA would analyze its own analysis indefinitely. The
concern is about the reasoning-log file being a future subject, not about
corruption of the archived subject file STAA is currently reading,
those are two different files (`.claude/transcripts/{timestamp}-ST.md`
is the archived subject, `.claude/session-transcript.md` is the live
reasoning log), and writes to the live log do not touch the archived
subject. No other skill may suppress the protocol without an explicit
amendment to this section. The `UserPromptSubmit` per-turn hook will
still fire in STAA sessions and inject the reminder; STAA agents should
read this paragraph first, then proceed without appending to the live
transcript. Systematic resolution of the hook/skill collision is tracked
under BL-343 (Skill/Hook Collaboration Protocol).

**Anti-Patterns:**

**DO NOT:**
- Output reasoning in conversation text; the user reads reasoning in the transcript file, not the chat
- Batch transcript entries at the end of a turn; the user cannot review reasoning after the fact
- Skip the transcript append on turns with non-trivial reasoning
- Commit the transcript file; it is a session-scoped working artifact
- Edit or rewrite past transcript entries; each entry reflects reasoning at the time it was written
- Use Edit with `old_string` matching earlier content to insert entries mid-file; this causes out-of-order timestamps (observed in prior sessions). Use the mandatory append technique above
- Use reasoning delimiters in conversation text; VS Code collapses them after streaming
- **Use single-quoted heredoc (`<< 'EOF'`) when appending to the transcript via Bash** if the content contains shell expansions like `$(date +%H:%M)`. Single-quoted heredocs suppress expansion and write the literal string `$(date +%H:%M)` into the transcript instead of the timestamp. Observed in portfolio S69. Correct form: capture the timestamp into a variable first and use an unquoted heredoc:
  ```bash
  NOW=$(date +%H:%M)
  cat >> .claude/session-transcript.md << EOF
  <------------Start Thinking / ${NOW}------------>
  ...
  EOF
  ```
  The Edit-tool append path (read last 3 lines, anchor on last non-empty line) is preferred and avoids heredoc quoting entirely. Use heredoc only when the Edit path is unavailable.

**Per-Turn Transcript Append Enforcement Mechanism:**

Static rules and operator discipline are insufficient to keep this protocol
active across long sessions; in S171 the agent skipped appends for 7
consecutive turns despite both §7 and `/dsm-go` step 6 telling it not to.
The reliable enforcement layer is a `UserPromptSubmit` hook in
`.claude/settings.json` that injects a per-turn reminder. Two hooks form a
complementary pair: the `UserPromptSubmit` hook enforces *occurrence* (an
append must happen this turn), and `validate-transcript-edit.sh` (PreToolUse
on Edit) enforces *shape* (anchor, append-only, delimiter). Neither IDE
monitoring nor session-start "behavioral activation" is the enforcement
mechanism; both are user-facing affordances that document intent without
requiring it. The hook is the mechanism.

**Turn-Boundary Transcript Append Self-Check:**

Every turn begins with a transcript append. Every turn. At the start of
every turn, before composing a response, the agent must ask: "Was my
first tool call this turn an append to `.claude/session-transcript.md`?"
If the answer is no, the protocol has been violated. The check is binary;
no "I planned to" or "the next call would have been" answers count.

This rule applies to turns that produce reasoning, recommendations, or
decisions **without touching any files**. Pure-reasoning turns are
explicitly covered: a turn whose response is a multi-paragraph decision
analysis, trade-off comparison, or recommendation requires the same
first-tool-call transcript append as a turn that edits code. The
pure-reasoning-turn failure mode is the most damaging variant because
pure-reasoning turns contain the highest-value thinking (decision
rationale, considered-and-rejected paths, risk framing) and losing that
content inverts the transcript's stated purpose as a reasoning log.

**Example of the pure-reasoning-turn failure mode:** a turn in which the
user asks "which of these two options should we pick?" and the agent
responds with a multi-paragraph comparison (five-question gate
evaluation, Option A vs Option B analysis, recommendation, proposed
next steps) as a pure-text response with zero tool calls. This is a
protocol violation. The agent must append thinking to the transcript as
the first tool call of that turn, even though the turn would otherwise
have none. The transcript append is the one required tool call.

**The only exemption is content-trivial turns:** one-word
acknowledgments ("Understood", "OK"), single-fact confirmations ("Yes",
"No"), and responses with no new reasoning. The exemption is content-
based, not tool-call-count-based. A turn that produces substantive new
reasoning of any length is never content-trivial, regardless of whether
it touches files. If there is new reasoning, there is a transcript
append.

**[RETROACTIVE] Transcript Append Self-Detection Rule:**

If the agent detects mid-turn or at the start of a later turn that it
missed an earlier append, it must:

1. Append a recovery entry to the transcript labeled
   `<------------Start Thinking [RETROACTIVE] / HH:MM------------>` where
   HH:MM is the *current* time, not a fabricated earlier time.
2. State which turn(s) were missed and a brief reconstruction of the
   reasoning that would have been recorded.
3. Note the gap explicitly; never edit history or insert mid-file to make
   it look like the appends happened on time.

Retroactive entries are evidence the protocol failed and recovered, not a
workaround that makes the failure invisible.

**Process Narration for Reasoning Efficiency Analysis:**

Thinking blocks should narrate reasoning *as it unfolds*, not present a
post-hoc clean summary of the decision. Include considered-and-rejected
paths, points of doubt, loops where the same fact is re-verified, and
course corrections. Write "I considered X, rejected it because Y, then
reconsidered because Z" instead of collapsing to "decided on Z".

The motivation is reasoning-efficiency analysis. The model's native
extended thinking already contains loops, second-guessing, anchoring
drift, and redundant re-verification. The collapsed extended-thinking
view in the chat UI exposes those patterns to the user, but is
turn-scoped and not archived. If the transcript thinking block is a
clean summary, it hides exactly the inefficiency signals the user needs
to identify and fix. Clean summaries make the reasoning look tidier
than it was.

A useful thinking block records:

- What the agent considered and why each option was weighed
- Where the agent doubted, looped, or reversed itself
- Which steps were redundant in hindsight (re-reading a file already
  read, re-checking a fact already checked)
- The final decision and the reason it won

Brevity is not the goal. Auditability is. A thinking block that is
longer than the action it precedes is acceptable when the reasoning
warranted it; a thinking block that hides three rounds of self-doubt
behind a single confident sentence is a defect.

This rule does not apply to trivial turns (single-fact answers, simple
acknowledgments) where the "When to skip thinking" rule above already
permits omission. It applies to every turn that warrants a thinking
block at all.

---

## 8. Pre-Generation Brief Protocol

Before creating any artifact (code file, test file, documentation, configuration),
follow the four-gate approval model. Each gate requires explicit user approval
before proceeding to the next.

### 8.0. Gate 0: Collaborative Definition

Before presenting any concept (Gate 1), collaboratively define what the work
is and how it should be structured. Gate 0 governs the dialog phase where work
is understood, decomposed, and packaged before any artifact is conceived.

**Three steps, each requiring explicit confirmation:**

1. **Confirm threads:** Present the identified work items, topics, or threads
   extracted from the user's request. Wait for explicit confirmation that the
   list is complete and correctly framed. Do not proceed until the user agrees
   on *what* the threads are.
2. **Analyze dependencies:** Map relationships, ordering constraints, and
   prerequisites between threads. Present the dependency structure. Wait for
   explicit confirmation.
3. **Package:** Propose how to group threads into actionable units (BLs,
   artifacts, work blocks). Wait for explicit confirmation of the packaging
   before entering Gate 1 for any unit.

After Gate 0 completes, each packaged unit enters its own Gate 1-2-3 cycle
independently. Gate 0 produces the map; Gates 1-2-3 execute each point on
the map.

**When Gate 0 is mandatory:**
- Work involves multiple threads or topics
- Scope or dependencies are unclear
- Planning work (BL definition, sprint planning, architecture decisions)
- Any work that touches agent infrastructure (skills, hooks, settings, commands)

**When Gate 0 may be skipped:**
- Single-topic, well-defined work with no ambiguity (e.g., implementing a
  BL whose scope is already confirmed, fixing a specific bug)
- Trivial artifacts (`.gitkeep`, minor config)

**Anti-pattern:** Presenting a pre-formed plan and asking for yes/no is not
Gate 0. Gate 0 requires the human to shape the structure at each step, not
merely approve a finished proposal.

**Foundational principle:** We Need to Talk (DSM_6.0 §1.10). The conversation
that defines the work IS the collaboration, not a preamble to it.

**Origin:** S182. The step-by-step dialog model for defining BLs 341-344
(confirm threads → analyze dependencies → package) was improvised at the
user's request, then recognized as the missing entry point to all
collaboration.

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

- Gate 0 is mandatory when work has multiple threads, unclear scope, or
  touches agent infrastructure; optional for single-topic, well-defined work
- Gates 1 and 2 are mandatory for every non-trivial artifact
- Gate 3 applies only when the artifact will be executed in this session
- Each artifact gets its own gate cycle; do not batch multiple artifacts
  through gates together
- Gate 0 approval (collaborative definition) does NOT grant concept approval
  (Gate 1); concept approval does NOT grant implementation approval (Gate 2);
  implementation approval does NOT grant run approval (Gate 3)

### 8.5. Pre-Generation Reasoning Structure

Before generating any artifact, apply Critical Thinking (DSM_6.0 §1.4.2) by
answering three questions in the session transcript thinking block:

1. **What** — what is this generation? (type, structure, role in the plan)
2. **Why** — why is it needed? (what requirement or goal it serves)
3. **How** — how will it be done? (approach, constraints, applicable rules)

Present what/why/how to the user as part of Gate 1. Wait for approval before
generating.

**Evidence (on-demand):** After presenting what/why/how, offer: "Should I
display the facts and metrics to explain this approach?" The user accepts or
skips. This keeps the default flow lean while making quantitative depth
available on demand for decisions that warrant it (architecture choices,
hyperparameter selection, algorithm comparisons).

**Behavioral trigger:** This reasoning structure activates within Gate 1 of
every non-trivial artifact. It structures the thinking, not the gate itself.
The what/why/how is written in the transcript thinking block, making reasoning
visible and auditable.

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

### 8.6. Skill Self-Reference Protocol

Before claiming any behavior of a DSM skill (commands like `/dsm-go`,
`/dsm-wrap-up`, `/dsm-align`, `/dsm-finalize-project`, etc.), read the
skill file in `scripts/commands/{skill-name}.md` (or
`~/.claude/commands/{skill-name}.md` for the deployed copy). Do not
answer "does skill X do Y?" from memory, inference, or prior sessions.
The skill file is the only authoritative source; its step list changes
across versions.

This applies equally to user-invoked skills, sub-skills invoked by other
skills, and behavior the agent considers when suggesting wrap-up,
finalization, or alignment actions. The same read-before-answer rule
that applies to source code applies to skill prompt files; the skill
file *is* the source.

**Origin:** efficientnet S8 incident, where the agent claimed
`/dsm-wrap-up` handles portfolio notification when the checklist
actually lives in `/dsm-finalize-project` Section G.3. The claim was
made without reading either file.

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

Moved to [Module A §21](DSM_0.2.A_Session_Lifecycle.md). Read when handling large files or context pressure.

## 12. Two-Pass Reading Strategy for Long Structured Files

Moved to [Module A §22](DSM_0.2.A_Session_Lifecycle.md). Read when processing structured files of 200+ lines.

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

When evaluating whether a delivery is the right size, apply the three-question
test from DSM 6.0 §1.1 before presenting output: (1) can the reviewer read it,
(2) can they form an opinion, (3) can they redirect if needed? If the answer to
any question is no, split the delivery. See `TAKE_A_BITE.md` for the short version.

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

**Scaffolding specification:** The canonical DSM project scaffold (9 `dsm-docs/` folders, `_inbox/`, `.gitattributes`, CLAUDE.md with `@` reference) is defined in DSM_0.1 Section 10 (Canonical Spoke Folder Names) and DSM_3.0.E Section 6.7 (Project Scaffolding). `/dsm-go` Step 0.5 checks scaffold completeness and auto-invokes `/dsm-align` when incomplete.

**IDE Permission Mode:** When using Claude Code in VS Code, set `"claudeCode.initialPermissionMode": "default"` to require explicit approval for file writes. See DSM 4.0 Section 11 (GitHub Repository Setup Checklist) for details.

**WARNING: Protocol Reinforcement Required**

The `@` reference imports protocols as background context, but agents may deprioritize inherited content when the project-specific CLAUDE.md is silent on a topic. Critical workflow protocols **must be reinforced** in the project-specific section:

| Protocol | Reinforce When | Key Rule to Restate |
|----------|---------------|---------------------|
| Notebook Collaboration Protocol | DSM 1.0 or Hybrid projects | "User copies each cell; output ONE cell at a time as a fenced code block; wait for output" |
| App Development Protocol | DSM 4.0 projects | "Guide step by step, user approves via permission window" |
| Pre-Generation Brief Protocol | All projects | "Four-gate model: collaborative definition (confirm threads → dependencies → packaging) → concept (explain) → implementation (diff review) → run (when applicable); each gate = explicit stop" |
| Session Transcript Protocol | All projects | "Append thinking to .claude/session-transcript.md BEFORE acting; output AFTER; conversation text = results only; use Session Transcript Delimiter Format: `<------------Start Thinking / HH:MM------------>`, `<------------Start Output / HH:MM------------>`, `<------------Start User / HH:MM------------>`" |

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
- Use Session Transcript Delimiter Format for every block:
  <------------Start Thinking / HH:MM------------>
  <------------Start Output / HH:MM------------>
  <------------Start User / HH:MM------------>
- HH:MM is 24-hour local time when the block begins; no end delimiter needed
- Append technique: read last 3 lines, use last non-empty line as anchor.
  NEVER match earlier content for mid-file insertion.
```

**WARNING:** Spoke reinforcement blocks must include the literal delimiter syntax shown in the example above. Referencing "Session Transcript Delimiter Format" by name is insufficient; agents default to markdown heading style when the syntax is absent from the local CLAUDE.md (observed in spoke project sessions).

Without reinforcement, the agent's default behavior (batching outputs, generating multiple steps) overrides the inherited protocol.

### 17.1. CLAUDE.md Alignment Template System

To eliminate reinforcement drift, `/dsm-align` manages a delimited section in each
spoke's `.claude/CLAUDE.md`. This section is generated from templates defined below
and updated automatically. Project-specific content lives outside the delimiters.

**Structure of a spoke CLAUDE.md:**

```markdown
@{path-to}/DSM_0.2_Custom_Instructions_v1.1.md

<!-- BEGIN DSM_0.2 ALIGNMENT - do not edit manually, managed by /dsm-align -->
## 1. DSM_0.2 Alignment (managed by /dsm-align)
[template-generated content, varies by project type]
<!-- END DSM_0.2 ALIGNMENT -->

## 2. Participation Pattern
[spoke/hub/standalone/contributor/private-specific instructions]

## 3. Project Type
[notebook/app/documentation-specific instructions]

## 4. Project Specific
[project structure, objectives, tech requirements, domain constraints]
```

**Delimiter rules:**
- The `@` reference comes first (discovery mechanism)
- The aligned section follows immediately after the `@` reference
- Project-specific content comes after the `<!-- END -->` marker
- `/dsm-align` only modifies content between the delimiters; everything outside is untouched
- Manual edits between delimiters will be flagged as drift and overwritten on next alignment

**Base template (all project types):**

```markdown
## 1. DSM_0.2 Alignment (managed by /dsm-align)

**Project type:** [detected type] ([DSM version])
**Participation pattern:** [detected pattern]

### Session Transcript Protocol (reinforces inherited protocol)
- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Session Transcript Delimiter Format for every block:
  <------------Start Thinking / HH:MM------------>
  <------------Start Output / HH:MM------------>
  <------------Start User / HH:MM------------>
- HH:MM is 24-hour local time when the block begins; no end delimiter needed
- Append technique: read last 3 lines, use last non-empty line as anchor.
  NEVER match earlier content for mid-file insertion.
- Per-turn enforcement: a `UserPromptSubmit` hook in `.claude/settings.json`
  injects a reminder every turn. The hook enforces *occurrence*; the
  existing `validate-transcript-edit.sh` PreToolUse hook enforces *shape*.
  IDE monitoring and session-start behavioral activation are user
  affordances, not enforcement. The hook is the mechanism.
- Turn-boundary self-check: every turn begins with a transcript append. If
  your first tool call this turn was not a transcript append, the protocol
  was violated. This includes pure-reasoning turns (decision analysis,
  recommendation, trade-off comparison) that would otherwise touch no files,
  the transcript append is the one required tool call. The only exemption
  is content-trivial turns (one-word acknowledgments, single-fact
  confirmations with no new reasoning). Recover by appending a
  `[RETROACTIVE]` entry with the current HH:MM (never backdate) and a note
  explaining the gap; do not edit history.
- Process narration: thinking blocks narrate reasoning as it unfolds,
  including considered-and-rejected paths, doubts, loops, and reversals.
  Clean post-hoc summaries hide inefficiency signals that are the primary
  input to reasoning-efficiency analysis. Brevity is not the goal,
  auditability is.
- Unconditional activation: if `.claude/session-transcript.md` exists in
  the project, the protocol is active. No skill needs to activate it. The
  presence of the file is the activation signal. This rule is independent
  of `/dsm-go` Step 6 and applies to continuation sessions that defer
  from `/dsm-light-go` to `/dsm-go` mid-flight.
- Heredoc anti-pattern: when appending to the transcript via Bash, never
  use single-quoted heredoc (`<< 'EOF'`) if the content contains shell
  expansions like `$(date +%H:%M)`. Capture the timestamp into a variable
  first and use unquoted heredoc, or prefer the Edit-tool append path
  (read last 3 lines, anchor on last non-empty line).

### Pre-Generation Brief Protocol (reinforces inherited protocol)
- Four-gate model: collaborative definition (confirm threads → dependencies → packaging) → concept (explain) → implementation (diff review) → run (when applicable)
- Each gate requires explicit user approval; gates are independent
- What/why/how thinking block: before Gate 1, answer what the artifact is, why it is needed, and how it will be built, in the session transcript thinking block
- Skill self-reference: before claiming any behavior of a DSM skill (`/dsm-go`, `/dsm-wrap-up`, `/dsm-align`, etc.), read `scripts/commands/{skill-name}.md` or `~/.claude/commands/{skill-name}.md`. Do not answer "does skill X do Y?" from memory.

### Inbox Lifecycle (reinforces inherited protocol)
- After processing an inbox entry, move it to `_inbox/done/`
- Do not mark entries as "Status: Processed" while keeping them in place

### Actionable Work Items (reinforces DSM_3 planning pipeline)
- Only items in `dsm-docs/plans/` (and legacy `plan/backlog/`) are actionable work items.
- Material found elsewhere (`_reference/`, `docs/`, README, inbox, sprint plan drafts) is INPUT to the planning pipeline, not a substitute for it.
- Before suggesting implementation of anything that looks like a plan, verify that a formal BL exists in `dsm-docs/plans/`. If not, route through research → formalize → plan first.

### Punctuation
Use "," instead of "—" for connecting phrases in any language.

### Code Output Standards (reinforces Earn Your Assertions)
- Show actual values: shapes, metrics, counts, paths
- No generic confirmations: avoid "Done!", "Success!", "Data loaded successfully!"
- When uncertain, state the uncertainty; do not guess or fabricate
- Read the relevant source (file, definition, documentation) before answering questions about it; do not answer from partial knowledge
- Let results speak for themselves

### Tool Output Restraint (reinforces Take a Bite)
- Generate only what you can meaningfully process in the next step
- Comprehensive tool reports are reference material, not the analysis itself
- Run tools because the output serves the task, not because the tool is available

### Working Style (reinforces Take a Bite, Critical Thinking)
- Confirm understanding before proceeding
- Be concise in answers
- Do not generate files before providing description and receiving approval

### Cross-Repo Write Safety (reinforces Destructive Action Protocol)
- First write to any path outside this repository in a session requires explicit user confirmation
- Present the content and target path before writing; do not write cross-repo silently
- Subsequent writes to the same cross-repo target in the same session do not need re-confirmation

### Plan Mode for Significant Changes (reinforces Earn Your Assertions)
- Before implementing significant features: explore codebase, identify patterns, present plan
- Do not write or edit files until the plan is approved by the user
- This is a read-only exploration phase, not an implementation phase

### Session Wrap-Up (reinforces Know Your Context)
- When the user says "wrap up" or the session ends, use `/dsm-wrap-up`
- Before wrap-up, cross-reference sprint plan if one exists (verify all deliverables accounted for)
- At minimum: commit pending changes, push to remote, update MEMORY.md
- Create a handoff document if complex work remains pending
```

**DSM 1.0 (Data Science) addition:**

```markdown
### Notebook Collaboration Protocol (reinforces inherited protocol)
- Each cell is copied and pasted by the user
- Output each cell as a fenced code block in conversation text (not via NotebookEdit)
- Output ONE cell at a time, wait for user to run and share output
- Number each cell with a comment (e.g., `# Cell 1`)
- "Continue" = output next cell; "Output all cells" = explicit batch override
- Cell pre-flight: before each cell, check phase/section (new or continuation?),
  if new phase output markdown header first, then identify cell type (markdown/code)
- Figure validation: cells that generate plots must save to `outputs/figures/`;
  agent reads the saved image via Read tool before proceeding to next cell
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

### 17.2. CLAUDE.md Content Validation Protocol

Project-specific CLAUDE.md content drifts as the project evolves. Sections
written at setup may reference workflows the project never used or no longer
uses, consuming context budget without providing value. This protocol defines
criteria for detecting and resolving content drift.

**Validation criteria:**

Cross-reference each project-specific CLAUDE.md section against the project
type detected by §1:

| Project Type | Sections that indicate drift if present |
|-------------|----------------------------------------|
| Documentation (DSM 5.0) | Notebook Development Protocol, App Development Protocol |
| Data Science (DSM 1.0) | App Development Protocol |
| Application (DSM 4.0) | Notebook Development Protocol |

**Insurance section exemption:** Some sections are rarely invoked but critical
when needed. These must never be flagged as stale regardless of usage frequency:

- Destructive Command Protocol
- Secret Exposure Prevention
- Plan Mode Protocol
- Branching Strategy (Three-Level Model)

**When to validate:**

| Trigger | Action |
|---------|--------|
| `/dsm-go` (full session start) | Check project type against CLAUDE.md sections; flag mismatches |
| `/dsm-align` | After regenerating the alignment section, scan project-specific content for type mismatches |
| On-demand (user request) | Full validation with recommendations |

**Agent behavior:** When validation detects a mismatch at session start, report
it as an observation, not an automatic fix: "CLAUDE.md contains [section] which
is not typical for a [project type] project. Remove it to save context budget?"
The user decides whether to remove, keep (with justification), or defer.

**What validation does NOT do (deferred):**
- Accumulation tracking across sessions (requires state storage design)
- Relevance scoring based on invocation frequency
- Automated addition of missing sections based on observed patterns
- Dedicated `/dsm-validate-config` command

### 17.3. Feedback-to-CLAUDE.md Escalation Protocol

When the user corrects agent behavior and the correction contradicts an
existing CLAUDE.md instruction, saving the correction to feedback memory
alone is insufficient. CLAUDE.md instructions override memory, so the
incorrect behavior resurfaces in future sessions.

**Behavioral trigger:** The agent receives user feedback (explicit correction,
"don't do X", "stop doing Y") and detects that the feedback contradicts a
specific instruction in the project-specific section of `.claude/CLAUDE.md`
(content outside the alignment delimiters).

**Escalation steps:**

1. **Save feedback to memory** (current behavior, unchanged)
2. **Scan CLAUDE.md for conflict:** Check project-specific instructions for
   lines that directly contradict the feedback. A contradiction means the
   CLAUDE.md instruction would cause the behavior the user just corrected.
3. **Propose edit:** "Your feedback contradicts CLAUDE.md: `{current instruction}`.
   Update to: `{proposed correction}`?"
4. **If approved:** Edit CLAUDE.md via the permission window (Gate 2 applies).
   The edit targets only the conflicting line or section.
5. **If rejected:** Note the explicit decision in the feedback memory entry:
   "User declined CLAUDE.md update despite contradiction. Follow memory
   guidance over CLAUDE.md instruction for this specific behavior."

**When NOT to escalate:**
- Feedback adds nuance without contradicting (e.g., "also consider X" does
  not contradict "do Y")
- Feedback is about a one-time preference, not a persistent rule
- The conflicting instruction is inside the alignment delimiters (managed
  by `/dsm-align`, not manual edits)
- No matching CLAUDE.md instruction exists (feedback is net-new guidance)

**Detection guidance:** The agent does not need to perform an exhaustive scan
of CLAUDE.md on every feedback. The trigger is recognition of a conflict
during normal feedback processing, not a separate scanning pass.

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

**Mirror repos:** Entries with `mirror: true` receive automatic file sync whenever
methodology files change, not only on version releases. Two sync triggers exist:

1. **Session wrap-up:** The wrap-up protocol (`/dsm-wrap-up`) checks whether
   methodology files changed during the session. If they did, it syncs changed
   files to each mirror repo regardless of whether a version was bumped. This
   prevents silent drift between sessions.
2. **Version Update Workflow:** Step 9 syncs all changed methodology files as
   part of a version release, ensuring mirrors match the tagged version.

For both triggers, the agent copies changed methodology files to each mirror
repo, commits, and pushes. If push fails (branch protection), use the
protected-branch sub-protocol (create sync branch, PR, merge).

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

Created during a session for specific work items. Two types:

| Type | Trigger | Naming | Merge condition |
|------|---------|--------|-----------------|
| BL branch | BL implementation starts | `bl-NNN/short-description` | BL moved to `done/` |
| Sprint branch | Sprint work begins | `sprint-N/short-description` | All sprint plan items checked off |

**Parallel sessions** do not create Level 3 branches. They commit directly to
the Level 2 session branch using the commit booking system. See Module A §7
(Parallel Session Protocol) for the shared branch model.

**Merge to Level 2:** Only when formal exit criteria are met. Level 3 branches
merge to the session branch, not directly to main.

**Exceptions (commit directly to session branch):** Mechanical status updates
(BL moved to done/), trivial fixes (typos, dates), session artifacts (handoffs,
checkpoints, feedback), parallel session commits (via commit booking).

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

### 20.8. Post-Merge Branch Recreation Rule

After any in-session PR merge that deletes the source branch
(`gh pr merge --delete-branch`, `git push origin --delete <branch>`, or
equivalent), the working copy lands on `main` because the branch it was on
was just deleted. The next `git commit` will silently land on `main`,
violating the Three-Level Branching Strategy. The agent's mental model
treats the merge as "the previous unit of work is done" and the next task
starts on whatever branch the working copy is on, which is `main`.

**Rule:** Before any further edits or commits, create a new session-level
branch. The cleanest pattern chains both commands in the same shell call:

```bash
gh pr merge {N} --merge --delete-branch && \
  git checkout -b session-{N}/{YYYY-MM-DD}-{next-purpose}
```

The `-{next-purpose}` suffix is a soft naming convention for follow-on
branches in the same calendar session:

- Initial: `session-N/YYYY-MM-DD`
- Follow-on after merge: `session-N/YYYY-MM-DD-{purpose}` (e.g.,
  `session-17/2026-04-09-post7`, `session-17/2026-04-09-bl015`)

It avoids branch name collisions and makes session boundaries clearer in
`git log`. The convention is not enforced by linter or hook; it is a
readability convention, not a correctness rule.

**Recovery if a commit lands on main.** Do **not** use `git reset --hard`;
the harness blocks it without per-call approval. Use this safe sequence:

```bash
git branch session-{N}/{YYYY-MM-DD}-recovery       # safety net at HEAD
git update-ref refs/heads/main refs/remotes/origin/main  # rewind main
git checkout session-{N}/{YYYY-MM-DD}-recovery
```

Then push the recovery branch and open a follow-up PR. The work is
preserved on the recovery branch; main is rewound to its remote state
without touching the working tree.

**Origin:** dsm-blog-poster S17 (2026-04-09) hit this twice. After
`gh pr merge --delete-branch`, the agent edited a file and committed; the
commit landed on main. Recovery cost ~5 minutes and one extra PR per slip.
The failure mode is silent: nothing in the tooling complains when a commit
lands on main outside a session branch.

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
response before continuing other work. The current output-in-progress counts
as other work; see the stop condition below.

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

**Stop condition (current output):** When a §22 violation is detected, the
current output-in-progress is itself a stop condition. The agent must (a) name
the violation explicitly, (b) halt the in-progress output without completing
it, (c) propose corrective action, (d) wait for user confirmation before
resuming. "Before continuing other work" is not permission to finish the
current output first; the current output is other work relative to the
violation, and completing it deepens the failure.

**Anti-pattern:** Acknowledging a violation as a footnote or parenthetical
("note: I didn't read X earlier, per CLAUDE.md I should have") while continuing
to present the same output is itself a §22 failure. The acknowledgment must
break the flow, not decorate it. An inline disclaimer at the bottom of a
recommendation does not retroactively repair the recommendation.

This stop-condition rule is the operational expression of DSM_6.0's Earn Your
Assertions principle: claims that rest on unread sources or skipped checks are
not earned, and presenting them anyway violates the principle even if the gap
is acknowledged. Origin: blog-poster S19, where the agent detected mid-paragraph
that it had not read required sources per CLAUDE.md, flagged the gap as an
inline disclaimer, and then continued presenting BL-010 angle rankings built on
the unread sources; the user had to escalate ("this is unacceptable") to halt
the output. The "before continuing other work" phrasing as written permitted
the failure, which is why this amendment exists.

**Behavioral trigger:** This protocol activates whenever the agent observes:
- A collision, conflict, or inconsistency caused by a protocol gap
- An artifact in an unexpected format or location (e.g., BL file outside
  `plan/backlog/`)
- A required step that was skipped or executed incorrectly by a prior session

**Scope:** This protocol is in DSM_0.2 core (always loaded via `@`) because
it must be active in every session across all DSM projects. It is not gated
behind a module read.

---

## 23. Third-Party Skill Governance

Claude Code skills (`~/.claude/skills/` for global, `.claude/skills/` for
project-level) inject prompt content that the agent follows alongside DSM
protocols. Ungoverned skills can silently override DSM behavior (approval
gates, punctuation rules, style conventions). This section establishes
lightweight governance for third-party skills.

### 23.1. Skill Registry

Each DSM installation maintains a skill registry at `.claude/skills-registry.md`
(gitignored, local to each instance). The registry tracks installed skills:

| Skill | Source | Version | Scope | Purpose | Conflicts |
|-------|--------|---------|-------|---------|-----------|

**Scope values:** `global` (`~/.claude/skills/`) or `project` (`.claude/skills/`).
Project-level skills are preferred when only one project uses the skill.

### 23.2. Evaluation Gate for Skill Installation

Before installing a third-party skill, check for protocol conflicts:

1. Read the skill's `SKILL.md` (or equivalent prompt file)
2. Check for instructions that contradict DSM protocols: approval gates
   (§8), punctuation rules (CLAUDE.md), style conventions (§13), commit
   workflow, or file creation patterns
3. If conflicts exist, document them in the Conflicts column of the registry
   and decide: adapt the skill, restrict its scope, or reject it

### 23.3. Conflict Resolution Rule

When a third-party skill's instructions conflict with DSM protocols, **DSM
protocols take precedence**. The agent must follow DSM governance even when
a skill instructs otherwise. This is the same precedence model as
project-specific CLAUDE.md overriding generic DSM_0.2 protocols (§17).

### 23.4. Runtime Register Context Convention

§23.1-23.3 cover skills at install time. Some skills are also
**register-sensitive at runtime**: their output depends on assumptions about
audience, formality, or domain that the skill itself cannot infer from the
artifact alone. Without explicit context, a register-sensitive skill may
rewrite an academic deliverable into informal prose, or vice versa.

**Behavioral trigger:** Before invoking a register-sensitive skill on any
artifact, the agent must prepend a runtime context block describing the
target register. The block uses this format:

```
**Runtime context (per DSM_0.2 §23.4):**
- Audience: [target reader, e.g., "academic reviewers", "general public"]
- Formality: [formal | semi-formal | informal]
- Domain: [e.g., "research methodology", "blog post", "internal docs"]
- Constraints: [optional, e.g., "preserve technical terms", "no rephrasing of headings"]
```

**Skill registry annotation:** The skills registry table (§23.1) gains a
`Register-sensitive` column with values `yes` / `no` / `partial`. Skills
marked `yes` MUST receive a runtime context block on every invocation.
Skills marked `partial` SHOULD receive one when the artifact's audience
differs from the project's default register.

**Origin:** german-adversarial-prompting S8 incident, where the humanizer
skill rewrote an academic deliverable into informal register because no
mechanism existed to communicate target audience at runtime.

---

## 24. References

- Preston-Werner, T. (2013). [Semantic Versioning 2.0.0](https://semver.org/)
- Procida, D. (2017). [Diataxis Documentation Framework](https://diataxis.fr/)

---

## 25. Module Dispatch Table

DSM_0.2 protocols are split into this core file (always loaded via `@`) and
four on-demand modules. When a task requires a protocol from this table, read
the corresponding module file using the Read tool before applying the protocol.

All module files are in the same directory as this core file.

### 25.1. Core Sections (this file)

| § | Protocol |
|---|----------|
| 1 | Project Type Detection → [Module A §17](DSM_0.2.A_Session_Lifecycle.md) |
| 2 | Session-Start Version Check → [Module A §18](DSM_0.2.A_Session_Lifecycle.md) |
| 3 | Session-Start Inbox Check → [Module A §19](DSM_0.2.A_Session_Lifecycle.md) |
| 4 | Session-Start GitHub Issue Check → [Module A §20](DSM_0.2.A_Session_Lifecycle.md) |
| 5 | Read-Only Access Within Repository |
| 6 | Session Transcript Delimiter Format |
| 7 | Session Transcript Protocol |
| 8 | Pre-Generation Brief Protocol |
| 9 | Experiment Execution Protocol |
| 10 | Web Research Capture Protocol |
| 11 | Context Budget Protocol → [Module A §21](DSM_0.2.A_Session_Lifecycle.md) |
| 12 | Two-Pass Reading Strategy → [Module A §22](DSM_0.2.A_Session_Lifecycle.md) |
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
| 23 | Third-Party Skill Governance |
| 24 | References |

### 25.2. Module Protocols (on-demand)

| Protocol | Trigger | Module |
|----------|---------|--------|
| Project Type Detection (§1) | Session start, project identification | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session-Start Version Check (§2) | Session start, DSM version comparison | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session-Start Inbox Check (§3) | Session start, pending inbox entries | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session-Start GitHub Issue Check (§4) | Session start, unprocessed issues | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Context Budget Protocol (§11) | Large file reads, context pressure | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Two-Pass Reading Strategy (§12) | Structured files of 200+ lines | [A](DSM_0.2.A_Session_Lifecycle.md) |
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
| Sprint Retrospective Intelligence | Sprint boundary, after alignment review | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session Delivery Budget | Estimating session work volume, mid-session check | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Mechanical vs Decision Edits | Multiple edits to stage, distinguishing edit types | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Session Configuration Recommendation | Session start, mid-session task shift | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Responsible Collaboration Timer | Session start, cumulative time exceeds threshold | [A](DSM_0.2.A_Session_Lifecycle.md) |
| GitHub Issue Intake Protocol | Session-start issue check, external issue triage | [A](DSM_0.2.A_Session_Lifecycle.md) |
| CLAUDE.md Section Completeness Gate | New project setup, CLAUDE.md missing sections | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Sprint Plan Cross-Reference Before Completion | Work block done, sprint wrap-up, completion declaration | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Composition Challenge Protocol | Producing a collection of 2+ discrete items | [B](DSM_0.2.B_Artifact_Creation.md) |
| Edit Explanation Stop Protocol | Multiple distinct edits to a single file | [B](DSM_0.2.B_Artifact_Creation.md) |
| Enabling File Content Protocol | Working with backlog items, checkpoints, plans | [B](DSM_0.2.B_Artifact_Creation.md) |
| Notebook Collaboration Protocol | Generating Jupyter notebook cells (DSM 1.0) | [B](DSM_0.2.B_Artifact_Creation.md) |
| Notebook-to-Script Transition | Code exceeds notebook scope, long-running computation | [B](DSM_0.2.B_Artifact_Creation.md) |
| App Development Protocol | Building application code (DSM 4.0) | [B](DSM_0.2.B_Artifact_Creation.md) |
| Revert Safeguards Protocol | BL implementation touching untracked files | [B](DSM_0.2.B_Artifact_Creation.md) |
| Infrastructure File Collaboration Protocol | Modifying skills, hooks, settings, command files | [B](DSM_0.2.B_Artifact_Creation.md) |
| Secret Exposure Prevention | Staging files for git commit | [C](DSM_0.2.C_Security_Safety.md) |
| Destructive Action Protocol | Cross-repo writes, file deletion, methodology changes | [C](DSM_0.2.C_Security_Safety.md) |
| Untrusted Input Protocol | Processing inbox entries, tool outputs, web results | [C](DSM_0.2.C_Security_Safety.md) |
| Query Sanitization | Constructing web search queries or API requests | [C](DSM_0.2.C_Security_Safety.md) |
| Sensitive Data Protection in Tracked Files | Writing content with secrets, PII, or sensitive data | [C](DSM_0.2.C_Security_Safety.md) |
| Breaking Change Notification Protocol | DSM_0.2 introduces a breaking change | [D](DSM_0.2.D_Research_Onboarding.md) |
| External DSM Descriptions | Describing DSM in external-facing documents | [D](DSM_0.2.D_Research_Onboarding.md) |
| Step 0: Situational Assessment | New project onboarding, external contributions | [D](DSM_0.2.D_Research_Onboarding.md) |
| Phase 0.5: Research and Grounding | Novel domain, model selection, unfamiliar problem | [D](DSM_0.2.D_Research_Onboarding.md) |
| Environment Preflight Protocol | Project with native toolchains, system dependencies | [D](DSM_0.2.D_Research_Onboarding.md) |
| Python Virtual Environment Protocol | Project with notebooks/, src/, scripts/, requirements*.txt, pyproject.toml | [D](DSM_0.2.D_Research_Onboarding.md) |
| First Session Prompt for New Projects | New spoke project scaffolded | [D](DSM_0.2.D_Research_Onboarding.md) |
| Phase-to-DSM-Section Mapping | Sprint planning, phase type identification | [D](DSM_0.2.D_Research_Onboarding.md) |
| Command File Version Tracking | Modifying DSM command files | [D](DSM_0.2.D_Research_Onboarding.md) |
