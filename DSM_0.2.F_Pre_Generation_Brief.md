# DSM_0.2 Module F: Pre-Generation Brief Protocol

Extracted from DSM_0.2 core §8 (EXP-007). Read on demand before creating any
artifact, exactly as Modules A-D are read. NOT part of the `@` import chain.

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

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.0.1. User-Reframes-Proposal Handling

§8.0 establishes that the conversation defining the work IS the
collaboration. That is the principle. §8.0.1 names the operational
behavior the principle implies for one specific, recurring move: when the
user responds to an agent's proposal by **reframing** it (re-decomposing,
re-shaping the structure, changing the axis of the split) rather than
answering yes/no. The principle in §8.0 ("the conversation IS the
collaboration") does not by itself prevent the failure mode, agents
defended their original framing across six separate recurrences spanning
four-plus months while §8.0 was already in force. The gap between the
principle and the behavior is what §8.0.1 closes.

**The rule:** a user reframe is a signal to **re-decompose, not to
defend**. Accept the reframing and re-run the threads → dependencies →
packaging steps on the new framing. Do not relitigate the original
framing, do not argue for why the first decomposition was correct, do not
treat the reframe as a deviation to be negotiated back toward the
original.

**Two operational sub-rules:**

1. **Loose framing → ask before proposing.** When the user's framing is
   loose ("formalize as BL", "address this", "handle these"), ask "what
   threads do you see?" *before* presenting a decomposition. Proposing a
   pre-formed decomposition and inviting yes/no is the §8.0 anti-pattern;
   when the framing is loose, the threads themselves are the collaboration
   surface (S203 data point: a decomposition was reframed twice in twelve
   minutes because it was proposed before the user's framing was elicited).

2. **A reframe that doubles as a "this also explains why" is high-signal.**
   When the user's reframe simultaneously fixes the proposal AND explains
   why the original problem existed, the original framing missed a
   structural coupling. Treat the "this also explains why..." moment as a
   diagnostic: re-examine adjacent artifacts or protocols for the same
   coupling, do not just apply the local fix (S201 data point: a
   checkpoint-ordering reframe also explained why checkpoints had stopped
   appearing).

**Cross-reference, do NOT absorb, the distinct sibling patterns:**

- **User-factual-question = wrong-framing signal** (S180/S183/S191): when
  the user answers a proposal with a factual question ("isn't X already
  true?") instead of yes/no, answer the question first, it usually
  reveals a wrong assumption in the proposal's premise.
- **User-pointer-as-implicit-correction** (S204): when the user replies to
  a state-claim with a path or filename, the pointer IS the correction,
  read the pointed-to source before responding.
- **"Why does this matter?" = drop-signal** (S198): when the user
  challenges an option with "why does this matter?", dismantle the
  option's premise from scratch before defending it.
- **Deliverable-portability-question = scope-expansion** (S204): a "how
  does this transfer to the mirror/clone/spoke?" question during Gate 1 is
  a scope-expansion signal, widen scope and re-confirm Gate 1 rather than
  deferring to a follow-up BL.

These siblings share a family resemblance (a non-yes/no user response that
reveals a premise the agent should re-examine) but each has its own
trigger and its own correct response, so they are referenced here rather
than collapsed into one rule. Each may warrant its own future promotion.

**Anti-pattern guard:** "The user reframed it, but my original
decomposition was structurally cleaner, so I'll explain why before
adopting theirs" is the exact rationalization §8.0.1 forbids. The reframe
is not a proposal to be evaluated against the agent's; it is the
collaboration redefining the work. Same guard family as §8.2.1 ("No
counter-evidence found" without sources surveyed), §8.6.1 ("silence from
the skill is the skill's answer"), §21.2 ("Risks: none known"), §21.3
("all tests passed").

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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

**Relationship to DSM_7.0 §2.1:** Gate 2 is the platform-agnostic
implementation-review gate. DSM_7.0 §2.1.5 describes the Claude-specific
realization: the VS Code extension's file-write approval dialog,
activated by `claudeCode.initialPermissionMode: "default"`. Other
platforms realize Gate 2 through their own permission surfaces.

Create the artifact using Write/Edit tools. The user reviews the diff in the
IDE permission window.

**STOP** and wait for explicit approval via the permission window. Do not
proceed to the next artifact or to execution until the user has reviewed
the implementation.

### 8.2.1. Strongest Counter-Evidence Requirement

Before requesting Gate 2 approval for any recommendation-style artifact, the
agent MUST surface the strongest counter-evidence to its own recommendation,
drawn from sources read during brief preparation. Confidence-shaped briefs
hide weakness signals until the user pushes back; codifying counter-evidence
surfacing shifts the burden from user vigilance to protocol.

**Format (required when the brief contains a recommendation):**

```markdown
## Strongest counter-evidence

- [Counter-claim or risk]: [source / reasoning]
- Why I am still recommending [recommendation] despite this:
  [explicit weighing of why the chosen path wins anyway]
```

**Anti-pattern guard:** the section must be substantive. Acceptable forms:

- "Source X says the opposite, ranked it weaker because [evidence-strength
  tier, sample size, methodology gap, etc.]"
- "No counter-evidence found. Sources checked for counter-evidence: X, Y, Z."

NOT acceptable: "No counter-evidence found" without listing which sources
were surveyed. Empty sections satisfy the rule's letter while violating its
intent (Earn Your Assertions, DSM_6.0 §1.3).

**Trigger scope:** applies to Gate 2 invocations involving recommendations
(architecture choices, BL implementations, approach selection, design
trade-offs). Does NOT apply to:

- Pure mechanical edits (typo fixes, version bumps, status flips)
- Trivial artifacts already excluded by §8.4 Gate Scope
- Brief-less actions (e.g., responding to "make this typo fix" without a
  Gate 1 brief)

**Consequence of skipping:** §22 Protocol Violation Triage Response
applies. A recommendation that lands without surfaced counter-evidence,
where counter-evidence existed in sources read during brief prep, is a
§22 violation. The agent must halt, surface the counter-evidence
retroactively, and propose a §22 fix-root-cause-prevent triage.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


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
answering three questions in the session transcript plan block:

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
The what/why/how is written in the transcript plan block, making reasoning
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

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


**Relationship to DSM_6.0 §1.11 Read the User's Manual:** §8.6 is the
skill-file-scoped instance of the broader principle. §1.11 governs
external-tool grounding in general (Claude Code harness, `gh` CLI,
Gitleaks, third-party APIs); §8.6 applies the same read-before-claim
discipline to DSM's own skill files. Protocols that invoke external
tools inherit §1.11 directly; the skill-file case is routed through §8.6.

### 8.6.1. Skill Scope Is Authoritative

§8.6 prevents memory-based claims about skill behavior by requiring the
agent to read the skill file before answering "does skill X do Y?". §8.6
addresses the "claimed from memory" failure mode. It does NOT address
the "augmented at runtime" failure mode, where the agent invokes a skill
correctly, then runs additional checks NOT inside the skill's documented
scope, and folds those checks' findings into the skill's report. The
end-state symptom is the same (the skill appears to say something it
didn't), but the mechanism is different: §8.6 catches misremembering;
§8.6.1 catches augmentation.

**Skill scope is authoritative.** A skill's declared scope defines its
output. Checks adjacent to the skill's scope are separate findings and
must be reported separately, not folded into the skill's report.
**Silence from the skill on a concern is the skill's answer.** Before
widening a skill's report with an adjacent check, the agent asks: "is
this check part of the skill's documented steps?" If not, the agent
chooses one of three options:

1. **Run it as an out-of-band audit with its OWN label** (e.g., a
   distinct `## Out-of-band audit: command file drift` section,
   separate from the skill's report block, so the user can see the
   finding came from outside the skill).
2. **File a BL to extend the skill's documented scope**, so the next
   skill version produces the desired output as part of its declared
   responsibility.
3. **Skip the check.** Not every adjacent concern needs to surface in
   this session. The agent is not obligated to compute every adjacent
   finding it could; the skill's silence on a concern is a valid
   answer.

**Anti-pattern guard:** "The skill is silent on X, but the user clearly
cares about X, so I'll add an X check to the skill's report" is the
exact rationalization §8.6.1 forbids. Variants of the same defect:

- "The skill's report is incomplete without my adjacent finding"
- "I have the data, why not include it"
- "The user expects this field populated"
- "Auto mode means I should fill silences"

All are §8.6.1 violations when the adjacent check is outside the
skill's documented scope. Same guard family as §8.6 ("read the skill
before claiming behavior"), §8.2.1 ("No counter-evidence found"
without sources surveyed), §21.2 ("Risks: none known"), §21.3 ("all
tests passed"), §8.9 ("Auto-mode active. Executing.").

**Distinction from skill composition:** using one skill's output as
input to another skill is **composition**, not augmentation. §8.6.1
forbids folding off-skill check results into a skill's report; it does
NOT forbid using skill outputs as inputs to other workflows. The test
is whether the off-skill finding is presented AS THE SKILL'S OUTPUT.

**Cross-references:**

- §8.6 (parent: read the skill before claiming behavior)
- §8.4 (each artifact gets its own gate cycle)
- §22 (Protocol Violation Triage Response when §8.6.1 is violated)
- DSM_6.0 §1.11 Read the User's Manual (foundational principle for
  both §8.6 and §8.6.1)
- BL-434 (concrete sibling: /dsm-align Step 12 `Command sync` line
  conditional spec, the same incident's mechanical fix)

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.7. Token-Minimizing Config Recommendation at Gate 1

Module A §14 Session Configuration Recommendation sets a session-level
baseline at session start and on major task shifts. A single session
routinely produces multiple Gate 1 artifacts whose cognitive demand varies
widely: a mechanical BL status flip and an architectural decision both
run at the session baseline, which either burns context on trivial work or
under-provisions complex work. DSM_6.0 §2.3 Environmental Awareness states
"prefer the sufficient configuration over the maximal one" as a principle
but has no Gate-1-visible operational trigger. §8.7 closes that gap at
per-artifact granularity.

**Trigger:** within every Gate 1 brief where the artifact's demand profile
diverges from the current session baseline. Asymmetric: the recommendation
is absent when the baseline matches, present only when divergence is clear.

**Agent behavior:** the Gate 1 brief includes a one-line recommendation
when divergence is clear, drawn from this table:

| Artifact demand | Current baseline | Recommended action |
|-----------------|------------------|--------------------|
| Clearly below baseline (mechanical edit, status flip, trivial) | Standard / Deep | Downshift (lower effort, Thinking OFF, Fast ON) for this artifact |
| Clearly above baseline (architectural decision, novel design, multi-source synthesis) | Efficient / Light | Upshift (Opus / High effort / Thinking ON) for this artifact |
| Reading-heavy (research sweep, codebase exploration, large-file comprehension) | Any | Offload to Sonnet subagent; keep main thread at baseline |
| Matches baseline | Any | No recommendation (skip this line) |

**Format in the Gate 1 brief:**

```markdown
## Gate 1: [artifact name]

**What:** ...
**Why:** ...
**Key decisions:** ...
**Structure:** ...

**Config recommendation (per §8.7):** [action] , [one-line reason].
```

**Skip condition (ritualism guard):** if the artifact's demand matches the
session baseline, do NOT include a config recommendation in the Gate 1
brief. An empty "Config recommendation: no change" line is itself
ritualistic compliance and is explicitly prohibited (same guard pattern as
§10.1's "ritualistic compliance" anti-pattern and §8.2.1's "No counter-
evidence found" anti-pattern).

**Subagent-first for reading-heavy artifacts:** when the artifact requires
reading large files, multi-file codebase sweeps, or multi-source research,
the strongest token-minimizer is typically delegating to a Sonnet subagent
rather than downshifting main-thread effort. Recommend subagent delegation
first; downshift effort second. Subscription-awareness: before recommending
subagent offload, check `~/.claude/claude-subscription.md` for a separate
Sonnet pool (Max plan has one); on plans without a separate pool the
subagent consumes the same budget and the recommendation should be
suppressed or flagged with a cost note.

**Ordering with §8.2.1 Strongest Counter-Evidence:** when a Gate 1 brief
requires both the counter-evidence section (§8.2.1) and a config
recommendation (§8.7), the config recommendation appears FIRST (before
counter-evidence). Rationale: config recommendation shapes the
computational approach to the artifact; counter-evidence shapes the
artifact's content. The computational decision comes before the content
decision.

**User options:** accept the recommendation, override with a different
config, or skip and keep the baseline. §8.7 does not present a new gate
pause; the recommendation lives inside the Gate 1 brief and shares its
approval under the same gate-behavior rules as the rest of §8.

**Relationship to other protocols:**

- Module A §14 (Session Configuration Recommendation) sets the session
  baseline; §8.7 adjusts per artifact within that baseline. Different
  granularities, complementary.
- DSM_6.0 §2.3 Environmental Awareness is the foundational principle §8.7
  operationalizes.
- §23.4 Runtime Register Context Convention is the analogous pattern at
  skill-invocation granularity (per-invocation annotation for a skill).
  §8.7 applies the same per-invocation shape to Gate 1 config
  recommendations.
- §8.9 Auto-Mode Boundaries governs whether the Gate 1 pause holds; §8.7
  fits within whichever gate behavior §8.9 has established for the
  session.
- §8.8 Parallel Offload Analysis is the complementary Gate 1 sub-section
  covering subagent orchestration. §8.7 decides the main-agent config;
  §8.8 decides whether sub-tasks of the same artifact run on parallel
  subagents. Both sit inside Gate 1; see §8.8 for ordering.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.8. Parallel Offload Analysis at Gate 1

§8.7 sets the main-agent config per artifact. It does not address
whether sub-tasks of the upcoming Gate 2 implementation should be
delegated to parallel subagents (typically Sonnet) while the main
agent (typically Opus) stays on the reasoning thread. Without a
protocol-level obligation, offload happens ad hoc: sometimes the
main agent silently delegates mid-implementation, sometimes it
absorbs reading-heavy or mechanical work that would have been
cheaper to hand off. Neither is a user-approved plan. §8.8 closes
that gap by making offload analysis a first-class part of the
Gate 1 brief, with explicit per-task user approval required before
any parallel agent spins.

**Foundational principle:** Don't be a Hero, Delegate the Effort
(DSM_6.0 §1.12).

**Trigger:** within every Gate 1 brief where the main agent
identifies at least one sub-task of the upcoming Gate 2
implementation that fits the offload profile. Asymmetric like §8.7:
the section is absent when no candidates exist, present only when
they do.

**Candidate sub-task types:**

- Mechanical text operations (bulk rename, find/replace across many
  files, enumerable string substitutions)
- In-repo context research (multi-file sweeps, cross-link audits,
  dependency scans, "where is X used?" surveys)
- External research (web searches, URL fetches, source-verification
  passes per §10 / §10.1, competitive comparisons)
- Other sub-tasks whose shape matches the offload profile: bounded
  scope, token-heavy, reasoning-light, or parallelizable with the
  main thread

**Agent behavior:** the Gate 1 brief includes a new section when
candidates exist, listing each candidate as a per-task
recommendation:

```markdown
## Parallel offload analysis (per §8.8)

Candidate sub-tasks for parallel Sonnet offload:

1. **[sub-task name]** — [what the subagent would do] — expected
   net savings: [tokens / context slots freed, net of synthesis
   cost] — risk: [coordination cost, synthesis cost, fan-out on
   shared budget].
2. **[sub-task name]** — ...

Per-task approval requested. Reply with explicit yes/no for each,
or "skip all" to decline. No parallel agent spins without explicit
approval.
```

**Hard constraint — explicit per-task approval:** no parallel
subagent spins without explicit per-task user approval. A general
Gate 1 "y" does NOT approve offload; offload requires its own
explicit per-task yes. This is the core user requirement behind
the BL and is not waivable under any autonomy mode (see §8.9 Auto-Mode Boundaries).

**Fail-closed default:** if the user says "proceed" / "y" /
"continue" to the Gate 1 brief without addressing the offload
section, treat as REJECTED for every offload candidate. The main
agent handles everything on-thread.

**User options per candidate:** approve, reject, or defer. Defer
means "do it on-thread for now; I may offload if it grows."
Rejection is the default on silence.

**Skip condition (ritualism guard):** if the main agent identifies
no offload candidates (e.g., the artifact is purely a decision call
with no mechanical or reading-heavy sub-tasks), do NOT include a
§8.8 section in the brief. An empty "Offload: none" line is itself
ritualistic compliance and is prohibited (same guard pattern as
§8.7, §8.2.1, §10.1).

**Subscription-awareness:** before proposing offload, check
`~/.claude/claude-subscription.md` for a separate Sonnet pool. On
plans without one, subagent tokens consume the same budget as
main-agent tokens; flag the cost in the savings estimate or
suppress the proposal when expected savings are net-negative.

**Net-savings requirement:** the Gate 1 brief must state *net*
expected savings, not gross. Synthesis cost (main agent reading and
integrating subagent output) is part of the total; if synthesis
exceeds raw delegation savings, offload is counterproductive and
should not be proposed.

**Subagent write authority:** by default, the main agent writes
files (preserves Gate 2 diff review). Exception: pure research
subagents whose deliverable IS a research file (per §10) may write
the research file directly. Any other file change must return to
the main agent for Gate 2 review.

**Gate 2 drift rule:** if a subagent's results materially change
the main agent's approach after Gate 2 was already approved on the
pre-offload plan, loop back to Gate 1 with a revised brief before
proceeding. Gate 2 approval does not survive a material change in
the underlying plan.

**Ordering with other Gate 1 sub-sections:** when a Gate 1 brief
contains multiple recommendation sections, order them:

1. §8.7 config recommendation (main-agent computational approach)
2. §8.8 parallel offload analysis (subagent orchestration)
3. §8.2.1 counter-evidence (content-level)

Rationale: computational decisions (main-agent config, then
subagent delegation) come before content decisions (counter-
evidence shapes what the artifact says).

**Relationship to other protocols:**

- **§8.7 (Token-Minimizing Config):** §8.7 sets main-agent config
  per artifact; §8.8 sets subagent orchestration per sub-task.
  Different axes, complementary.
- **§8.2.1 (Strongest Counter-Evidence):** both live inside the
  Gate 1 brief; ordering defined above.
- **Module A §7 Parallel Session Protocol:** distinct from §8.8.
  Parallel *sessions* are user-initiated sibling main sessions on
  a separate chat tab, committed via the commit booking system.
  §8.8 is agent-initiated subagent delegation within one turn.
  The two must not be conflated.
- **Module A §14 Session Configuration Recommendation:** §14 sets
  session-wide baseline, §8.7 adjusts per artifact, §8.8
  orchestrates per sub-task. Three granularities: session →
  artifact → sub-task.
- **§10 / §10.1 (Web Research Capture and Validation Depth):**
  external research offloaded to a subagent MUST still satisfy §10
  (raw findings captured to `dsm-docs/research/`) and §10.1
  (multi-pass for deliverable-critical claims). Offload is a
  thread delegation, not a standard reduction.
- **§23.4 (Runtime Register Context):** if the offloaded sub-task
  invokes a register-sensitive skill, the main agent must pass the
  §23.4 runtime context block in the subagent prompt.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.9. Auto-Mode Boundaries

Claude Code's Auto mode widens default authorization for routine
low-stakes and well-scoped artifacts. Its relationship to the four-gate
model is governed by three rules: default behavior preserves Gate 1
pauses, explicit user instruction may suspend them, and exception-
detection remains active even under suspension.

**Default auto-mode behavior** (no further instruction from the user):

1. Auto mode does NOT override §8.4's "Each artifact gets its own gate
   cycle" rule. A bulk directive like "file the 5 BLs" requires 5
   separate Gate 1 briefs AND 5 separate opportunities for the user to
   redirect, not one combined brief followed by batch execution.
2. Auto mode does NOT collapse Gate 1 into Gate 2. The pause between
   presenting a brief and beginning implementation is the user's
   redirect window; removing it pushes all correction work to post-hoc
   diff review, which is not equivalent.
3. Auto mode DOES widen default authorization for: mechanical edits
   (typo fixes, version bumps, status flips, BL moves to done/),
   trivial artifacts (`.gitkeep`, minor config), and artifacts the
   user explicitly authorized by name at the moment of request.
4. Auto mode does NOT override Gate 3 destructive-action approvals
   (§2 Destructive Action Protocol, §2.1 Default-Branch Verification,
   §2.2 opt-in permission patterns). Those continue to require explicit
   per-action confirmation.
5. Auto mode does NOT compress §19 / §21.3 testing requirements
   (Pre-Merge Test Plan Execution Rule). Auto mode is an approval-
   friction lever, not a verification-discipline lever. The same
   carve-out pattern §22's stop-condition uses for auto mode applies
   here. Origin: S206 chain-implementation of BL-352/421/424 shipped
   untested under auto mode; the user had to ask "were all tested?"
   to surface the gap, which is itself the failure.

**Explicit suspension (opt-in, full-speed mode):**

The user MAY explicitly instruct the agent to suspend Gate 1 pauses
with a directive that unambiguously names the suspension, such as:

- "collaboration gates will not be needed"
- "run without interruptions"
- "skip the Gate 1 pauses for this work"
- equivalent phrasing that names the suspension explicitly

When the suspension is in effect:

1. The agent MAY proceed from Gate 1 brief directly to execution
   without waiting for explicit "y" on each sub-artifact.
2. The agent STILL presents each Gate 1 brief (for traceability and
   post-hoc review), but the brief is informational rather than a
   pause-point.
3. The suspension applies only to the scope the user named; it is NOT
   standing across the whole session unless the user named session-
   scope explicitly.
4. The suspension does NOT extend to Gate 3 destructive actions or to
   §19 / §21.3 testing requirements. Those continue to apply.

**Suspension preconditions (clear work definition required):**

Explicit suspension is valid only when the work definition is clear.
Clear work definition means:

1. The scope of each sub-artifact is determined by prior conversation,
   BL file content, or unambiguous directive (not inferred).
2. No contradictions are detected between the user's directive and the
   source material (e.g., BL file scope, related protocols).

**Exception-detection during suspended execution:**

If the agent detects inconsistent or contradictory work definitions
during suspended execution, the suspension lapses automatically for
the affected artifact. The agent MUST halt before the affected
artifact, surface the inconsistency to the user, and request
clarification, even if the explicit suspension covered the broader
batch. Triggering inconsistencies include:

- BL file status says "Implemented" but the user directs "implement BL-X"
- Two BLs in a batch declare overlapping scopes that would collide on
  execution
- Source material (BL file, inbox entry, related protocols) disagrees
  with the user's directive on a substantive point
- The work requires files or actions the user did not name in the
  suspension scope (cross-repo writes, methodology section changes,
  BLs not included in the batch)

After the exception surfaces and the user clarifies, the suspension
may resume at the user's discretion for the remaining work.

**Anti-pattern guard:** The phrase "Auto-mode active. Executing." (or
equivalent) is the marker of default-mode Gate 1 collapse, where the
agent uses auto mode as justification for skipping the pause without
explicit user suspension. The phrase itself is not the problem; using
it to skip pauses without an explicit suspension directive IS the
problem. Same guard shape as §8.2.1 ("No counter-evidence found"
without sources surveyed) and §21.2 / §21.3 anti-pattern guards.

**Cross-references:**

- **§8.4 Gate Scope:** the per-artifact gate cycle rule §8.9 reinforces.
- **§22 Protocol Violation Triage Response:** auto-mode-collapsed Gate
  1 that ships incorrect work is a §22 violation; the §22 stop-
  condition activates.
- **§2 Destructive Action Protocol** and **§2.1 Default-Branch
  Verification:** §8.9 explicitly does NOT extend suspension to these.
- **§19 / §21.3:** §8.9 explicitly does NOT extend suspension to
  testing requirements.
- **CLAUDE.md protocol-precedence rule:** DSM_0.2 §8 (including §8.9)
  takes precedence over Auto mode's general framing for gate behavior;
  Auto mode's speed hints apply within the gate discipline, not above
  it, unless the user has explicitly suspended via §8.9's opt-in
  mechanism.

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.9.1. Non-Suppressible Prompts Convention

§8.9 establishes that auto mode does NOT collapse Gate 1 pauses, Gate 3
destructive-action approvals, or §19/§21.3 testing requirements. But not
every safety prompt in DSM lives inside the four-gate model. Some prompts
exist inside skill files (`/dsm-go` Step 5.9 light-wrap-up continuation,
§2a.6 default-branch verification, §0.7 concurrent-session detection) and
function as procedural safety checks rather than gates. §8.9 in its
original form did not name these as auto-mode-protected; agents under
auto mode have rationalized skipping them ("user typed `/dsm-go`,
implied yes to the prompt") even when the prompt's entire purpose is to
interrupt and ask. §8.9.1 closes this gap with a prompt classification
that auto mode must honor regardless of explicit suspension.

**Convention name:** "non-suppressible prompts." A prompt classified as
non-suppressible MUST be displayed and MUST receive an explicit user
response before the agent proceeds, regardless of:

- Default auto mode behavior
- Explicit auto-mode suspension via §8.9 ("skip the Gate 1 pauses for
  this work" or equivalent)
- Whether the agent infers the user's likely answer from context
- Whether the user's earlier directive seems to imply a default
- Whether the prompt fires inside a Gate 1/2/3 cycle or outside it

**Initial scope (skill steps that classify as non-suppressible):**

1. `/dsm-go` Step 0.7 (concurrent-session detection halt, per BL-431
   and DSM_0.2.A §26)
2. `/dsm-go` Step 2a.6 (default-branch verification hard-halt, per
   DSM_0.2.A's session-start checks)
3. `/dsm-go` Step 5.9 (light-wrap-up continuation prompt, "Switch to
   /dsm-light-go for a faster resume?")
4. Any future `/dsm-go` step or skill where the user's choice changes
   the agent's destination skill or alters the agent's branch /
   filesystem trajectory
5. The High-Token-Cost Action Gate (§8.9.2). Its consent prompt is
   non-suppressible by the same logic: skipping it removes a choice the
   user cannot make for themselves, since only the agent knows the shape
   of the fan-out it is about to launch

**Auto-mode obligation:**

Under default auto mode behavior (§8.9 default), non-suppressible
prompts are honored exactly as in non-auto mode. Under explicit
auto-mode suspension (§8.9 explicit suspension), non-suppressible
prompts are STILL honored. The user's explicit suspension does NOT
extend to non-suppressible prompts. This is the core protection §8.9.1
adds: explicit suspension is a Gate 1/2 friction lever, never a
prompt-class override.

**Skill file annotation convention:**

Skill files that contain non-suppressible prompts MUST tag the relevant
step with a clear marker directly above the prompt text:

```markdown
**Non-suppressible (per DSM_0.2 §8.9.1):**
```

Agents reading the skill file at runtime see the tag and honor it. The
tag is not a hook-enforced mechanism; it is a documented convention
that the agent must read as authoritative.

**Anti-pattern guard:**

"User implied yes by typing `/dsm-go`" is the exact rationalization
§8.9.1 forbids. Variants of the same defect:

- "User clearly wants to continue the work, the prompt is rhetorical"
- "Auto mode means I should infer rather than ask"
- "The prompt is informational only at this stage of the session"
- "The user's earlier directive covered this case"

All of the above are §8.9.1 violations when applied to a non-suppressible
prompt. Same guard family as §8.2.1 ("No counter-evidence found"
without sources surveyed), §21.2 ("Risks: none known"), §21.3 ("all
tests passed"), §8.9 ("Auto-mode active. Executing.").

**Detection mechanism:**

§8.9.1 is prose-only and convention-driven; no hook enforces it. The
defense-in-depth posture matches §8.9, §21.2, §21.3: the rule + the
user's redirect window are the enforcement until a future BL adds
hook-based detection. The skill annotation convention is the
discoverability mechanism (the tag IS visible to any agent reading the
skill file, so the omission case becomes a §22 self-detection trigger).

**Cross-references:**

- §8.9 (parent: auto-mode boundaries; default behavior + explicit
  suspension)
- §8.4 (each artifact gets its own gate cycle)
- §22 (Protocol Violation Triage Response when §8.9.1 is violated)
- BL-431 / DSM_0.2.A §26 (Step 0.7 lockfile halt is the first
  non-suppressible-tagged step)
- §2.1 Default-Branch Verification (Step 2a.6 is non-suppressible by
  hard-halt design; §8.9.1 promotes it to tagged status for
  consistency)
- DSM_0.2.A §A.5.9 (the §5.9 light-wrap-up continuation prompt that
  motivated this rule)

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.9.2. High-Token-Cost Action Gate

§8.9.1 protects prompts whose suppression would take a choice away from the
user. This section covers a different loss of choice: an action the user
authorized without being told what it would cost. Some actions consume a large
share of a shared, finite, time-boxed token budget, and when that budget runs
out mid-run the harness stops, leaving in-flight work truncated. Consent given
without a cost figure is not informed consent, and the user cannot supply the
figure because only the agent knows the shape of the fan-out it is about to
launch.

**Gate name:** "high-token-cost actions." Before launching one, the agent MUST
present the consent contract below and obtain an explicit acceptance.

**Trigger set (positive definition):** the gate fires when a single invocation
spawns **many independent full-LLM calls drawing on a shared, finite rate-limit
pool**. "Shared" means shared among the fan-out's own calls; it does not mean
shared with the main thread. Concretely:

1. Multi-agent orchestration of any kind (a `Workflow`, a fan-out of subagents,
   a parallel sweep) where one call becomes N model calls.
2. Harnesses that fan out internally, whether or not the fan-out is visible in
   the invocation. A research harness that scopes, searches, fetches, verifies,
   and synthesizes is one call to the user and hundreds of calls to the pool.
3. A **repeat** fan-out within the same session. The pool is shared and already
   partly spent, so the second fan-out carries a higher risk than the first even
   when it is identical in size. Re-prompt; do not treat the first acceptance as
   standing.

**Gated subagents do not delegate further, by default.** Consent priced on N
agents must not run 2N. An agent spawned inside a gated fan-out has **no
delegation authority** unless the accepted prompt granted it explicitly, so a
subagent that wants to fan out must return and let the main agent seek fresh
consent. Where delegation IS granted, disclosure 1 states the **bound on total
agents**, not the first-level count.

This is a default rather than a sixth disclosure on purpose. A sixth line would
appear in every prompt including the many where the answer is trivially no, and
a prompt that grows a line nobody reads is the ritualism shape §8.7's skip
condition and §10.1's compliance guard both exist to prevent. The default costs
nothing in the common case and fails safe in the rare one.

**Moving subagents to a cheaper tier reduces the cost; it does not exit the
trigger.** The mitigations below recommend exactly that, and on a plan whose
cheaper tier has its own separate weekly limit, a literal reading of an
earlier wording ("the same rate-limit pool") took the recommended configuration
*out* of the gate. A hundred subagents contending for one finite weekly budget
is the trigger whether or not the main thread draws on that budget too;
exhausting the cheaper pool stops the work exactly as hard.

**Over-firing guard (what the gate must NOT fire on):** ordinary single-agent
tool calls, file reads of any size, long-running commands, large diffs, and
expensive-looking work that is nonetheless one model doing one thing. The
trigger is fan-out, not cost-in-the-abstract and not duration. A gate that fires
on ordinary work trains the user to accept reflexively, which leaves them worse
off than no gate at all, because a reflex-accepted gate still reads as
protection. Breadth of firing is the failure mode to guard, not narrowness.

**The consent contract (five required disclosures):** the prompt states, in
plain terms:

1. **What the action does structurally**, in fan-out terms, e.g. "spawns roughly
   110 subagents, each a full model call, many carrying fetched web pages."
2. **An order-of-magnitude token estimate**, e.g. "on the order of 1-2M tokens."
   State it as an estimate and do not manufacture precision the agent does not
   have. A confidently wrong low figure under-warns and reproduces the failure
   this gate exists to prevent.
3. **The model tier** the fan-out will run on, since tier drives cost as much as
   count.
4. **The rolling-window risk, categorically:** that this may consume a large
   share of the usage window, and that exhausting it forces a hard stop which
   can truncate in-flight work. This statement holds regardless of estimate
   accuracy, which is why it is separate from disclosure 2.
5. **Cheaper alternatives as first-class options**, not as a footnote: a
   narrower scope, fewer agents, a cheaper tier for subagents, or doing the work
   on-thread.

**Subscription awareness.** Where `~/.claude/claude-subscription.md` exists, read
it and sharpen disclosure 4 with the actual pool structure and reset cadence.
Where it does not, the categorical warning still fires; the file sharpens the
numbers, it is not a precondition for the gate.

**Non-suppressible classification.** This gate is a non-suppressible prompt per
§8.9.1. Auto mode does not bypass it, and an explicit §8.9 suspension does not
extend to it. A general "proceed" on a Gate 1 brief does not clear it either;
the acceptance must follow the estimate.

**Supporting mitigations (recommended defaults, not blocking):**

- Default fan-out subagents to a cheaper tier and reserve the expensive tier for
  explicit opt-in. Most search, fetch, and verify subtasks do not need the top
  tier.
- Track approximate cumulative spend within a session and say so before a second
  fan-out ("the first pass used roughly 2M tokens; a second risks the window").
- Offer a smaller default agent count and escalate on request rather than
  starting wide.
- Keep large reference dumps out of the main thread; prefer summarized loads to
  reading full multi-tens-of-K tool outputs into context.

**Relationship to §8.8 (Parallel Offload Analysis).** These are two gates on
adjacent surfaces and they do not duplicate each other:

| | §8.8 | §8.9.2 |
|---|---|---|
| Question answered | *Whether* to delegate this sub-task | *What* the fan-out will cost |
| Initiated by | The agent, inside a Gate 1 brief | Any path, including a user-invoked harness |
| Content | Net savings, risk, per-task approval | The five cost disclosures |

When a fan-out is proposed inside a Gate 1 brief, satisfy both in one prompt:
the §8.8 per-task recommendation carries the §8.9.2 disclosures alongside it,
and a single explicit acceptance clears both. Do not prompt twice for the same
launch. When a fan-out originates outside a Gate 1 brief, §8.9.2 fires alone.

**Anti-pattern guard:** "The user asked for deep research, so they accepted the
cost" is the exact rationalization this section forbids. Variants of the same
defect:

- "They have used this harness before, they know what it costs"
- "I cannot estimate the token count precisely, so stating nothing is more honest"
- "Surfacing cost would be nagging about something they already decided"
- "The first pass was approved, so the second is covered"
- "The first-level count is what I disclosed" (the agents those agents spawn are the same pool)
- "The subagents are on the cheaper tier, so this is not the same pool"

All are §8.9.2 violations. Same guard family as §8.9.1 ("User implied yes by
typing `/dsm-go`"), §8.2.1 ("No counter-evidence found" without sources
surveyed), §21.2 ("Risks: none known"), §21.3 ("all tests passed").

**Detection mechanism:** prose and convention only; no hook enforces this. The
rule plus the user's redirect window are the enforcement, matching the posture
of §8.9, §8.9.1, §21.2, and §21.3.

**Cross-references:**

- §8.9.1 (sibling: non-suppressible prompts; this gate is one)
- §8.8 (Parallel Offload Analysis; interaction table above)
- §8.9 (parent: auto-mode boundaries)
- Module A §14 (Session Configuration Recommendation; session-level cost posture)
- §22 (Protocol Violation Triage Response when this gate is skipped)

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).


### 8.10. Chunked Drafting Protocol for Structured Documents

The four-gate Pre-Generation Brief Protocol (§8.0-§8.3) is well-understood
as chunked for code (function-by-function, diff review between units) and
for Jupyter notebooks (cell-by-cell, the artifact format itself enforces
chunking). For structured prose documents (project plans, proposals,
deliverables, reports, research papers, blog posts), §8 was historically
silent on chunking. The agent's default reading of "produce the artifact
at Gate 3" collapses for prose to "produce the whole document at Gate 3,"
yielding 2000-3500 word full-file Write operations that defeat per-section
review and the Take a Bite philosophy. §8.10 closes that gap by
operationalizing the four-gate model for prose deliverables.

**Trigger:** the protocol activates when the agent generates a structured
document deliverable. Trigger is document type, NOT length: a short
proposal still uses the protocol. Document types in scope:

- Project plans, sprint plans, phase plans
- Proposals (technical, business, hiring-challenge deliverables)
- Reports (research, post-mortem, retrospective)
- Research papers and substantial research files (`dsm-docs/research/*.md` over ~500 words)
- Blog posts and external-facing prose
- Any prose deliverable intended for human review and downstream consumption

Trigger does NOT apply to:

- Short-form text (email drafts, README sections under ~300 words, code comments)
- Backlog items (BL files use a structured template; their generation is template fill-in, not free-form prose)
- Methodology document amendments (DSM_0 through DSM_6.1 modifications, which are protocol prose; their gating happens at the BL level, not at the section level)
- Test Execution Logs and similar checklists (their chunked structure is implicit in their bullet format)

**Gate 1 — Definition.** Confirm with the user before any drafting:

1. Document purpose (what is it for?)
2. Audience (who reads it?)
3. Outcome (what should the document produce or enable?)
4. Length budget (target word count or page count)
5. In/out of scope (which topics belong; which don't)

User signs off on the definition before Gate 2. This makes the existing
collaborative-definition gate (§8.0) explicit for prose; agents must not
skip it on the assumption "the deliverable is obvious from context."

**Gate 2 — Table of Contents.** Propose a high-level structure:

1. Chapters or major sections (h1 or h2 level)
2. Sub-chapters or sub-sections (h3 level), if warranted by the document's
   length and complexity
3. Each section title carries a one-line description of its content
4. Each section title carries an approximate length budget (half-page,
   one-page, two-page; or word-count target)

User reviews and signs off on the TOC. Reordering, merging, splitting,
adding, or dropping sections happens here, BEFORE any prose is drafted.
This is the existing concept gate (§8.1) made specific to document
structure rather than abstract concept approval.

**Gate 3 — Chunked drafting.** The agent drafts ONE subchapter at a time,
in TOC order. The bite is flexible: a whole subchapter when it is short
(roughly 200-300 words), or a single paragraph when the subchapter is
long (a long subchapter is delivered as several paragraph-bites). After
each bite:

1. The user reviews the content in real time
2. The user flags errors, requests revisions, or approves
3. The agent proceeds to the NEXT bite ONLY after the current one is
   approved

**File-first editable delivery.** Each bite is written to an editable
draft file (the deliverable's own path, or a clearly-temporary draft
path), NOT pasted as a conversation block. The conversation is not
user-editable, so a draft delivered there cannot be edited in place; a
draft in a file can. The user reviews and edits the bite in the file,
and the agent waits before the next bite. This mirrors the Notebook
Collaboration Protocol (one cell at a time; the user returns review
before the next).

The user (NOT the agent) sets the bite granularity; if the agent is
unsure whether a subchapter should be drafted whole or split into
paragraph-bites, it asks: "Should I draft subchapter X whole, or
paragraph by paragraph?" File-first delivery means INCREMENTAL per-bite
writes to the draft file; it does NOT permit full-file generation.
Producing the whole document in one write remains the prohibited
anti-pattern (below); the file is built bite by bite, and the
cross-section consistency pass happens at Gate 4.

**Gate 4 — Run / Final Assembly.** Full-document review for cross-section
consistency:

1. Tone, vocabulary, and voice consistency
2. Repetition or redundancy across sections, applying the Present Once, Then
   Deepen writing discipline (stated in full below this list): each concept,
   metric, or claim appears in exactly one place, strip facts the summary and
   body state twice. When the document also needs a humanizer pass, run this
   repetition refactor first and the humanizer second, never the reverse (the
   reverse order wastes humanizer effort on prose about to be cut, and
   repetition is not an AI tell the humanizer catches)
3. Structural balance (no over-long or under-developed sections)
4. References between sections that need reconciling now that the whole
   document exists
5. Format conversion (PDF, DOCX, slide deck) happens at this stage, NOT
   before

User signs off on the assembled document before any external delivery
(email, submission, publication, PR, commit to a public-facing file).

**Present Once, Then Deepen (writing discipline).** The Gate 4 cross-section
repetition check applies a self-contained writing discipline: present each
concept, metric, or claim in exactly one place and develop it where it carries
the most weight. In structured prose with a summary-then-body shape, the default
failure mode is to state a fact in the summary and restate it verbatim in the
body, so the reader meets the same concept twice with no added depth and the
prose reads as padded. The summary names what the body will deepen, or the body
deepens what the summary named; neither echoes the other. Two facets follow from
the same information-architecture instinct:

- **Descriptive phrase before acronym.** In an introduction, lead with the
  phrase that carries meaning and let the acronym or brand name attach second
  ("a Deliberate Systematic Methodology" before "DSM"). An acronym is a
  repeated-reference shorthand within a document, not the primary handle for a
  first encounter.
- **Refactor before humanize.** When a deliverable needs both a no-repetition
  refactor and a humanizer pass, run the repetition refactor first and the
  humanizer second. The reverse wastes humanizer effort on prose about to be
  cut, and leaves duplicated facts in place because repetition is not an AI tell
  the humanizer catches.

**Scope:** structured prose with a summary + body shape (project plans,
proposals, reports, CVs and cover letters, public-facing copy, research files).
The trigger is the summary-precedes-detail shape, not document length; a short
proposal still qualifies. **Out of scope:** short-form text, reference tables,
code, and checklists, where repetition is often structural rather than padding.

**Anti-pattern guard:**

The failure mode this rule prevents is "Gate 2 outline approved → full-
file Write at Gate 3." Variants of the same defect:

- "The structure is clear, I'll just generate the whole thing"
- "User approved the outline, that approval covers the prose"
- "Section dependencies make chunking awkward, full-file is cleaner"
- "Auto mode means I should fill in the prose without per-section pause"

All four are §8.10 violations. Same guard family as §8.2.1 ("No counter-
evidence found" without sources surveyed), §21.2 ("Risks: none known"),
§21.3 ("all tests passed"), §8.6.1 ("silence from the skill is the
skill's answer"), §8.9 ("Auto-mode active. Executing.").

**Cross-references:**

- §8 (parent: four-gate Pre-Generation Brief Protocol)
- §8.0 / §8.1 / §8.2 / §8.3 (the four gates §8.10 specializes for prose)
- §8.4 (each artifact gets its own gate cycle; for §8.10, each
  subchapter or paragraph-bite is an artifact within Gate 3)
- §8.9 (auto-mode boundaries; auto mode does NOT compress per-section
  pauses, same logic as Gate 1 / Gate 3 carve-outs)
- DSM_0.2 §15 (AI Collaboration Principles, "Take a Bite")
- DSM_6.0 §1.4.2 Critical Thinking (preserves user inquiry surface across
  the whole document; full-file generation collapses inquiry into
  ship-or-no-ship)

**Origin:** see [DSM_0.2.E_Provenance.md](DSM_0.2.E_Provenance.md).
