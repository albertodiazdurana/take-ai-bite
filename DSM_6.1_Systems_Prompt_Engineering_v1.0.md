# DSM 6.1: Systems Prompt Engineering

**Version:** 1.0
**Last Updated:** 2026-03-25
**Companion to:** DSM_6.0 AI Collaboration Principles

DSM_6.0 defines the philosophy: nine principles that govern how humans and AI
collaborate. DSM_6.1 names the discipline: the recognition that every protocol,
template, feedback loop, and session command in the DSM ecosystem constitutes
prompt engineering at system scale. DSM_6.0 is the "why"; DSM_6.1 is the "what"
and "how."

This document is practice-first: it starts from what DSM does, names the
patterns, and then connects to external literature. The ecosystem is the
evidence base.

## Contents

1. [What is Systems Prompt Engineering](#1-what-is-systems-prompt-engineering)
2. [The Three-Phase Evolution Narrative](#2-the-three-phase-evolution-narrative)
3. [From Context Engineering to Ecosystem Orchestration](#3-from-context-engineering-to-ecosystem-orchestration)
4. [Practitioner Maturity Model](#4-practitioner-maturity-model)
5. [Take a Bite as Instruction Design Pattern](#5-take-a-bite-as-instruction-design-pattern)
6. [The Empirical Prompt Engineering Cycle](#6-the-empirical-prompt-engineering-cycle)
7. [Failure Mode Taxonomy for Instruction Systems](#7-failure-mode-taxonomy-for-instruction-systems)
8. [Module Dispatch Table](#8-module-dispatch-table)
9. [References](#9-references)
10. [Version History](#10-version-history)

---

## 1. What is Systems Prompt Engineering

Most prompt engineering focuses on crafting individual prompts: writing a clear
instruction, choosing examples, tuning temperature. This is necessary but
insufficient. As AI collaboration matures, the unit of design shifts from the
single prompt to the instruction system: interconnected documents, feedback
loops, version-controlled templates, and session management protocols that
govern AI behavior across an ecosystem of projects.

Systems Prompt Engineering is the discipline of designing, maintaining, and
evolving these instruction systems. It operates at three levels:

| Level | Unit of Design | Example |
|-------|---------------|---------|
| Individual | A single prompt or instruction | A chat message, a system prompt |
| System | A coordinated set of instructions for one project | CLAUDE.md + command files + session protocols |
| Ecosystem | Instruction architecture across multiple projects | Hub-spoke propagation, feedback loops, mirror sync |

The distinction matters because failure modes change at each level. An
individual prompt fails when its wording is ambiguous. A system fails when
its components contradict each other. An ecosystem fails when changes
propagate incorrectly or feedback loops break.

DSM operates primarily at the system and ecosystem levels. Every DSM
protocol, from the Session Transcript Protocol to the Three-Level Branching
Strategy, is an instruction artifact: a version-controlled document that
shapes AI behavior across sessions, projects, and contributors.

---

## 2. The Three-Phase Evolution Narrative

DSM's own history illustrates the progression from individual prompt design
to ecosystem orchestration. This progression was not planned; it emerged
from operational maturity, exactly as DSM_6.0 §1.9 (Think Ahead) predicted.

### 2.1. Phase 1: Individual Prompt Design

The starting point for any AI collaboration. A practitioner writes prompts
for a specific task: analyze this dataset, generate this report, debug this
function. The focus is on clarity, specificity, and getting useful output
from a single interaction.

**DSM evidence:** The earliest DSM sessions (November 2025) were individual
data science collaborations. The methodology document was a single file of
instructions. Each session started fresh; there was no continuity mechanism.

**Characteristic practices:** manual prompt iteration, ad-hoc examples,
no version control of instructions, session-scoped context only.

### 2.2. Phase 2: System-Level Instruction Architecture

As collaboration deepens, patterns emerge: certain instructions work
consistently, certain failures recur, and the practitioner begins to build
reusable structures. The unit of design shifts from the individual prompt
to the instruction system: a coordinated set of documents, templates, and
protocols for a single project.

**DSM evidence:** The introduction of CLAUDE.md as a persistent system
prompt, the Pre-Generation Brief Protocol (DSM_0.2 §8) as a reusable
interaction pattern, and the Session Transcript Protocol (DSM_0.2 §7) as
a continuity mechanism. Each of these is an instruction artifact that
persists across sessions and shapes AI behavior without being rewritten
each time.

**Characteristic practices:** persistent instruction files, reusable
protocol templates, session management, version-controlled methodology.

### 2.3. Phase 3: Ecosystem Orchestration

The most advanced level. Multiple projects, each with their own instruction
systems, must be coordinated. Changes in one project's instructions may
affect others. Feedback from one project informs methodology improvements
that propagate to all projects.

**DSM evidence:** The hub-spoke architecture, where DSM Central maintains
the methodology and spoke projects inherit it via the `@` reference chain.
The inbox system for cross-project communication. The mirror sync mechanism
for distributing changes. The feedback system where spoke sessions generate
methodology observations that route back to Central for evaluation.

**Characteristic practices:** cross-project instruction propagation,
structured feedback loops, ecosystem-level version management, automated
consistency validation.

### 2.4. The Progression is Not Arbitrary

Each phase enables the next. You cannot orchestrate an ecosystem of
instruction systems until you have built reusable instruction systems. You
cannot build reusable systems until you have iterated on individual prompts
enough to recognize patterns.

This mirrors DSM_6.0 §1.9's five-layer maturity model: operational →
infrastructure → philosophical → learning → strategic. Systems Prompt
Engineering is the discipline that emerges when the learning layer is
mature enough to recognize its own patterns.

---

## 3. From Context Engineering to Ecosystem Orchestration

In mid-2025, the AI industry converged on "context engineering" as the
successor to "prompt engineering." Anthropic defines context engineering as
"the set of strategies for curating and maintaining the optimal set of tokens
during LLM inference" (Anthropic Engineering Blog, 2025). The distinction:
prompt engineering optimizes written instructions; context engineering manages
the entire information ecosystem around the model: system instructions,
retrieved knowledge, tool definitions, memory, and session state.

DSM has been practicing context engineering before the term was coined.
The session transcript protocol (structured note-taking for long-horizon
tasks), dsm-go/dsm-wrap-up (context initialization and persistence),
CLAUDE.md (system prompt at the "right altitude"), and the Ecosystem Path
Registry (cross-project context routing) are all context engineering
practices.

### 3.1. Where DSM Extends Context Engineering

Industry context engineering operates at the session or agent level: how
to give one model the right context for one task. DSM extends this to the
ecosystem level:

| Dimension | Industry CE | DSM Ecosystem CE |
|-----------|-------------|-----------------|
| Scope | Single session or agent | Multiple agents, projects, sessions |
| Time horizon | Within a conversation | Across 150+ sessions over months |
| Propagation | Manual per-project | Automated via `@` chain and mirror sync |
| Feedback | Per-session evaluation | Structured deviation analysis across projects |
| Memory | Session state, RAG | Reasoning lessons, handoffs, checkpoints, MEMORY.md |

This is DSM's primary novel contribution to the field: context engineering
at ecosystem scale. The literature describes how to manage context for a
single agent; DSM demonstrates how to manage context across an ecosystem
of agents, projects, and time horizons.

---

## 4. Practitioner Maturity Model

Systems Prompt Engineering is a practice, and practitioners develop along
a progression that mirrors the three-phase evolution. This model describes
practice levels, not job titles; a practitioner at any organizational
role can operate at any level depending on the complexity of their AI
collaboration.

### 4.1. Practice Levels

| Level | Practice | Characteristic Artifacts |
|-------|----------|------------------------|
| Individual | Crafting effective prompts for specific tasks | Chat messages, one-off system prompts, few-shot examples |
| System | Designing coordinated instruction sets for a project | CLAUDE.md, command files, protocol templates, session management |
| Ecosystem | Orchestrating instruction architecture across projects | Hub-spoke propagation, feedback loops, mirror sync, governance channels |

### 4.2. Progression Indicators

The shift from one level to the next is driven by complexity, not aspiration.
The indicators below signal that the practitioner's current level is
insufficient for their operational reality:

| Signal | Indicates Shift To |
|--------|--------------------|
| Same instructions rewritten across sessions | System level (persist and reuse) |
| Instructions contradict each other across files | System level (coordinate and version) |
| Multiple projects need similar instruction patterns | Ecosystem level (propagate and sync) |
| Changes in one project break behavior in another | Ecosystem level (feedback and governance) |
| Backlog of methodology improvements self-generates | Ecosystem level (learning loop is active) |

### 4.3. Relationship to Industry Role Taxonomy

The industry defines three adjacent roles: prompt engineer (individual
prompts), AI engineer (building AI-powered applications), and AI architect
(organizational AI strategy). DSM's practitioner maturity model occupies
the space between AI engineer and AI architect: designing interconnected
instruction ecosystems that are more than individual prompts but more
concrete than organizational strategy.

---

## 5. Take a Bite as Instruction Design Pattern

Take a Bite (DSM_6.0 §1.1) is both a collaboration philosophy and a concrete
instruction design technique. This dual nature is central to Systems Prompt
Engineering.

**As philosophy:** Constrain the size of each delivery so the reviewer can
engage with it and respond with substance. A 2,000-line document cannot be
meaningfully reviewed; a 400-line module can.

**As instruction design technique:** Structure AI instructions so that each
interaction produces a reviewable unit. The Pre-Generation Brief Protocol
(DSM_0.2 §8) is Take a Bite applied to artifact creation: explain before
generating, generate one artifact at a time, wait for review before
proceeding.

**As modularization principle:** The Document Structure Standard (BL-259)
limits files to 400 lines and requires intro paragraphs before subheadings.
This is Take a Bite applied to the instruction documents themselves: each
file is a reviewable unit, each section opens with context before diving
into detail.

The pattern generalizes: any instruction system benefits from chunking its
outputs into units that the human collaborator can meaningfully engage with.
The specific size depends on the domain, but the principle is universal:
if the reviewer cannot respond with substance, the delivery is too large.

---

## 6. The Empirical Prompt Engineering Cycle

DSM follows an empirical approach to instruction design that mirrors the
scientific method. This is not aspirational; it is how the methodology
already evolves, codified in the Experiment Execution Protocol (DSM_0.2 §9)
and the Protocol Violation Triage Response (DSM_0.2 §22).

### 6.1. The Eight-Step Cycle

| Step | Activity | DSM Implementation |
|------|----------|-------------------|
| 1 | Situational assessment | Step 0 (DSM_0.2 Module D): analyze the project, identify constraints |
| 2 | Hypothesis | Backlog item creation: "this protocol change will fix the observed failure" |
| 3 | Experiment design | BL Test Plan: define success criteria before implementing |
| 4 | Evaluation criteria | Pre-registered conditions in the BL, checked before merge |
| 5 | Run and measure | Level 3 branch implementation, branch testing |
| 6 | Analyze failures | Protocol Violation Triage (DSM_0.2 §22): fix, root-cause, prevent |
| 7 | Iterate | Feedback loop: spoke observations → Central BL → protocol update → spoke sync |
| 8 | Release | Version Update Workflow: version, tag, mirror sync |

### 6.2. What Makes This Empirical

Three properties distinguish this from ad-hoc prompt iteration:

1. **Pre-registration:** Success criteria are defined before implementation
   (BL Test Plan), preventing post-hoc rationalization of ambiguous results
2. **Version control:** Every instruction change is committed, tagged, and
   traceable through git history
3. **Structured feedback:** Deviations are analyzed systematically (Protocol
   Violation Triage), not treated as one-off errors

The cycle is continuous: each release generates new operational data (spoke
sessions), which generates new observations (feedback), which generates new
hypotheses (BLs), which drives the next iteration.

---

## 7. Failure Mode Taxonomy for Instruction Systems

When an instruction system produces unexpected behavior, the failure can be
traced to specific categories. DSM's Protocol Violation Triage Response
(DSM_0.2 §22) already categorizes deviations; this section names them as
prompt engineering failure modes.

### 7.1. Failure Categories

| Failure Mode | Description | DSM Example |
|-------------|-------------|-------------|
| Context gap | The model lacks information needed for the task | Missing `@` reference disables inherited protocols |
| Instruction conflict | Two instructions contradict each other | CLAUDE.md says "create BLs in plan/backlog/," README says "dsm-docs/plans/" |
| Propagation failure | A change does not reach all affected targets | Mirror sync misses `.claude/CLAUDE.md` (gitignored file) |
| Stale context | Instructions reference artifacts that have moved or changed | Done/ files reference old path names |
| Scope drift | Instructions are applied outside their intended context | Generic DSM_0.2 protocol creates files in external repo |
| Feedback gap | Deviations occur but are not captured or analyzed | Session ends without wrap-up; observations are lost |
| Classification error | The model applies the wrong protocol to a situation | Research issues triaged as BL improvements |

### 7.2. Diagnostic Approach

When unexpected behavior is observed:

1. **Identify the category** from the table above
2. **Trace the instruction chain** from the model's behavior back to the
   source document (CLAUDE.md → `@` reference → DSM_0.2 → protocol section)
3. **Apply the three-step triage** (DSM_0.2 §22): fix the immediate issue,
   identify the root cause, prevent recurrence

This diagnostic approach treats instruction failures as system issues, not
model issues. The question is not "why did the model do this?" but "which
instruction (or missing instruction) caused this behavior?"

---

## 8. Module Dispatch Table

DSM_6.1 is organized as a core document (this file) with three companion
modules, following the DSM Document Structure Standard. Each module is
self-contained with its own index, intro paragraphs, and section numbering.

| Module | Title | Scope |
|--------|-------|-------|
| [A](DSM_6.1.A_Operational_Channels.md) | Operational Channels and Context Management | The 9 dsm-docs/ folders as PE infrastructure; session lifecycle commands as context management |
| [B](DSM_6.1.B_Instruction_Design_Patterns.md) | Instruction Design Patterns | CLAUDE.md architecture, command files, protocol templates, hub-spoke feedback loops |
| [C](DSM_6.1.C_Evaluation_and_Evolution.md) | Evaluation and Evolution | Git as prompt version control, Graph Explorer validation, STAA effectiveness analysis |

**When to read modules:** The core document provides the framing, definitions,
and conceptual models. Modules provide operational detail. Read a module when
you need to understand or implement practices in that domain.

---

## 9. References

Sources referenced in this document, organized by origin.

### 9.1. Internal DSM References

- DSM_6.0: AI Collaboration Principles (parent document)
- DSM_0.2: Custom Instructions (the largest PE artifact in DSM)
- DSM_0.2 §8: Pre-Generation Brief Protocol
- DSM_0.2 §9: Experiment Execution Protocol
- DSM_0.2 §22: Protocol Violation Triage Response
- TAKE_A_BITE.md: Short-form collaboration philosophy
- Document Structure Standard: `dsm-docs/guides/document-structure-standard.md`

### 9.2. External References

- Anthropic (2025). "Effective Context Engineering for AI Agents." Anthropic
  Engineering Blog.
- Schulhoff, S. et al. (2024). "The Prompt Report: A Systematic Survey of
  Prompting Techniques." arXiv.
- Sahoo, P. et al. (2024). "A Systematic Survey of Prompt Engineering in
  Large Language Models." arXiv.
- LangChain (2025). "State of Agent Engineering Report."

Full literature review: `dsm-docs/research/systems-prompt-engineering/
2026-03-24_systems-prompt-engineering-literature.md`

---

## 10. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-25 | Initial release: core framing, three-phase evolution, practitioner maturity model, empirical cycle, failure taxonomy |
