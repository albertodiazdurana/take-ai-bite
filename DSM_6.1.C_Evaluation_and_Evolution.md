# DSM 6.1 Module C: Evaluation and Evolution

**Version:** 1.0
**Last Updated:** 2026-03-25
**Parent document:** DSM_6.1 Systems Prompt Engineering

Modules A and B cover what DSM builds (operational channels) and how it builds
(design patterns). This module covers the measurement and learning layer: how
to evaluate whether an instruction system works, how to detect when it drifts,
and how the methodology evolves through structured feedback. Without evaluation,
an instruction system can only grow; it cannot improve.

## Contents

1. [Evaluation as the Missing Layer in Prompt Engineering](#1-evaluation-as-the-missing-layer-in-prompt-engineering)
2. [Git History as Instruction System Audit Trail](#2-git-history-as-instruction-system-audit-trail)
3. [Graph Explorer as Automated Instruction Validation](#3-graph-explorer-as-automated-instruction-validation)
4. [STAA as Systematic Effectiveness Analysis](#4-staa-as-systematic-effectiveness-analysis)
5. [Temporal Comparison of Methodology States](#5-temporal-comparison-of-methodology-states)
6. [The Learning Loop from Evaluation to Evolution](#6-the-learning-loop-from-evaluation-to-evolution)
7. [References and Version History](#7-references-and-version-history)

---

## 1. Evaluation as the Missing Layer in Prompt Engineering

The prompt engineering literature covers how to write prompts (techniques,
templates, few-shot examples) and how to evaluate individual outputs
(LLM-as-a-Judge, batch evaluation frameworks like DeepEval and Promptfoo).
What it does not cover is how to evaluate an instruction system: a
coordinated set of documents, protocols, and feedback loops that govern AI
behavior across an ecosystem.

Individual output evaluation asks: "Did this response meet the criteria?"
Instruction system evaluation asks different questions:

| Evaluation Level | Question | Method |
|-----------------|----------|--------|
| Individual output | Did this response meet criteria? | LLM-as-a-Judge, human review |
| Protocol compliance | Did the agent follow the prescribed behavior? | Session transcript analysis |
| System consistency | Do instruction documents agree with each other? | Cross-reference validation |
| Ecosystem health | Do changes propagate correctly across projects? | Mirror sync verification, version comparison |
| Evolution trajectory | Is the methodology improving over time? | Temporal comparison, feedback volume analysis |

DSM provides tools for levels 2-5, which are the levels the literature
largely ignores. This is where Systems Prompt Engineering evaluation
operates.

---

## 2. Git History as Instruction System Audit Trail

Every instruction change in DSM is committed to git with a descriptive
message, tagged with a semantic version, and recorded in the CHANGELOG.
This creates a complete, immutable audit trail of the instruction system's
evolution.

### 2.1. What Git History Reveals

| Git Operation | Evaluation Insight |
|---------------|-------------------|
| `git log` | Chronological record of every instruction change |
| `git diff` between versions | Precise changes between any two states |
| `git blame` | Who changed each line and when |
| `git tag` | Release boundaries and recovery points |
| CHANGELOG entries | Semantic categorization of changes (Added/Changed/Fixed) |

### 2.2. Diff Analysis as Evaluation Tool

Comparing methodology versions reveals patterns:

- **Growth trajectory:** Line counts over time show whether the methodology
  is expanding, stabilizing, or being refined. DSM's trajectory shows
  initial growth (Phases 1-2), followed by modularization and trimming
  (Phase 3), indicating maturation.
- **Churn hotspots:** Files that change frequently may indicate unstable
  protocols or areas where the design is still evolving. DSM_0.2 has the
  highest churn, which is expected: it contains the operational protocols
  that receive the most feedback.
- **Deletion ratio:** A healthy instruction system deletes as well as adds.
  The domain-neutrality audits (BL-201 through BL-256) demonstrate this:
  DSM_4.0 went from 995 to 790 lines (20.6% reduction) while preserving
  all essential guidance.

### 2.3. Version Tags as Recovery Points

Semantic version tags serve two functions: they mark release boundaries for
the CHANGELOG, and they provide recovery points. If a protocol change
produces unexpected behavior in spoke projects, the tag identifies the exact
state to compare against. This is the instruction-system equivalent of a
software rollback point.

---

## 3. Graph Explorer as Automated Instruction Validation

Graph Explorer is DSM's CI system for instruction documents. It treats the
methodology as a graph of interconnected documents and validates structural
integrity, cross-reference consistency, and heading compliance.

### 3.1. Validation Categories

| Category | What It Checks | Example |
|----------|---------------|---------|
| Cross-reference integrity | Do internal references point to existing sections? | "DSM 4.0 Section 15" must resolve to an actual section |
| TF-IDF similarity | Do documents that reference each other share vocabulary? | A dispatch table entry should match its target module |
| Heading compliance | Do headings meet parsability conventions (≥4 tokens)? | Warning W004 for short headings |
| Structural completeness | Do required elements exist (TOC, intro paragraphs)? | Document Structure Standard compliance |
| Link resolution | Do file paths and URLs resolve? | Broken links to moved or deleted files |

### 3.2. Graph Explorer as Prevention, Not Detection

The Branch Testing Requirement (DSM_0.2 §19) mandates testing before merge.
Graph Explorer runs as part of this verification, catching issues before they
propagate to spoke projects via the `@` reference chain. This is prevention
at the source, which is cheaper and more reliable than detection after the
fact.

### 3.3. The 547-Test Benchmark

Graph Explorer's current test suite (547 tests) covers the DSM document
ecosystem. The test count is not a vanity metric; it represents the surface
area of the instruction system that is automatically validated. Each test
encodes a structural invariant that, if violated, would produce a specific
failure mode from the taxonomy in DSM_6.1 §7.

---

## 4. STAA as Systematic Effectiveness Analysis

The Session Transcript Analysis Agent (STAA) is DSM's retrospective
evaluation tool. It analyzes session transcripts to extract reasoning
patterns, identify protocol compliance issues, and generate improvement
signals.

### 4.1. What STAA Evaluates

| Analysis Dimension | What It Reveals |
|-------------------|----------------|
| Protocol compliance | Did the agent follow prescribed protocols? (transcript timing, gate sequence) |
| Reasoning quality | Are decisions well-reasoned or pattern-matched? |
| Failure patterns | Which failure modes recur across sessions? |
| Recovery effectiveness | When failures occur, how quickly does the agent recover? |
| Collaboration dynamics | Is the interaction bidirectional or passively compliant? |

### 4.2. Reasoning Lessons as Accumulated Heuristics

STAA extracts reasoning lessons: heuristics derived from session experience
that inform future behavior. These lessons accumulate over time, creating a
growing knowledge base of what works and what fails in specific contexts.

Reasoning lessons differ from protocol rules in an important way: protocols
prescribe behavior ("do X when Y"), while reasoning lessons capture judgment
("in situations like Z, approach A tends to work better than approach B
because..."). Protocols are mandatory; reasoning lessons are advisory. Both
are instruction artifacts, but they operate at different levels of rigidity.

### 4.3. The Evaluation Paradox and Mitigation

Evaluating an AI collaboration system using the same AI creates a reflexivity
problem: the evaluator and the evaluated share the same biases. DSM mitigates
this through:

1. **Human review gate:** STAA findings are presented to the human, not
   automatically applied. The human decides which findings warrant action.
2. **Structured format:** STAA outputs follow a fixed template, reducing
   the degrees of freedom for the evaluator to rationalize or dismiss findings.
3. **Cross-session comparison:** Patterns that appear once may be noise;
   patterns that recur across sessions signal genuine issues.

---

## 5. Temporal Comparison of Methodology States

The methodology is not static. Comparing its state at different points in
time reveals evolution patterns, maturation signals, and potential
regression.

### 5.1. Comparison Methods

| Method | What It Shows | When to Use |
|--------|--------------|-------------|
| Version diff | Line-level changes between releases | After a release, to verify changes |
| Line count trends | Growth, stabilization, or reduction over time | At sprint boundaries, to assess trajectory |
| Structural comparison | How the document graph changed (new modules, renamed sections) | At phase boundaries, to assess architecture |
| Feedback volume analysis | Frequency and severity of reported issues | At sprint boundaries, to assess maturity |
| Graph network snapshots | Full topology of cross-references at a point in time | At major releases, to capture architecture |

### 5.2. Evolution Velocity and Direction

Two metrics characterize methodology evolution:

- **Velocity:** How frequently the methodology changes. High velocity in
  early phases (rapid protocol development) should decrease over time
  as the system stabilizes. Sustained high velocity in a mature system
  may indicate architectural instability.
- **Direction:** Whether changes are additive (new protocols), subtractive
  (removing redundancy), or lateral (restructuring without net growth).
  Healthy evolution shows all three types in appropriate proportion.

### 5.3. Maturity Signals from Temporal Analysis

| Signal | Immature System | Maturing System | Mature System |
|--------|----------------|-----------------|---------------|
| Change type | Mostly additive (new protocols) | Mix of additive and subtractive | Mostly lateral (refinement) |
| Feedback nature | Fundamental gaps | Edge cases, interaction effects | Optimization, consistency |
| Modularization | Monolithic documents | Active splitting (BL-257, 268-270) | Stable module boundaries |
| Cross-reference stability | References frequently break | References occasionally break | References rarely break |
| Version cadence | Frequent patches | Regular minor releases | Infrequent, well-planned releases |

---

## 6. The Learning Loop from Evaluation to Evolution

Evaluation without action is measurement theater. The learning loop connects
evaluation findings back to the empirical PE cycle (DSM_6.1 §6), closing the
gap between observing a problem and fixing it.

### 6.1. The Complete Learning Loop

```
Evaluation (STAA, GE, temporal)  →  Finding (pattern, gap, regression)
         ↓                                        ↓
Classification (failure mode)    →  Triage (fix, root-cause, prevent)
         ↓                                        ↓
BL creation (scoped change)      →  Implementation (branch, test, merge)
         ↓                                        ↓
Release (version, tag, sync)     →  Next evaluation cycle
```

### 6.2. Self-Improvement as Emergent Property

The learning loop is not a feature that was designed in advance. It emerged
from the interaction of independently motivated practices: version control
(for traceability), feedback files (for communication), Protocol Violation
Triage (for systematic response to deviations), and the backlog system (for
tracking improvements). Each practice was created to solve an immediate
problem; together, they form a self-improving system.

This emergence is characteristic of Systems Prompt Engineering at maturity:
the instruction system develops properties that none of its individual
components were designed to produce. DSM_6.0 §1.9 (Think Ahead) predicted
this pattern: "A learning system generates its own improvement backlog."

### 6.3. The Methodology as Living Document

The final implication of the learning loop is that the methodology is never
"done." Every session generates operational data. Every deviation generates
a learning signal. Every evaluation cycle may reveal a new improvement
opportunity. The methodology is a living system that evolves through use,
not a static document that is written once and followed forever.

This is the core claim of Systems Prompt Engineering: at scale, instruction
systems are not documents to be written but ecosystems to be cultivated.

---

## 7. References and Version History

Sources and change history for this module.

### 7.1. Internal References

- DSM_6.1: Systems Prompt Engineering (parent document)
- DSM_6.1 §6: The Empirical Prompt Engineering Cycle
- DSM_6.1 §7: Failure Mode Taxonomy for Instruction Systems
- DSM_0.2 §19: Branch Testing Requirement
- DSM_0.2 §22: Protocol Violation Triage Response
- DSM_6.0 §1.9: Think Ahead Principle
- Graph Explorer: DSM spoke project (cross-reference validation)
- STAA: Session Transcript Analysis Agent (/dsm-staa command)

### 7.2. External References

- Confident AI (2025). "LLM Evaluation Metrics Guide."
- Evidently AI (2025). "LLM-as-a-Judge Complete Guide."
- Liu, W. et al. (2026). "Agentic Critical Training." arXiv:2603.08706.

### 7.3. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-25 | Initial release: git as audit trail, Graph Explorer validation, STAA analysis, temporal comparison, learning loop |
