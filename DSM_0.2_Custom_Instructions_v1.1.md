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

**Relationship to DSM_7.0 §2.1:** §7 defines the transcript protocol
shape (append-only, first-tool-call thinking, last-tool-call output,
delimiter format). DSM_7.0 §2.1.5 describes the Claude-specific
mechanism: the `UserPromptSubmit` hook that injects the per-turn
reminder and the `PreToolUse` validator that enforces anchor shape on
Edit tool calls. The protocol stays here; the Claude execution layer
lives in DSM_7.0 §2.1.

The session transcript is the **primary and only** channel for the agent's
working notes. The user keeps `.claude/session-transcript.md` open in VS Code
and follows the work there in real time. Conversation text is for results,
summaries, and questions only, never for working notes.

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
**Agent:** [harness identifier, e.g., "Claude Code"]
**Model:** [model identifier, e.g., "claude-opus-4-7"]
```

Optional platform-specific fields (append when retrievable; omit entirely when not — do NOT write placeholder values like `Effort: unknown`):

```
**Effort:** [low | medium | high]
**Thinking:** [on | off]
**Fast mode:** [on | off]
```

```
---
```

`Agent` and `Model` are mandatory. If introspection is uncertain, append `(self-reported)` to the value (e.g., `**Model:** claude-opus-4-7 (self-reported)`). The schema is agent-agnostic; only the values differ across harnesses.

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

**Unconditional activation:** If `.claude/session-transcript.md`
exists in the project, the Session Transcript Protocol is active. No skill
needs to activate it. The presence of the file is the activation signal.
This rule is independent of `/dsm-go` Step 6 and does not depend on any
session-start flow having run successfully. It is the third independent
enforcement layer alongside the per-turn hook (occurrence) and the
PreToolUse shape validator. Any session that finds the file present must
follow the protocol from the first turn, including continuation sessions
that defer from `/dsm-light-go` to `/dsm-go` mid-flight.

**Authorized exception: `/dsm-staa` (STAA exception).** The Session Transcript
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
under §23 (Skill/Hook Collaboration Protocol).

**Anti-Patterns:**

**DO NOT:**
- Output reasoning in conversation text; the user reads reasoning in the transcript file, not the chat
- Batch transcript entries at the end of a turn; the user cannot review reasoning after the fact
- Skip the transcript append on turns with non-trivial reasoning
- Commit the transcript file; it is a session-scoped working artifact
- Edit or rewrite past transcript entries; each entry reflects reasoning at the time it was written
- Use Edit with `old_string` matching earlier content to insert entries mid-file; this causes out-of-order timestamps (observed in prior sessions). Use the mandatory append technique above
- **Use Edit `replace_all: true` on `.claude/session-transcript.md`.** The append-anchor rule assumes a unique last-line anchor; `replace_all` duplicates the new content at every match and explodes the file (IronCalc S17: 95 MB / 1.5M lines; blog-poster S22: an Output block duplicated at every match). Recovery from a botched transcript Edit is a `[RETROACTIVE]` Bash-heredoc append, never a `replace_all` cleanup. The `validate-transcript-edit.sh` PreToolUse hook blocks this case (check 0/4)
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

**Enforcement, self-check, and retroactive recovery** (origins, rationale, and worked
examples in [DSM_0.2.G_Transcript_Enforcement.md](DSM_0.2.G_Transcript_Enforcement.md),
read on demand):

Two hooks keep this protocol active so it does not depend on operator discipline: the
`UserPromptSubmit` hook injects a per-turn reminder and enforces *occurrence* (an append
must happen this turn), and `validate-transcript-edit.sh` (PreToolUse on Edit) enforces
*shape* (anchor, append-only, delimiter) and *value* (a timestamp-drift warning). Two
operational rules stay stated here because they are behavior, not narrative:

- **Turn-boundary self-check:** every turn begins with a transcript append , pure-reasoning
  turns (decision analysis, trade-off comparison, recommendation) explicitly included, since
  they carry the highest-value thinking. The only exemption is content-trivial turns
  (one-word acknowledgments, single-fact confirmations with no new reasoning). If there is
  new reasoning, there is a transcript append.
- **[RETROACTIVE] recovery:** if an append was missed, append a
  `<------------Start Thinking [RETROACTIVE] / HH:MM------------>` entry at the *current*
  time, state which turns were missed, and note the gap; never backdate or edit history.

Module G carries the S171 origin, the check-4 warn-not-block rationale, the
pure-reasoning-turn worked example, and the full recovery procedure.

**Contemporaneous Work Log for Efficiency Analysis:**

Thinking blocks are a work log, written at each decision point, not a
post-hoc clean summary of the decision. Include alternatives that were
weighed and set aside, points of uncertainty, checks that were repeated,
and any change of approach. Write "considered X, set it aside because Y,
then revised the approach after Z" instead of collapsing to "decided on Z".

The motivation is auditing how work actually gets done, to find
inefficiencies. Real work is rarely a straight line: there are loops,
second-guessing, drift, and repeated checks along the way, and that
texture is normally lost once a turn ends, since nothing keeps a
durable record of it across a session. If the transcript log entry is a
clean summary, it hides exactly the inefficiency signals the transcript
exists to surface. Clean summaries make the work look tidier than it
was.

A useful log entry records:

- What was considered and why each option was weighed
- Where the work hesitated, repeated a check, or changed course
- Which steps were redundant in hindsight (re-reading a file already
  read, re-checking a fact already checked)
- The final decision and the reason it won

Completeness matters more than brevity. A log entry that is longer
than the action it precedes is acceptable when the work warranted it; a
log entry that compresses several rounds of back-and-forth behind a
single confident sentence is a defect.

This rule does not apply to trivial turns (single-fact answers, simple
acknowledgments) where the "When to skip thinking" rule above already
permits omission. It applies to every turn that warrants a thinking
block at all.

---

## 8. Pre-Generation Brief Protocol

Moved to [Module F](DSM_0.2.F_Pre_Generation_Brief.md). **Read before creating any
artifact** (code, test, documentation, configuration). The four-gate model is:
collaborative definition (§8.0) -> concept approval (§8.1) -> implementation approval
(§8.2) -> run approval (§8.3). Each gate is an explicit stop requiring user approval;
gates are independent and are not batched across artifacts.



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

### 10.1. Validation Depth for Deliverable-Critical Claims

For deliverable-critical claims (claims that will appear in a final deliverable,
publication, or external-facing artifact), a single research pass is insufficient.
Each validation pass catches errors invisible to the previous one: behavioral
verification confirms the claim holds in practice, comparative verification
surfaces contradicting work, and source verification catches mismatched or
non-authoritative citations. At least two passes at different abstraction levels
are required before synthesis.

**Pass types:**

| Pass | Question answered | Applies when |
|------|------------------|--------------|
| Behavioral | Does the claim hold in practice? | The claim asserts runtime behavior, output, or empirical effect |
| Comparative | Does competing or prior work contradict, or has the approach been proposed before? | The claim is novel, contested, or occupies a space with known alternatives |
| Source | Are citations accurate, authoritative, and actually present at the cited URL? | The deliverable will cite external sources |

**Mandatory cases (at least two passes required, spanning at least two distinct pass types):**
- Research feeding a publication, blog post, external deliverable, or external contribution
- Claims that will be cited or quoted in a user-facing artifact
- Novel or counterintuitive findings that a reader would reasonably challenge
- Any research marked for inclusion in `dsm-docs/research/` that feeds a downstream deliverable

**Single-pass exemption (one pass acceptable):**
- Internal notes, backlog context, and non-critical claims
- Quick lookups that produce a single verifiable fact (e.g., checking a version number or flag name)
- Research performed for internal decision-making where the finding will not leave the session or repo

**Behavioral trigger:** When the agent identifies research as deliverable-critical
(per the mandatory cases above), it proposes a multi-pass plan before executing
the first pass. The plan names which pass types will run and why, so the user
can confirm the depth matches the stakes. The passes are recorded in the same
`dsm-docs/research/{date}_{topic}.md` file (per §10), with one section per pass.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


**Risks / what could go wrong:**
- Ritualistic compliance: running two passes that both ask the same question
  (e.g., two behavioral passes) satisfies the count but not the intent. The
  "spanning at least two distinct pass types" clause in the mandatory cases
  is the guard
- Pass inflation for non-critical work: treating every lookup as
  deliverable-critical wastes context budget and slows sessions. The
  single-pass exemption list must be read alongside the mandatory cases
- Source-pass drift: a source pass that only checks URLs resolve (HTTP 200)
  without verifying the cited content is present at the URL misses the
  failure mode from S6 (cached PDFs mismatched to citations). The "actually
  present at the cited URL" wording in the Source row is deliberate

**Status labels may not exceed their pass (research files only).** Within
`dsm-docs/research/`, two clauses:

1. **Enumerate the scope.** A recorded pass states *which* items it covered,
   not only how many, as an explicit list of identifiers or a pointer to one
   elsewhere in the file. "10 of 13 confirmed" does not say which 13, so a
   later reader cannot tell whether a given entry fell inside the checked set.
   A bare count is not an auditable claim.
2. **Labels may not exceed the pass.** A status label over a set of sources
   (`confirmed`, `verified`, `primary`) asserts no more verification than the
   enumerated scope supports. Where a set is partly checked, the label
   separates the checked part from the rest.

**Pass log versus index**, stated once because it is what makes "may I edit
this?" answerable: a **pass log** records what a pass found at a point in time
and is never rewritten; an **index** asserts present status and is corrected
when it becomes wrong. Conflating them is why the question feels ambiguous.

Forward-only; existing research files are not retrofitted. Both shapes live in
`dsm-docs/research/2026-08-11_llm-as-judge-robustness.md`: §8 enumerates its
scope and complies, §4 states "10 of 13" without enumeration and does not ,
left standing, because it is a log.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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
strategies (see §14 Heading Parsability).

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
any question is no, split the delivery. See `TAKE_AI_BITE.md` for the short version.

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

**Relationship to DSM_7.0 §2.1:** §17 specifies the agent-config file
pattern (filename convention, `@` import as the discovery mechanism,
delimited alignment section managed by `/dsm-align`, reinforcement-block
requirements). DSM_7.0 §2.1.6 covers the Claude-specific surface: the
`settings.json` scope order, the hook-wiring architecture, the 5-hop
`@` recursion depth, and the skill / command file layouts. The
configuration discipline is here; the Claude-specific realization is
in DSM_7.0.

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
| App Development Protocol | DSM 4.0 projects | "One bite per stop, a bite being the smallest increment the user can verify (one testable function, test-first); concept approval happens in conversation before the write, the permission window is not the gate" |
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

**Base template (all project types):** see [DSM_0.2.T_Alignment_Templates.md](DSM_0.2.T_Alignment_Templates.md). `/dsm-align` copies the template text from that file verbatim.

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
- Published snippets: any runnable snippet added or modified in a skill file has been executed against its real input, in the real harness (see §19.1)
- Verification commands: no check in this list is trusted on the strength of a pipeline's exit status or a status line a pipeline printed (see §19.2)
- Delegated results: any evidence in this list that came back from a background workflow, a fan-out or a subagent has been checked against the run's own stats before being consumed (see §19.3)

### 19.1. Published Snippets Are Run Before They Ship

A runnable snippet published in a skill file is an assertion about two things it
never states: the shape of its input, and the environment it runs in. Neither is
verified at authoring time. Both BL-482 and BL-483 are what that looks like in
practice, and they are the same defect wearing different clothes:

| | BL-482 | BL-483 |
|---|---|---|
| Mismatch between | snippet and execution environment | spec and its own source file |
| Exit code | 0 | 1 |
| Silence is at | execution , a complete-looking baseline with an empty section | effect , a correct-looking align run that never skips |
| Caught by | reading tool output instead of the exit code | comparing the spec to the file it names |

Both shipped, both survived months of sessions, and both were found by spoke
projects rather than by the hub that authored them. **One execution would have
caught both.**

**Trigger.** Any commit that adds or modifies, inside `scripts/commands/*.md`,
either of:

1. **A fenced runnable block** (`bash`, `sh`, or an unlabelled block containing
   shell), or
2. **A prose specification that names a pattern, path, field or heading shape to
   be matched against a real file.** "Extract the latest `## [vX.Y.Z]` heading",
   "read `dsm-version: vX.Y.Z`", "count entries matching `^- \*\*F-`" are all
   assertions about a file's actual contents, and they are checkable the same way
   a fenced snippet is.

Excluded: illustrative pseudo-code, output-format templates the skill prints
rather than executes, and blocks explicitly marked as examples of what NOT to do.

The second form is not an afterthought. **BL-483's defect lived entirely in
prose**, never inside a fence, and a fenced-blocks-only trigger would have missed
it, which is precisely what this rule's own T-4 walkthrough found before it
shipped. An instruction to match something against a file is a runnable claim
whether or not anyone wrapped it in backticks.

**Obligation.** Run it. Against the real file or real command output it names,
not a synthetic stand-in, and in a Claude Code Bash session rather than as a
reasoned claim about what GNU tools would do. Capture the output as Test
Execution Log evidence per §21.3.

**The two questions the run must answer:**

1. Does it produce the intended output on real input?
2. **Would a wrong result look different from a right one?** This is the question
   BL-482 failed. An empty checksum section and a populated one both looked like
   success, and the pipeline exited 0 either way. A snippet whose failure is
   indistinguishable from its success needs a different snippet, not a closer
   reading.

**Unrunnable snippets.** Some published commands are destructive, or need state
the authoring session lacks (`gh pr merge`, a spoke's filesystem, a released
tag). These inherit §21.3's untestable-by-design carve-out: run every part that
can run, then record "deferred to [specific trigger]" with a one-line
verification plan, and add it to the BL's Pending verification. The carve-out is
not a general exemption; it applies per snippet, with the reason named.

**Anti-pattern guard.** "The snippet is obviously correct" and "it is the same
pattern used elsewhere in the file" are the two rationalizations this rule
forbids. BL-482's snippet was obviously correct under GNU grep, and had been for
months. BL-483's was consistent with three sibling sites, all of which named the
same non-existent heading shape. Consistency with neighbours is evidence about
the neighbours, not about the input. Same guard family as §8.2.1 ("No
counter-evidence found" without sources surveyed), §21.2 ("Risks: none known"),
§21.3 ("all tests passed"), §8.6.1 ("silence from the skill is the skill's
answer").

**Not proposed:** an automated snippet extractor or CI runner. That is a tooling
project with its own design surface, and a rule that must wait for tooling is a
rule that does not exist yet. If the convention holds in practice, mechanizing it
is a later BL.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


**Sibling:** §19.2 applies the same second question to the ad-hoc verification
commands an agent composes in the moment, which this section does not reach
because they are never published anywhere to be reviewed.

**BL-specific test plan:** Each backlog item that requires a feature branch must
include a Test Plan section with specific, verifiable conditions. These conditions
are defined at BL creation time and checked off on the branch before merge. The
test plan adds BL-specific verification on top of the minimum categories above.

**Agent behavior:** After completing implementation on a feature branch, run
both the minimum verification above and the BL's Test Plan conditions before
proposing merge. Never suggest "ready to merge" without a testing step.

**Forcing function:** the per-item execution discipline that operationalizes
this requirement is codified in §21.3 (Pre-Merge Test Plan Execution Rule).
§19 defines what must be tested; §21.3 forces the agent to execute and
record per-item evidence before merge.

---

### 19.2. A Pipeline's Exit Status Belongs To Its Last Command

§19.1 governs snippets **published** in skill files. This governs the ad-hoc
verification commands an agent composes in the moment, which appear in no file
and are reviewed by nobody. Same second question, different trigger.

A shell pipeline exits with the status of its **last** command. So in

```bash
some_command | tail -1 && echo "ok"
some_command | wc -l  || echo "none found"
```

the `&&` and the `||` are testing `tail` and `wc`. Those essentially always
succeed. The status of the command actually under test is discarded before
anything looks at it.

**It fails in both directions, and they look nothing alike:**

| Direction | Shape | What it makes you believe |
|---|---|---|
| **False success** | `cmd \| tail && echo "done"` | The action worked. It did not. |
| **False emptiness** | `cmd \| wc -l \|\| echo "none"` | The fallback stays silent, and its silence reads as "ran fine, found something". |

Measured in a Claude Code Bash session, 2026-08-20, per §19.1's obligation:
`false | tail -1 && echo ok` prints `ok` at exit 0; `false | wc -l || echo none`
prints `0` and never fires the fallback; and a `git` command against a
nonexistent repo, which exits 128, prints `REPORTED: pushed to main` at
pipeline exit 0.

**The three correct forms**, each verified to surface that 128:

1. Run the command alone, then check `$?`.
2. `set -o pipefail` before the pipeline.
3. Read `${PIPESTATUS[0]}` after it.

**Never use `| tail` as a success probe.** Displaying output through `tail` is
fine and this rule does not touch it; the prohibition is on letting a pipeline's
status, or a line it happened to print, stand as evidence that the command
succeeded.

**The display carve-out covers the pipe, NOT a later `$?`.** This is the crack
the rule fell through on its first day, so it is stated separately rather than
left implied. Bounding a command's output with `| tail -25` or `| head -40` is a
legitimate display choice; reading `$?` **after** that pipe is the same defect as
using the pipe to probe, because the status is `tail`'s either way. The
disguise is what makes it dangerous: the intent felt like "I am only truncating
noisy output", and the truncation genuinely was innocent , the status read
that followed it was not.

If you bounded the output and you also need the status, you have three
choices and all of them are cheap: run the command again with its output
discarded and read `$?`, capture `${PIPESTATUS[0]}` on the same line as the
pipeline, or set `pipefail` before it. What you may not do is bound the output
and then trust `$?`.

**A status line a pipeline printed is not a status.** The corollary that costs
the most: when a pipeline prints something reassuring, the reassurance came from
whichever command ran last, not from the one whose success you care about.

**Anti-pattern guard.** "The command obviously worked, the output looks right" is
the rationalisation this rule forbids. Variants:

- "I saw the expected text in the output"
- "It would have errored if it failed"
- "The fallback did not fire, so there was nothing to report"
- "I have used this form for months"

The last one is the load-bearing one. This rule exists **because knowing the
shell semantics did not prevent the defect**: S247 ran `git push | tail && echo
pushed` and reported "pushed to main" on a push the protected branch had
REJECTED, in a session whose own transcript already carried the rule as a
reasoning lesson. Recurrence under active awareness is what promoted it from a
lesson to a rule. Same guard family as §19.1 ("the snippet is obviously
correct"), §8.2.1, §21.2 and §21.3.

**Enforcement.** Prose and convention only; no hook detects the defective form
at write time. Same defence-in-depth posture as §19.1, §8.9.1, §21.2 and §21.3.
A PreToolUse matcher is conceivable and is deliberately not proposed here, since
it needs its own false-positive design pass and a rule that waits for tooling is
a rule that does not exist yet.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


**Fourth occurrence, inside the release that shipped this section.** Less than an
hour after §19.2 was written, the same session ran the mirror-sync content
scanner as `./scripts/check-mirror-sync-content.sh ... | tail -25` and reported
"scanner exit: 0". The scanner had exited **1** and its own output said "Mirror
sync should stop"; `$?` belonged to `tail`. Re-run correctly, `${PIPESTATUS[0]}`
was 1 while `$?` was 0, on the same command. This is recorded here rather than
quietly fixed because it is the strongest available evidence for the section's
own thesis: authoring the rule, stating its origin, and executing four
demonstrations of it did not prevent the author from committing it within the
hour. The display carve-out above is the specific clause that gap produced.

### 19.3. Delegated Workflow Results Are Checked Before They Are Consumed

§19.1 governs snippets **published** in skill files. §19.2 governs the ad-hoc verification
commands an agent composes in the moment. Both ask the same question at the shell grain. This
section asks it at the **delegation grain**: a background workflow, a fan-out, or a subagent
returns a payload, and the main loop consumes it. Nothing currently asks whether the payload
survived the return trip.

**The failure it exists for.** A `deep-research` background workflow ran correctly through every
upstream stage , 5 angles, 19 sources, 70 claims, 25 verified and 0 refuted, 101 agents, roughly
3.1M tokens , and returned:

```
summary: "test"
findings: [{claim: "test claim"}]
```

The real findings existed only in the per-agent transcripts and were recovered by hand. It was
caught because the stats visibly contradicted the payload: 101 agents and 3.1M tokens cannot
produce one claim reading `"test claim"`.

**Three properties compound, and together they are why this needs its own rule:**

1. **Every upstream signal reports success.** Agent count, token count and verification tallies
   are all real and all large. No error, no non-zero exit, no warning.
2. **The stub is syntactically valid.** It parses, it matches the schema, and it populates the
   fields a consumer reads. **Schema validation cannot catch it**, which is why step 1 below is
   a plausibility comparison and not a schema check.
3. **The cost is already sunk.** By the time the stub arrives the expensive work is done and
   discarded. Re-running is a second full-price fan-out (§8.9.2 territory); recovery from
   transcripts is nearly free , but only if the agent knows to try.

**Step 1 , sanity-check the payload against its own stats before consuming it.** N agents, M
tokens and K verified claims against an empty, placeholder or implausibly small findings body
is a **DEGRADED** result. Markers worth testing for: `"test"`, `"example"`, `"placeholder"`,
`"TODO"`, a findings array whose length is grossly disproportionate to the claim count, and a
summary shorter than the stats line describing it. The comparison is **proportionality against
the run's own reported stats**, never an absolute size floor.

**Step 2 , on degradation, recover from source-of-truth in this order.** The ordering is the
rule, not a suggestion, because the first two are free and the third costs a fraction of a
re-run:

| Order | Source | Cost |
|---|---|---|
| 1 | The workflow's own output file, if it wrote one | free |
| 2 | **The per-agent transcripts** | free |
| 3 | Re-synthesis of the failed stage only (`resumeFromRunId`) | a fraction of a re-run |
| 4 | A full re-run | last resort, never the reflex |

**The per-agent transcripts are named by role, and the path is an example rather than the
definition.** Verified on this machine 2026-08-23: they are `agent-<id>.jsonl` files under
`~/.claude/projects/<project-slug>/<session-id>/subagents/`. Sixteen were found across two
projects. This is deliberately **not** the path BL-520 was filed with , that named "the
workflow's transcript directory", and the check found the files live in a `subagents/`
directory instead. Harness layouts move; the role does not.

**Step 3 , never report a degraded result as final.** Either recover the real content, or state
the loss explicitly. A partial result presented as complete is the §22 shape, and §22's stop
condition applies to the output in progress.

**Over-firing guard (§8.9.2).** A genuinely small result set is not degraded. A research pass
that honestly returns two findings from two agents is proportionate and must not be flagged; a
check that fires on every small result trains the dismissal reflex, which leaves the reader
worse off than no check. The guard is structural: the comparison is against the run's own
stats, so a small run and a small payload agree.

**Scope.** Background workflows, fan-outs, and delegated subagent results , the cases where
expensive work is sunk before the payload arrives and recovery is nearly free. This is **not**
a general "verify every tool result against its own stats" rule; that is a larger rule with a
different cost profile.

**Not proposed:** an automated degradation detector. It needs its own false-positive design
pass, and a rule that must wait for tooling is a rule that does not exist yet , the same
posture §19.1 takes on a snippet runner.

**Anti-pattern guard.** "The stats look right, so the result is right" is the rationalisation
this section forbids. Variants:

- "It matched the schema"
- "The workflow reported no errors"
- "101 agents cannot all have failed"
- "Re-running is expensive, so I will work with what came back" (the recovery ladder exists
  precisely so this is a false dilemma)
- "The findings are probably in there somewhere"

Same guard family as §19.1 ("the snippet is obviously correct"), §19.2 ("the command obviously
worked, the output looks right"), §8.2.1, §21.2 and §21.3.

**Enforcement.** Prose and convention only; no hook inspects returned payloads. Same
defence-in-depth posture as §19.1, §19.2, §8.9.1, §21.2 and §21.3.

**Cross-references.**

- §8.9.2 governs the fan-out's **cost and consent** side; this governs its **return** side.
  Together they cover the lifecycle: price it, consent to it, bound its delegation, then check
  what comes back.
- §8.8 decides *whether* to delegate; this decides whether to trust what delegation returned.
- §10 and §10.1 assume the result reaching the main loop **is** the research. This is the
  section that checks that assumption, and it runs **before** §10's capture step , capturing a
  stub into `dsm-docs/research/` records the stub.
- §22 applies when a degraded result was already reported as final.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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

**A PR is built from the remote ref, so verify the branch is fully pushed before
opening one (BL-516).** `gh pr create` and every equivalent describe the branch as
it exists **on the remote**. A commit made after the last push is absent from the
PR, absent from the merge, and then destroyed when `--delete-branch` removes the
only copy holding it. Every step reports success.

Before creating **or merging** a PR, assert:

```bash
git fetch -q origin
UNPUSHED=$(git rev-list @{u}..HEAD --count)
```

`UNPUSHED` must be `0`. If it is not, halt and report the count and the commit
subjects rather than pushing silently , an unpushed commit at PR time usually means
the branch state is not what the author believes, and that is worth surfacing. This
is a fact about the repository requiring no interpretation, in the same spirit as
BL-489 replacing prose-signal detection with `git log main..branch`.

**Git already implements this guard and `gh` bypasses it.** Measured 2026-08-20:
`git branch -d` on a branch holding a commit not in its base **refuses**, exit 1,
with "The branch is not fully merged"; `git branch -D` force-deletes. Because
`gh pr merge --delete-branch` does delete such branches, it uses force semantics.
So the check must sit **before** the `gh` call and can never rely on the tool
declining , the tool will not decline.

**A stronger post-create assertion**, when the PR already exists: compare the PR's
head SHA against local `HEAD`. They must be equal.

```bash
gh pr view "$PR" --json headRefOid --jq .headRefOid   # must equal git rev-parse HEAD
```

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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

### 21.2. Preemptive Risk Definition Rule

Every non-trivial BL MUST include a Risks section that names the failure modes
the writer foresees and either a mitigation or an explicit acceptance. The
Success Criteria and Test Plan sections answer "what do we check to confirm it
worked?" (positive). The Risks section answers "what could go wrong in ways the
positive checks would not catch?" (negative). The two are not interchangeable
and must not collapse into each other.

**Format (minimal, preferred):** a bulleted list of 2-5 items. Each bullet
names the failure mode and either a mitigation or a stated acceptance. A
structured table (likelihood / impact / mitigation columns) is permitted when
the BL warrants it, but the minimal format is sufficient and preferred for
most BLs. Starting minimal is the explicit norm; structured-table BLs do not
set a precedent that minimal BLs must follow.

**Anti-pattern guard:** "Risks: none known" or "N/A" as the entire section is
NOT acceptable. The rule's intent is to force the writer to engage the
"what could go wrong" question; an empty section satisfies the form while
violating the intent (same guard pattern as §8.2.1 Strongest Counter-Evidence
"No counter-evidence found" anti-pattern). When a BL genuinely has no
material risks, write: "No material risks identified because [substantive
reason: trivial scope, mechanical edit, no behavioral change, etc.]." The
reason is the test.

**Trigger scope:**

- **MUST** for any BL that modifies methodology files, skill files, hooks,
  settings, or introduces new behavioral protocols
- **MUST** for any BL whose implementation will edit code or templates
- **MAY (optional)** for mechanical status-update BLs (BL → done move, typo
  fix, version bump, README index update)

**Trivial-BL exemption:** mechanical BLs whose entire scope is a status flip
or a one-line correction may omit the Risks section. The exemption is
content-based, not author-discretion-based: if the BL changes any user-
facing or agent-visible behavior, it is not trivial regardless of how short
the diff is.

**Forward-only:** existing BLs in `dsm-docs/plans/` and `plan/backlog/` are
NOT retrofitted. The rule applies to BLs filed after this rule lands. BLs
already in flight at rule-landing time may be retrofitted at the implementer's
discretion but are not required to be. Origin: BL-352 (S185 user request,
implemented in S206); the forward-only decision is intentional and does not
silently expand on later sessions.

**Interaction with §21 (Scope Rule):** when the Risks section naturally
separates into groups (the risks of sub-topic A are completely different
from the risks of sub-topic B), this is a §21 split signal. Apply the §21
multi-topic test and split the BL before implementation.

**Interaction with §22 (Protocol Violation Triage Response):** §21.2 is a
PREVENTIVE measure (surface failure modes at planning time). §22 is a
REACTIVE measure (handle failure modes that surfaced during execution). The
preventive layer does not replace the reactive one; both stay active.

**Agent behavior:** when creating a BL, after drafting Success Criteria and
Test Plan, draft a Risks section per the format above. When the BL exemption
applies (trivial / mechanical), state explicitly in the BL file that the
exemption applies and why. When the rule is unclear (borderline trivial),
default to including the section.

**Discoverability:** the rule lives canonically in this section (DSM_0.2 §21.2)
and is referenced operationally by `scripts/commands/dsm-backlog.md` (the BL
creation skill). Manually-created BLs that do not invoke the skill must still
follow the rule; the skill is a convenience, not the source of authority.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 21.3. Pre-Merge Test Plan Execution Rule

The implementing agent MUST execute every Test Plan item from the BL spec
before proposing merge to the parent branch. Each item gets a per-item
result line in the implementation output with concrete evidence (command
run + output captured, file path + line range, or behavioral observation
with citation). "All passed" or "tested" without per-item evidence is NOT
acceptable closure.

§19 (Branch Testing Requirement) establishes that L3 branches must be
tested. §21.3 is the agent forcing function that ensures §19 is executed
rather than implicitly assumed. §21.2 surfaces failure modes at filing
time; §21.3 verifies them at pre-merge time. Together they form the
preventive layer before §22's reactive stop-condition fires.

**Forcing function:** Test Plan items are not requirements documents to
admire; they are checks to run. The implementer reads each item, runs the
verification, and writes the result with evidence. The output reads as a
checklist with results, not a paragraph claiming "tested."

**Chain-implementation guard:** when implementing N BLs in sequence in
one session, each BL gets its own complete cycle: Gate 1 brief → branch →
implement → execute Test Plan → record results → close → merge. Testing
is NOT amortized across the chain; the implementer cannot batch all
implementations and then test all at once. The chain-pressure failure mode
is "I'll test them all at the end" decaying into "I forgot to test them
at all" because the user never asked for the gate. Origin: S206 chain of
BL-352, BL-421, BL-424 was merged untested under auto mode; user's "were
all tested?" surfaced the gap, which is itself the failure (the user
should not need to ask).

**Auto-mode does not compress testing:** auto mode reduces approval
friction (Gate 1/2 round-trips per §8) but does NOT reduce testing
requirements (Gate 3 / §19 / §21.3). This is the same explicit-in-
protocol carve-out pattern that §22's stop-condition rule uses for auto
mode: auto mode is an approval-friction lever, not a verification-
discipline lever (reasoning lesson from S193, MEMORY).

**Untestable-by-design carve-out:** some methodology rules cannot be
tested in the implementing session (e.g., "next /dsm-go boot will read
this rule"). For these, the implementer MUST:

- Execute every test that CAN run in the implementing session
  (structural: file present, regex matches, cross-refs resolve;
  behavioral: snippet executes, command output captured)
- For each deferred test, write "T-N deferred to [specific trigger]"
  with a one-line verification plan
- Add deferred items to the BL's "Pending verification" subsection
- Propagate deferred items to the next `/dsm-go`'s suggested work via
  the session checkpoint or wrap-up handoff (so the deferred item does
  not silently die between sessions)

**Anti-pattern guard:** "all tests passed" without per-item evidence is
the failure mode this rule prevents. Same guard shape as §8.2.1 ("No
counter-evidence found" without sources surveyed) and §21.2 ("Risks: none
known" without substantive reasoning). The rule's intent is forcing
per-item engagement; collapsed claims defeat the rule's letter and intent
simultaneously.

**Trivial-BL exemption:** mechanical status-update BLs (BL → done move,
typo fix, version bump, README index update) inherit the §21.2 trivial-
BL exemption. No Test Execution Log required if no behavior change. The
exemption is content-based, not author-discretion-based: any BL that
edits methodology files, skill files, hooks, settings, or templates is
NOT trivial regardless of diff size.

**Operational gate:** §8.4 Gate 3 (Run Approval) is the gate that §21.3
enforces. §21.3 makes Gate 3 mandatory at pre-merge time for any L3
branch implementation, even when auto mode has compressed Gate 1/2.

**Discoverability:** the rule lives canonically in this section. Operational
support: `scripts/commands/dsm-backlog.md` template includes a "Test
Execution Log" section that the implementer fills at close time, between
the filing-time Test Plan and the filing-time Risks sections.

**Agent behavior:** before proposing a merge of an L3 branch to its
parent, the agent reads the BL's Test Plan, executes each item, writes
the per-item result with evidence, identifies any deferred items, and
only then proposes the merge. The merge proposal includes the Test
Execution Log inline so the user can see the evidence without reading
the BL file separately.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 21.4. Resolver Integrity Check

§21.2 makes a BL name its failure modes at filing time. §21.3 makes the
implementer execute that BL's Test Plan with per-item evidence before merge. §19
sets the minimum verification for a task branch. All three are scoped to **one
BL**, so all three can pass while the artifact the change landed in is left
internally inconsistent. Nothing asks about the artifact as a whole.

**The unit is the Resolver**, the term the corpus already maintains:
`dsm-docs/plans/done/INDEX.md` carries a `Resolver (§ or concept)` column holding
exactly this, the section, skill, hook or concept a BL landed as, and
`/dsm-backlog-done` Step 8 already requires it. Coining a new term when a
maintained one exists costs a migration and buys nothing.

**The one question:** is the artifact this change landed in still internally
consistent with itself?

That is a different question from "did this change work", which §21.3 answers,
and from "is this signal discriminating", which §19.1 and §19.2 answer. The axis
matters and is stated so the four rules do not read as a pile: **§19.1 / §19.2 /
§19.3 govern verification QUALITY** (is this evidence worth anything?), while
**§21.3 and §21.4 govern verification OBLIGATION** (has something more been
checked?). Within the obligation axis, §21.3 is the **change unit** and §21.4 is
the **Resolver unit**.

#### The mechanical half: a removed-or-renamed-string sweep

For every string the change removed or renamed, sweep the corpus for surviving
occurrences and classify each hit. This is one command and it is the half that
needs no judgement to run:

```bash
grep -rn '<the removed or renamed string>' DSM_*.md scripts/commands/*.md
```

**A hit is a candidate, never a verdict.** Most hits are legitimate: a deliberate
legacy reference, a CHANGELOG record of what changed, a migration rule that must
name the old form in order to migrate it. The implementer reads each hit and
records it as deliberate or stale. An identifier grep yields candidates because a
historical mention and a live reading look identical to `grep`.

**Assert the sweep can find the string before trusting a zero.** A pattern that
matches nothing and a pattern that is broken produce the same empty output. Run
it once against a file known to contain the string, per §19.1's second question.

**Bound the pattern to the string, not to a path prefix.** A sweep narrowed by
the directory the string usually appears in will miss the site that names it
without the prefix, and the missed site is disproportionately likely to be a
template or a prompt, which is the most load-bearing kind.

#### The prose half: three checks the sweep cannot make

1. **Cross-reference resolution.** Every section number, file path, step number
   and BL reference the change introduced or moved still resolves to something
   that exists.
2. **Asserted counts still match reality.** Any count the artifact states about
   itself, a feature total, a row count, an "all N commands" claim, is recomputed
   rather than carried forward. A bare count is not an auditable claim, and the
   one you computed yourself is the one you are least likely to re-check.
3. **Mirror and deploy coverage of the artifact's own file.** If the change
   edited a file, confirm that file is actually carried by whatever distributes
   it: the mirror manifest, the command deploy, the `@` chain. Documentation that
   describes a pattern while the implementation enumerates paths is a
   silent-coverage defect, and the documentation is the half that reads as
   coverage.

#### It reports, it does not gate

A finding is recorded in the BL's Test Execution Log as a per-item result with
evidence; it does not block the merge. The forcing shape is §21.3's, so the check
cannot be skipped silently, but the implementer decides what a hit means.

**This satisfies §8.9.2's over-firing guard structurally rather than by tuning.**
The string sweep returns nothing when the change removed or renamed nothing, so
it is silent on exactly the ordinary work that a noisy gate would train the
reader to dismiss. A gate that fires on ordinary work leaves the reader worse off
than no gate, because a reflex-dismissed gate still reads as protection.

#### Scope, and what is deliberately not here

**Per-BL, not per-release.** A per-release variant runs once and large, which is
the "a rule that must run at scale will not run" shape. It is **deferred, with
its trigger named**: revisit if a defect is found that is invisible to every
individual BL's sweep and visible only across a release. That has not happened
yet; four of the five recorded instances are per-BL defects.

**Trivial-BL exemption.** Mechanical status-update BLs inherit the §21.2 and
§21.3 exemption. A BL that removed or renamed no string produces an empty sweep,
which is recorded as empty rather than omitted, so "ran and found nothing" stays
distinguishable from "was not run".

**Anti-pattern guard.** "The change was additive, so there is nothing to sweep"
is the rationalisation this rule forbids when the change also renamed a heading,
moved a step number, or replaced a filename in passing. Additive-plus-a-rename is
the common shape. Same guard family as §8.2.1 ("No counter-evidence found"
without sources surveyed), §21.2 ("Risks: none known"), §21.3 ("all tests
passed"), §19.1 ("the snippet is obviously correct").

**Cross-references:** §21.3 (the change unit; this is its Resolver-unit sibling),
§21.2 (failure modes at filing time), §19.1 / §19.2 / §19.3 (the quality axis),
§8.9.2 (the over-firing guard this satisfies structurally), §22 (triage when a
sweep surfaces a defect that already shipped).

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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
inline disclaimer, and then continued presenting angle rankings built on
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

**Relationship to DSM_7.0 §2.1:** §23 defines the registry +
evaluation-gate + conflict-resolution pattern for skill governance;
it is platform-agnostic. DSM_7.0 §2.1.6 covers the Claude-specific
surface: the legacy `.claude/commands/*.md` format DSM currently uses
vs the newer `.claude/skills/SKILL.md` format with frontmatter, plus
the 5K-per-skill / 25K-combined compaction budget that shapes how
many skills a session can safely load.

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

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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
| 8 | Pre-Generation Brief Protocol → [Module F](DSM_0.2.F_Pre_Generation_Brief.md) |
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
| Cloned-Mirror Kick-off Protocol | First session of a cloned mirror repo (detection: no self-as-central registry) | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Concurrent-Session Detection Protocol | Session start, second `/dsm-go` invocation while a prior session is unwrapped | [A](DSM_0.2.A_Session_Lifecycle.md) |
| Pre-Generation Brief Protocol (§8) | Before creating ANY artifact; four-gate approval model | [F](DSM_0.2.F_Pre_Generation_Brief.md) |
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
| Read-Before-Draft for OSS Contributions | Opening a PR/issue against an external maintained repo | [D](DSM_0.2.D_Research_Onboarding.md) |
