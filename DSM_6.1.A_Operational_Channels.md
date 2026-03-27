# DSM 6.1 Module A: Operational Channels and Context Management

**Version:** 1.0
**Last Updated:** 2026-03-25
**Parent document:** DSM_6.1 Systems Prompt Engineering

This module maps DSM's operational infrastructure to its prompt engineering
function. The core document (DSM_6.1) defines Systems Prompt Engineering as
a discipline; this module shows the concrete artifacts that implement it.
Every folder in dsm-docs/, every session command, and every memory layer is
an instruction artifact that shapes AI behavior across sessions, projects,
and time horizons.

## Contents

1. [Operational Infrastructure as Prompt Engineering](#1-operational-infrastructure-as-prompt-engineering)
2. [The Nine Operational Channels in dsm-docs](#2-the-nine-operational-channels-in-dsm-docs)
3. [Session Commands as Context Management Operations](#3-session-commands-as-context-management-operations)
4. [Context Lifecycle Across Session Types](#4-context-lifecycle-across-session-types)
5. [The Memory Architecture as Persistent Context](#5-the-memory-architecture-as-persistent-context)
6. [Cross-Project Context Routing Mechanisms](#6-cross-project-context-routing-mechanisms)
7. [Connection to Project Management Knowledge Areas](#7-connection-to-project-management-knowledge-areas)
8. [References and Version History](#8-references-and-version-history)

---

## 1. Operational Infrastructure as Prompt Engineering

Most discussions of prompt engineering focus on the prompt itself: what words
to write, what examples to include, what temperature to set. DSM's operational
infrastructure reveals a different dimension: the organizational structures
around the prompt that determine whether it succeeds or fails.

A well-written CLAUDE.md is necessary but insufficient. Without a checkpoint
system, context is lost between sessions. Without an inbox system, feedback
from one project never reaches the methodology. Without a research folder,
web findings cannot be verified after the session ends. Each of these
structures is an instruction artifact, not because it contains instructions
to the model, but because its presence or absence shapes what the model
can do.

The failure mode taxonomy in DSM_6.1 §7 names this: a "context gap" occurs
when the model lacks information needed for a task. Operational channels
prevent context gaps by ensuring that information flows to where it is needed,
when it is needed, in a format the model can consume.

---

## 2. The Nine Operational Channels in dsm-docs

The dsm-docs/ directory is not file organization. It is a communication
architecture where each folder serves a specific function in the instruction
ecosystem. Removing or misusing any channel creates a predictable failure
mode.

### 2.1. Channel Mapping Table

| Channel | Folder | PE Function | Failure When Missing |
|---------|--------|-------------|---------------------|
| External communication | blog/ | Outbound knowledge synthesis for external audiences | Findings remain internal; no public knowledge contribution |
| Continuity snapshots | checkpoints/ | Session state persistence at milestones | Context loss at session boundaries; repeated discovery work |
| Decision records | decisions/ | Rationale capture for design choices | Decisions relitigated; reasoning behind choices is lost |
| Methodology feedback | feedback-to-dsm/ | Structured deviation analysis from spoke projects | Protocol violations repeat; improvement signals are lost |
| Reusable templates | guides/ | Instruction templates for recurring patterns | Each project reinvents formatting and structural standards |
| Session continuity | handoffs/ | Detailed context transfer between sessions | New sessions start without prior context; work is duplicated |
| Cross-project messaging | _inbox/ | Bidirectional communication between hub and spokes | Projects operate in isolation; methodology changes do not propagate |
| Goal definition | plans/ | Modular backlog with scope, priority, and test criteria | Work is ad-hoc; no traceability from problem to solution |
| Knowledge intake | research/ | Raw findings with source URLs before synthesis | Claims in deliverables cannot be verified; hallucination risk |

### 2.2. Channel Lifecycle Pattern

Every channel follows the same lifecycle: create → populate → consume → archive.
The inbox illustrates this clearly: entries arrive in `_inbox/`, are processed
during a session, and move to `_inbox/done/`. Checkpoints follow the same
pattern: created at milestones, consumed at session start, moved to
`checkpoints/done/`.

This lifecycle is itself an instruction pattern. When the agent sees an entry
in `_inbox/` (not in `done/`), it knows the entry is unprocessed. When it sees
a checkpoint in `checkpoints/` (not in `done/`), it knows context is available
to load. The folder structure communicates state without explicit instructions.

### 2.3. Channel Dependencies and Information Flow

Channels are not independent. Information flows between them in predictable
patterns:

```
research/ → blog/           (findings synthesized into publications)
feedback-to-dsm/ → plans/   (observations become backlog items)
plans/ → checkpoints/       (BL implementation tracked via snapshots)
handoffs/ → checkpoints/    (session continuity feeds milestone records)
_inbox/ → plans/             (external proposals become backlog items)
```

Breaking any link in this flow creates an information gap. The Protocol
Violation Triage Response (DSM_0.2 §22) exists precisely to detect and
repair these breaks.

---

## 3. Session Commands as Context Management Operations

DSM session commands are not convenience shortcuts. Each one performs a
specific context management operation that would otherwise require manual
assembly of information from multiple sources.

### 3.1. Command-to-Context-Operation Mapping

| Command | Context Operation | What It Manages |
|---------|------------------|-----------------|
| /dsm-go | Context initialization | Loads MEMORY.md, checks inbox, verifies branch state, reads handoffs |
| /dsm-wrap-up | Context persistence | Saves MEMORY.md, pushes feedback, creates handoff, archives transcript |
| /dsm-light-go | Lightweight context reload | Loads checkpoint and MEMORY.md only; skips inbox, version check |
| /dsm-light-wrap-up | Lightweight context save | Creates checkpoint with pending work; preserves transcript chain |
| /dsm-parallel-session-go | Context isolation | Creates independent branch and baseline; scoped context for parallel work |
| /dsm-parallel-session-wrap-up | Context merge | Merges isolated work back; completes BL lifecycle; updates shared state |
| /dsm-align | Template synchronization | Validates CLAUDE.md alignment, ecosystem paths, inbox structure |
| /dsm-staa | Retrospective analysis | Analyzes session transcript for reasoning patterns and improvement signals |
| /dsm-checkpoint | Milestone snapshot | Captures current state for future session resumption |
| /dsm-version-update | Release management | Versions, tags, syncs methodology changes across ecosystem |

### 3.2. The Context Initialization and Persistence Cycle

Every session follows a cycle: initialize context at start, work with that
context, persist context at end. The commands formalize this cycle:

```
/dsm-go (or /dsm-light-go)    →  session work  →  /dsm-wrap-up (or /dsm-light-wrap-up)
     ↓                                                    ↓
Load: MEMORY.md                                  Save: MEMORY.md
      checkpoints/                                      checkpoints/
      _inbox/                                           handoffs/
      git branch state                                  feedback push
      ecosystem paths                                   git push
```

The lightweight variants (/dsm-light-go, /dsm-light-wrap-up) reduce context
loading for continuation sessions where the task is already known. This is
itself a context engineering decision: when full context initialization would
consume budget without adding value, the lighter protocol preserves context
capacity for the actual work.

### 3.3. Parallel Sessions as Context Isolation

The parallel session commands (/dsm-parallel-session-go,
/dsm-parallel-session-wrap-up) implement a specific context engineering
pattern: isolation with controlled merge. A parallel session gets its own
branch, its own baseline file, and a declared scope. It cannot accidentally
modify files outside that scope. When the work is complete, it merges back
to the parent branch with full BL lifecycle completion.

This is the same pattern that containerization applies to compute: isolate
execution, control the interface, merge results. DSM applies it to context.

---

## 4. Context Lifecycle Across Session Types

Different session types manage context differently. Understanding these
differences is essential for choosing the right session type for a task.

### 4.1. Session Type Comparison

| Dimension | Full Session | Lightweight Session | Parallel Session |
|-----------|-------------|-------------------|-----------------|
| Context loaded | Full (MEMORY, inbox, issues, ecosystem) | Minimal (MEMORY, checkpoint) | Scoped (baseline, BL file) |
| Branch created | Level 2 session branch | Continues existing branch | Level 3 parallel branch |
| Transcript | Fresh (overwritten) | Continued (appended) | None (results only) |
| Feedback push | Yes (at wrap-up) | Deferred | No (main session handles) |
| Context budget | Moderate overhead | Low overhead | Minimal overhead |
| Best for | New work, full review needed | Continuation with known task | Isolated, scoped tasks |

### 4.2. Session Type as Context Engineering Decision

Choosing a session type is a context engineering decision. A full session loads
maximum context at the cost of budget. A lightweight session trades context
breadth for context depth (more budget for the actual task). A parallel session
trades shared context for isolation (no risk of cross-contamination).

The Session Configuration Recommendation (DSM_0.2 Module A) formalizes this
decision by suggesting model, effort level, and thinking mode based on the
planned work scope.

---

## 5. The Memory Architecture as Persistent Context

DSM maintains persistent context across sessions through multiple layers,
each with a different time horizon and purpose.

### 5.1. Memory Layer Architecture

| Layer | Artifact | Time Horizon | Purpose |
|-------|----------|-------------|---------|
| Session state | Session transcript | Current session | Real-time reasoning record |
| Session bridge | Checkpoints, handoffs | Between sessions | Task continuity across session boundaries |
| Project memory | MEMORY.md | Months | Accumulated project knowledge and patterns |
| Ecosystem memory | Reasoning lessons | Months to years | Cross-session heuristics and failure patterns |
| Versioned record | Git history, CHANGELOG | Permanent | Complete audit trail of every instruction change |

### 5.2. Memory Decay and Refresh Patterns

Each memory layer has different decay characteristics:

- **Session transcript:** Ephemeral; overwritten each full session. Not committed.
- **Checkpoints:** Consumed and moved to done/ at the next session start.
  Short-lived by design.
- **Handoffs:** Persist until superseded by the next handoff. Medium-lived.
- **MEMORY.md:** Updated each session; entries can become stale. Requires
  periodic review and pruning.
- **Reasoning lessons:** Accumulated over many sessions. Highest durability
  but risk of obsolescence as protocols change.
- **Git history:** Permanent and immutable. The ultimate source of truth.

The refresh pattern matters for context engineering: stale memory is worse
than missing memory, because stale memory creates confident but incorrect
behavior. The auto-memory system addresses this by requiring verification
of recalled facts against current state before acting on them.

---

## 6. Cross-Project Context Routing Mechanisms

At the ecosystem level, context must flow between projects. DSM implements
three routing mechanisms, each addressing a different propagation pattern.

### 6.1. Routing Mechanism Comparison

| Mechanism | Direction | Trigger | What Flows |
|-----------|-----------|---------|------------|
| `@` reference chain | Hub → spoke (pull) | Session start, when agent reads CLAUDE.md | Protocols, instruction templates, behavioral rules |
| Inbox system | Bidirectional (push) | Session wrap-up, when feedback is ready | Methodology observations, backlog proposals, action items |
| Mirror sync | Hub → mirror (push) | Version Update Workflow, after methodology changes | Methodology files, command files |

### 6.2. Propagation Failure Detection

Each mechanism has a characteristic failure mode:

- **`@` reference:** Silent failure. If the reference is missing or stale,
  no protocols are loaded. The agent behaves as if DSM_0.2 does not exist.
  Detection: /dsm-align validates the reference.
- **Inbox:** Accumulation failure. If entries are not processed, they pile up.
  The agent re-processes stale entries. Detection: session-start inbox check.
- **Mirror sync:** Drift failure. If sync is skipped, mirror repos diverge
  from Central. Detection: version comparison at session start.

---

## 7. Connection to Project Management Knowledge Areas

The operational channels and context management practices described in this
module map to established Project Management knowledge areas. This mapping
(analyzed in detail in BL-260) reveals that DSM already performs project
management of its instruction system, framed as methodology governance
rather than PM.

### 7.1. Key PM Knowledge Area Connections

| PM Knowledge Area | DSM Equivalent | Primary Artifacts |
|-------------------|---------------|-------------------|
| Communication Management | Operational channels (§2) | _inbox/, feedback-to-dsm/, blog/ |
| Integration Management | Context routing (§6) | `@` chain, mirror sync, Version Update Workflow |
| Schedule Management | Session lifecycle (§3-4) | /dsm-go, /dsm-wrap-up, sprint cadence |
| Cost Management | Context budget | Context Budget Protocol (DSM_0.2 §11) |
| Quality Management | Instruction validation | Branch Testing, Graph Explorer CI |
| Risk Management | Failure prevention | Failure Mode Taxonomy (DSM_6.1 §7), Protocol Violation Triage |

### 7.2. The Dual-Stakeholder Model

Traditional PM manages human stakeholders. DSM manages two: the human
collaborator (via Pre-Generation Brief Protocol, Active Suggestion Protocol)
and the AI agent (via CLAUDE.md, `@` reference chain, session commands).
This dual-stakeholder model is a distinguishing characteristic of Systems
Prompt Engineering as practiced in DSM.

---

## 8. References and Version History

Sources and change history for this module.

### 8.1. Internal References

- DSM_6.1: Systems Prompt Engineering (parent document)
- DSM_0.2 §3: Session-Start Inbox Check
- DSM_0.2 §7: Session Transcript Protocol
- DSM_0.2 §11: Context Budget Protocol
- DSM_0.2 §18: Ecosystem Path Registry
- DSM_0.2 §22: Protocol Violation Triage Response
- DSM_0.2 Module A: Session Lifecycle protocols
- BL-260: PromptOps and PMP Parallels (PMP mapping analysis)
- Document Structure Standard: `dsm-docs/guides/document-structure-standard.md`

### 8.2. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-25 | Initial release: nine operational channels, session commands, context lifecycle, memory architecture, cross-project routing, PM connections |
