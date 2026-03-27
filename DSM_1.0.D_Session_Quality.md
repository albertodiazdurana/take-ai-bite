# DSM 1.0 Module D: Session and Quality Management

**Parent document:** `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Module scope:** Section 6 (Session Management, Quality Assurance, Troubleshooting, Checkpoint/Feedback, Gateway Review)

---

# 6. Session & Quality Management

## 6.1. Session Management

### 6.1.1. Token Monitoring

**Why It Matters:**
- The agent has conversation length limits (~190K tokens)
- Long sessions degrade context quality
- Important to plan handoffs before hitting limits

**Monitoring Guidelines:**
- Check token usage periodically
- Alert at 90% capacity (~171K tokens)
- Plan handoff at 95% capacity (~180K tokens)
- Don't wait until 100% – context gets truncated

**How to Monitor:**
- Ask the agent: "What's our current token usage?"
- The agent will report: "Currently X/190K tokens (Y% used)"
- Plan accordingly

### 6.1.2. Session Handoff Templates

**When to Create Handoff:**
- Approaching token limit (90-95%)
- End of work session (even if tokens remaining)
- Major phase transition
- Before pivoting direction

**Handoff Document Template:**
```markdown
# Session Handoff - [Project Name]

**Date:** YYYY-MM-DD
**Session:** [Number/Description]
**Token Usage:** [X/190K tokens (Y% used)]
**DSM Version:** [e.g., v1.3.7]

## Current Status
- **Phase:** [Current phase]
- **Last Completed:** [What was just finished]
- **In Progress:** [What's partially done]
- **Next Steps:** [Clear next actions]

## Key Decisions Made
- [Decision reference: DEC-ID]
- [Decision reference: DEC-ID]
- [Brief summary if needed]

## Files Created/Modified
- [List of files with brief description]
- [Include file paths]

## Important Context
- [Any crucial information for next session]
- [Open questions]
- [Blockers or concerns]

## Next Session Prompt
[Exact prompt to start next session efficiently]
"I'm continuing work on [project]. Last session we completed [X].
Next step is [Y]. Please review the handoff document in dsm-docs/handoffs/."
```

**Example Handoff Prompt:**
```
I'm continuing the [project name] project.
Last session we completed Phase 2 (feature engineering) and created N features.
Next step is Phase 3: analysis to answer the core business question.
Please review the session handoff in dsm-docs/handoffs/.
```

**Note:** Store handoffs in `dsm-docs/handoffs/` within the project repository. For same-date
sessions, append to the existing handoff file rather than creating a new one.

### 6.1.3. Continuity Best Practices

**Before Starting New Session:**
- Review previous session handoff in `dsm-docs/handoffs/`
- Review decision log for context
- Check what files were created
- Understand where we left off

**During Session:**
- Reference previous decisions by ID
- Build on previous work, don't restart
- Update decision log as new decisions made
- Track progress toward next handoff

**Ending Session:**
- Follow Section 6.1.5 Session Close-Out Protocol
- Create or update handoff document in `dsm-docs/handoffs/`
- Summarize key accomplishments
- Document any pending questions
- Provide clear next steps

### 6.1.4. Daily Documentation Protocol

**Purpose:**
Maintain project continuity and progress visibility through consistent documentation at notebook completion and end of each working day.

#### End of Notebook Checklist

**Before closing any notebook, verify:**

```markdown
## Notebook Completion Checklist

### Data Outputs
- [ ] All processed data saved to appropriate location
- [ ] File names follow naming convention (sYY_dXX_PHASE_description.pkl)
- [ ] Data shapes and key statistics printed for verification

### Code Quality
- [ ] All cells execute without errors (Kernel > Restart & Run All)
- [ ] No hardcoded paths (using constants from setup section)
- [ ] Temporary/debugging cells removed or marked

### Documentation
- [ ] Summary section completed with key findings
- [ ] Next steps clearly stated
- [ ] Any new decisions logged (DEC-XXX format)

### Validation
- [ ] Output data validated (shape, nulls, value ranges)
- [ ] Results make business sense
- [ ] Checkpoint saved if notebook > 200 lines
```

**Notebook Summary Cell Template (add as final cell):**
```python
# ============================================================
# NOTEBOOK SUMMARY
# ============================================================
#
# Completed: [Brief description of what was accomplished]
#
# Key Outputs:
# - [output_file_1.pkl]: [description] ([X] rows, [Y] columns)
# - [output_file_2.csv]: [description]
#
# Key Findings:
# - [Finding 1]
# - [Finding 2]
#
# Decisions Made:
# - DEC-XXX: [Brief description]
#
# Next Steps:
# - [Next notebook or task]
#
# ============================================================
```

#### Daily Checkpoint Template

**File:** `dsm-docs/checkpoints/sYY_dXX_checkpoint.md`

```markdown
# Daily Checkpoint - Sprint [Y] Day [X]

**Date:** YYYY-MM-DD
**Hours Worked:** [X]h
**Cumulative Sprint Hours:** [X]h

## Completed Today
- [ ] [Task 1 with notebook reference]
- [ ] [Task 2 with notebook reference]
- [ ] [Task 3 with notebook reference]

## Notebooks Created/Modified
| Notebook | Status | Key Output |
|----------|--------|------------|
| sYY_dXX_PHASE_description.ipynb | Complete | output_file.pkl |

## Decisions Made
- DEC-XXX: [Brief summary]

## Blockers/Issues
- [Issue 1 and resolution or status]
- None (if no blockers)

## Tomorrow's Priority
1. [First priority task]
2. [Second priority task]

## Notes
[Any context needed for continuity]
```

#### End of Day Summary

**Quick Protocol (5 minutes):**

1. **Save all work**
   - Ensure all notebooks saved
   - Commit to git if applicable

2. **Update checkpoint file**
   - Create/update `dsm-docs/checkpoints/sYY_dXX_checkpoint.md`
   - Mark completed items
   - Note any blockers

3. **Update decision log**
   - Add any new DEC-XXX entries
   - Update status of existing decisions if changed

4. **Prepare next day**
   - Identify first task for tomorrow
   - Note any questions to resolve

**When to Create Session Handoff Instead:**
- Approaching token limit (90%+)
- Won't continue same session tomorrow
- Major phase transition
- Need to share context with collaborator

### 6.1.5. Session Close-Out Protocol

**Purpose:** Standardize session endings to prevent data loss, maintain continuity,
and keep governance artifacts current.

**When to use:** At the end of every working session, whether hub (DSM Central) or
spoke (project) session.

**Universal Close-Out Checklist:**

1. **Commit all pending changes**
   - Stage modified files (`git add` specific files, not `-A`)
   - Commit with descriptive message referencing BACKLOG-### if applicable
   - Verify clean working tree (`git status`)

2. **Push to remote**
   - Ensure commits are pushed; local-only work is at risk of loss

3. **Create or update handoff document**
   - If session has complex pending work or spans multiple sessions on the same day,
     append to the existing date's handoff
   - Location: `dsm-docs/handoffs/` within the project repository
   - Use Section 6.1.2 handoff template

**Hub-Specific Close-Out (DSM Central):**

In addition to the universal checklist:

4. **Update session memory**
   - Update MEMORY.md (live) with session summary, key decisions, and pending work
   - Refresh repo backup: copy live MEMORY.md to `.claude/memory/MEMORY.md`

5. **Check contributor profile**
   - If new skills were exercised or proficiency levels changed, update
     `.claude/contributor-profile.md`

**Spoke-Specific Close-Out (Project Sessions):**

In addition to the universal checklist:

4. **Update feedback files** (if methodology observations were made)
   - `dsm-docs/feedback-to-dsm/methodology.md` and `dsm-docs/feedback-to-dsm/backlogs.md`

5. **Sprint boundary deliverables** (if at sprint end)
   - Checkpoint document, feedback files, decision log, blog entry, README update
   - Reference: PM Guidelines Template 8 Sprint Boundary Checklist

**Quick Reference:**
- "Wrap up" trigger: user says "wrap up" or session is ending
- Minimum: commit, push, handoff (steps 1-3)
- Full: all applicable steps for hub or spoke context

---

## 6.2. Quality Assurance

### 6.2.1. Phase Completion Checklists

**Phase 0 Checklist:**
- [ ] Virtual environment created and activated
- [ ] Base packages installed
- [ ] Jupyter kernel registered
- [ ] VS Code configuration complete
- [ ] First notebook created successfully
- [ ] Test imports functional

**Phase 1 Checklist:**
- [ ] Data quality assessment complete
- [ ] Cohort definition documented
- [ ] Missing data patterns understood
- [ ] Key distributions visualized
- [ ] Decision log updated
- [ ] Stakeholder update provided

**Phase 2 Checklist:**
- [ ] All features engineered
- [ ] Feature dictionary created
- [ ] No data leakage verified
- [ ] Distributions validated
- [ ] Feature dataset exported
- [ ] Decision log updated

**Phase 3 Checklist:**
- [ ] Model/analysis validated
- [ ] Results interpreted
- [ ] Limitations documented
- [ ] Decision log updated
- [ ] Ready for communication

**Phase 4 Checklist:**
- [ ] Notebooks consolidated
- [ ] Presentation created
- [ ] Technical report written
- [ ] Q&A document prepared
- [ ] All deliverables reviewed
- [ ] Stakeholders notified

### 6.2.2. Code Review Guidelines

**Self-Review Checklist:**
- [ ] All cells execute without errors
- [ ] Outputs are informative (not "Done!")
- [ ] No hard-coded paths
- [ ] Clear variable names
- [ ] Comments for complex logic
- [ ] Text conventions followed (WARNING/OK/ERROR)
- [ ] No emojis in code or markdown
- [ ] Proper file naming

**Peer Review Focus:**
- Logic correctness
- Reproducibility
- Clarity of explanations
- Assumption validity
- Edge case handling

### 6.2.3. Reproducibility Standards

**Required for Reproducibility:**
- [ ] Clear environment setup instructions
- [ ] requirements.txt or environment.yml
- [ ] All data files documented (location, version)
- [ ] Random seeds set for stochastic processes
- [ ] Clear execution order of notebooks
- [ ] No manual data edits (all programmatic)

**Testing Reproducibility:**
```bash
# Fresh environment test
python -m venv test_venv
test_venv\Scripts\activate
pip install -r requirements.txt

# Run all notebooks in order
jupyter execute 01_EDA_*.ipynb
jupyter execute 02_EDA_*.ipynb
# ... etc
```

### 6.2.4. Documentation Completeness Checks

**Project-Level Documentation:**
- [ ] README.md with project overview
- [ ] Decision log maintained
- [ ] Feature dictionary complete
- [ ] Data dictionary (if needed)
- [ ] Stakeholder communications archived

**Code-Level Documentation:**
- [ ] Notebook markdown cells explain logic
- [ ] Function docstrings present
- [ ] Complex calculations commented
- [ ] Assumptions documented

**Deliverable Documentation:**
- [ ] Executive summary standalone
- [ ] Technical report complete
- [ ] Q&A document comprehensive
- [ ] Presentation self-explanatory

### 6.2.5. Progressive Execution Standard (Cell-by-Cell Protocol)

**Jupyter Notebook Execution Best Practice:**

Execute notebooks progressively, validating output at each step rather than running all cells at once.

**Protocol:**
1. Execute one cell at a time
2. Read and validate output before proceeding
3. Request specific quantitative findings after major steps
4. Never skip validation to "save time" - errors compound

**Why This Matters:**
- Catches errors immediately (not at end of notebook)
- Builds confidence in results (verified at each step)
- Easier debugging (know exactly where issue occurred)
- Prevents cascading errors from bad intermediate outputs

**Output Validation Pattern:**

```python
# After each transformation
print(f"Shape: {df.shape}")  # NOT "Data loaded successfully!"
print(f"Missing: {df.isnull().sum().sum()}")
print(f"Date range: {df['date'].min()} to {df['date'].max()}")

# After each calculation
print(f"Correlation: {corr:.4f}")  # NOT "Correlation computed!"
print(f"Weekend lift: +{lift:.1f}%")  # NOT "Analysis complete!"

# After each merge
print(f"Rows before: {before_rows}, after: {after_rows}")  # NOT "Merge successful!"
print(f"Columns added: {new_cols}")
```

**Anti-Pattern:**
```python
# WRONG - No verification
df = df.merge(other_df, on='date')
# Proceed to next cell without checking merge result
```

**Correct Pattern:**
```python
# RIGHT - Immediate verification
before_rows = len(df)
df = df.merge(other_df, on='date', how='left')
after_rows = len(df)

print(f"Merge verification:")
print(f"  Rows: {before_rows} -> {after_rows}")
print(f"  Expected: {before_rows} (left join preserves)")
print(f"  Match: {'OK' if before_rows == after_rows else 'ERROR'}")
```

**Agent Collaboration:**
- Request quantitative findings after each code step
- Don't accept generic "Complete!" messages
- Ask for specific metrics to validate correctness

---

## 6.3. Troubleshooting

### 6.3.1. Common Issues by Phase

**Phase 0 Issues:**
- **Issue:** Virtual environment not recognized
- **Solution:** Verify VS Code Python interpreter path points to `.venv`
- **Issue:** Jupyter kernel not found
- **Solution:** Re-run kernel registration: `python -m ipykernel install --user --name=project_base_kernel`

**Phase 1 Issues:**
- **Issue:** Data loading fails
- **Solution:** Check file paths, verify file exists, check read permissions
- **Issue:** Unexpected data types
- **Solution:** Explicit type conversion, check source data format

**Phase 2 Issues:**
- **Issue:** Feature calculations produce NaN
- **Solution:** Check for division by zero, missing data in source
- **Issue:** Features don't align with expectations
- **Solution:** Validate sample calculations manually

**Phase 3 Issues:**
- **Issue:** Poor model performance
- **Solution:** Check feature distributions, try different approaches, revisit features
- **Issue:** Inconsistent validation results
- **Solution:** Set random seeds, check for data leakage

**Phase 4 Issues:**
- **Issue:** Stakeholders don't understand findings
- **Solution:** Simplify language, use analogies, focus on business impact
- **Issue:** Questions about methodology
- **Solution:** Reference decision log, provide technical appendix

### 6.3.2. Error Resolution Patterns

**Data-Related Errors:**
1. Check data shape and types
2. Validate sample of data manually
3. Look for nulls, zeros, infinities
4. Check data version matches expectations

**Code-Related Errors:**
1. Read error message carefully
2. Check recent changes (what worked before?)
3. Validate inputs to failing function
4. Simplify and isolate problem

**Conceptual Errors:**
1. Review assumptions
2. Validate approach with simpler example
3. Check literature/documentation
4. Consult with peers or stakeholders

### 6.3.3. When to Ask for Help

**Ask Immediately If:**
- Blocked for >2 hours without progress
- Data quality issue threatens project viability
- Stakeholder requirement conflicts with technical feasibility
- Ethical concerns emerge
- Deadline at risk

**Try First:**
- Google error message
- Check documentation
- Review similar examples
- Simplify problem

**Who to Ask:**
- Technical peers: Implementation questions
- Stakeholders: Business logic, requirements
- Domain experts: Interpretation, validity
- AI agent: Coding help, methodology questions

### 6.3.4. Debugging Strategies

**Systematic Debugging:**
```python
# 1. Print intermediate values
print(f"DEBUG: df shape before filter: {df.shape}")
filtered_df = df[df['value'] > 0]
print(f"DEBUG: df shape after filter: {filtered_df.shape}")

# 2. Check data types
print(f"DEBUG: column types:\n{df.dtypes}")

# 3. Validate sample
print(f"DEBUG: sample rows:\n{df.head(3)}")

# 4. Check for nulls/infinities
print(f"DEBUG: null counts:\n{df.isnull().sum()}")
print(f"DEBUG: inf counts: {np.isinf(df.select_dtypes(include=[np.number])).sum().sum()}")
```

**Isolation Testing:**
```python
# Test function with simple known input
def calculate_clv(transactions, revenue):
    return transactions * revenue

# Test with known values
test_transactions = 10
test_revenue = 100
result = calculate_clv(test_transactions, test_revenue)
print(f"DEBUG: Expected 1000, got {result}")
```

## 6.4. Checkpoint and Feedback Protocol

### 6.4.1. Milestone Checkpoints

After each significant milestone (sprint day, phase completion, major feature):

1. **Create checkpoint document** using PM Guidelines Template 5
2. **Document outputs** - Files created, code written, decisions made
3. **Record issues encountered** - What didn't work, workarounds used
4. **Note methodology gaps** - Did DSM guidance apply? What was missing?

**Checkpoint Triggers:**
- End of each sprint day
- Phase completion (Exploration, Feature Engineering, Analysis, Communication)
- Major feature implementation
- Before extended breaks (weekend, vacation)

**Intra-Sprint Checkpoints:**
For sprints with multiple phases, create a lightweight checkpoint at each phase
transition. This prevents retroactive documentation when a phase completes and
work moves on before the milestone is recorded. Use PM Guidelines Template 5
(abbreviated: outputs, decisions, next steps) rather than a full checkpoint.
Phase boundary items are listed in PM Guidelines Template 8.

### 6.4.2. Methodology Feedback Collection

Projects using DSM should maintain a **Validation Tracker** to systematically evaluate methodology effectiveness:

| Activity | Frequency | Purpose |
|----------|-----------|---------|
| Log DSM sections used | Per milestone | Track coverage |
| Score section effectiveness | After use | Quantify quality |
| Document gaps/successes | As discovered | Capture details |
| Propose improvements | End of sprint | Actionable feedback |

**Evaluation Criteria:**

| Criterion | Description | Scale |
|-----------|-------------|-------|
| Clarity | Was guidance clear and unambiguous? | 1-5 |
| Applicability | Did it fit project context? | 1-5 |
| Completeness | Was anything missing? | 1-5 |
| Efficiency | Time saved vs. ad-hoc approach? | 1-5 |

### 6.4.3. Feedback Loop

```
Project Uses DSM -> Checkpoints Created -> Feedback Collected ->
                                              |
                         +--------------------+--------------------+
                         |                                         |
              dsm-feedback-backlogs.md              dsm-feedback-methodology.md
              (Concrete improvement proposals)      (What was actually built)
                         |                                         |
              BACKLOG items created                  DSM informed of real-world
              DSM updated                            patterns and techniques
                         |                                         |
                         +--------------------+--------------------+
                                              |
                                Future Projects Benefit
```

This creates continuous methodology improvement through real-world validation.

**Key Insight:** Projects using DSM are the best source of methodology feedback, but only if feedback is captured systematically through both deliverables (Section 6.4.5).

### 6.4.4. Daily Checkpoint Template Addition

Add to each daily checkpoint (PM Guidelines Template 5):

```markdown
## Methodology Notes (Optional)

**DSM Sections Used Today:**
- Section X.Y: [Brief assessment]

**Gaps Identified:**
- [Description of any missing guidance]

**Feedback Logged:**
- [ ] Added to Validation Tracker (if applicable)
```

See **Appendix E.12** for the complete Validation Tracker Template.

### 6.4.5. Project Feedback Deliverables

At project start, create two feedback files in `dsm-docs/feedback-to-dsm/`. These files
are maintained throughout execution and finalized at project completion. The
methodology file integrates section-level scoring (previously in the standalone
Validation Tracker, Appendix E.12) directly into the feedback system.

**Required Feedback Files:**

| File | Purpose | When Created |
|------|---------|-------------|
| `dsm-docs/feedback-to-dsm/backlogs.md` | Concrete improvement proposals for DSM | Collected during execution, finalized at project end |
| `dsm-docs/feedback-to-dsm/methodology.md` | DSM usage log with per-section scores and project record | Updated at sprint boundaries, finalized at project end |

**Blog deliverables** (materials, drafts, publication notes) live in `dsm-docs/blog/`,
not in `dsm-docs/feedback-to-dsm/`. Blog output is a project deliverable, not DSM methodology
feedback. See Section 2.5.6 for the blog process and DSM_0.1 for file naming.

#### File 1: backlogs.md

Captures specific, actionable improvement proposals that become BACKLOG items
in the DSM repository. These are not limited to the project's domain -- they
include any observation about DSM gaps, unclear guidance, or missing patterns
encountered during the project.

**Template:**

```markdown
# DSM Feedback: Backlog Proposals

**Project:** [Project Name]
**DSM Version Used:** [e.g., v1.3.9]
**Author:** [Name]
**Date:** [YYYY-MM-DD]

---

## High Priority

### [Short Title]
- **DSM Section:** [Section reference or "New"]
- **Problem:** [What was missing or unclear]
- **Proposed Solution:** [Concrete suggestion]
- **Evidence:** [What happened in the project that exposed this gap]

---

## Medium Priority

### [Short Title]
[Same format]

---

## Low Priority

### [Short Title]
[Same format]
```

**Scope:** Any DSM improvement -- not limited to the project's domain (e.g., an
NLP project may identify gaps in environment setup, notebook standards, or
communication templates).

#### File 2: methodology.md

Records DSM section usage with effectiveness scores (integrating the Validation
Tracker from Appendix E.12) and the actual technical pipeline. This serves three
purposes: (1) tracking which DSM sections worked well or poorly during execution,
(2) project documentation for future reference, and (3) informing DSM of
real-world patterns that may not yet exist in the methodology.

**Section scoring (maintained during execution):**

When referencing a DSM section, log it with a score:

| DSM Section | Sprint/Day | Score (1-5) | Notes |
|-------------|------------|-------------|-------|
| Section 2.1 | S1 Setup | 4.5 | Clear checklist, minor gaps |
| Section 2.2 | S1D1-3 | 4.0 | Missing X pattern |

Scoring: 5=Excellent, 4=Good, 3=Adequate, 2=Poor, 1=Not useful.

**Project record (finalized at completion):**

Records the actual pipeline, tools, and decisions.

**Template:**

```markdown
# DSM Feedback: Final Project Methodology

**Project:** [Project Name]
**Author:** [Name]
**Date:** [YYYY-MM-DD]
**Duration:** [Timeline]

---

## 1. Project Overview

| Item | Planned | Actual |
|------|---------|--------|
| **Objective** | [Goal] | [What was delivered] |
| **Dataset** | [Source, size] | [Actual data used] |
| **Timeline** | [Plan] | [Reality] |
| **Deliverables** | [Expected] | [Actual] |

---

## 2. Technical Pipeline (What Was Actually Built)

[Document each phase with: tools used, parameters chosen, results obtained]

---

## 3. Libraries & Tools

| Library | Version | Purpose |
|---------|---------|---------|
| [name] | [ver] | [why used] |

---

## 4. Final Results

[Summary table of outcomes]

---

## 5. Project Structure (Final)

[Directory tree of final project state]

---

## 6. Plan vs Reality

| Aspect | Planned | Actual | Delta |
|--------|---------|--------|-------|
| [item] | [plan] | [reality] | [difference and why] |

---

## 7. Methodology Observations for DSM

[Patterns, techniques, or approaches used that DSM could learn from]
```

**Key distinction:** This file is informational with improvement potential.
Unlike the backlogs file (which contains direct action items), the methodology
file documents what worked in practice. DSM maintainers review these to identify
patterns worth incorporating -- especially techniques, libraries, or workflows
not yet covered in DSM.

#### Relationship Between Feedback Files

```
During Execution          At Sprint Boundaries    In DSM Repository
-----------------         --------------------    -----------------
DSM section used     -->  methodology.md     -->  Scores inform DSM
  (log with score)          (scores + record)       section improvements
Gap/issue found      -->  backlogs.md        -->  BACKLOG items created
                           (proposals)
```

Both files live in `dsm-docs/feedback-to-dsm/` and are updated at sprint boundaries
(per the Sprint Boundary Checklist in PM Guidelines Template 8).

The backlogs file generates immediate action. The methodology file (with
integrated section scoring) tracks DSM effectiveness and builds a knowledge base.

Blog materials and drafts are tracked separately in `dsm-docs/blog/` as project
deliverables (see Section 2.5.6).

**Note:** The standalone Validation Tracker (Appendix E.12) has been integrated
into `methodology.md`. Projects no longer need a separate tracker file.

#### Feedback Handover to DSM

At project completion, hand off feedback files to a DSM Central session for
integration. Use the standardized handover prompt in DSM_3 Section 6.1 to
trigger the review process.

**Handover sequence:**
1. Verify feedback files are complete (methodology scored, backlogs structured)
2. Open a DSM Central session
3. Use the handover prompt template with project-specific stats
4. DSM triages proposals: accept (create BACKLOG-XXX), reject, or defer
5. Methodology scores below 3 are assessed for DSM improvements

Cross-reference: DSM_3 Section 6 (Feedback Handover), `/dsm-review-feedback`
command

### 6.4.6. Documentation Audit

Before marking a project as finalized, verify documentation completeness. This
step catches gaps that incremental documentation misses.

**Audit Checklist:**

| Document | Check |
|----------|-------|
| Notebook | All cells run in order, outputs present, markdown explanations complete |
| README | Project description, setup instructions, results summary, references |
| Checkpoints | One per day/phase, no gaps in coverage |
| DSM feedback files | Entries for all days, final closure section present |
| Blog post (if applicable) | Drafted, reviewed, citations verified |
| Outputs | All figures saved, model artifacts documented |
| Plan vs Reality | Documented in methodology feedback |

**When to Audit:**
- At project closure (after final presentation or delivery)
- Before publishing any deliverable externally (blog, report)
- Before archiving the project

**Audit Process:**
1. List all expected deliverables from the project plan
2. Check each deliverable exists and is complete
3. Identify gaps and fill them
4. Record audit completion in the final checkpoint

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), Section 2.5.8
(Blog Post as Standard Deliverable)

## 6.5. Gateway Review Protocol

### 6.5.1. Purpose

Gateway reviews provide bidirectional feedback between the central DSM methodology
and consuming projects. While Section 6.4 covers project-to-DSM feedback (bottom-up),
gateway reviews add methodology-to-project guidance (top-down): reviewing project
state against DSM standards and providing alignment recommendations.

**Architecture:** Hub-and-Spoke model where DSM is the hub (methodology authority)
and projects are spokes. Gateway reviews are the connections.

See `dsm-docs/research/2026-02-01_multi-agent-governance-research.md` for the full research
grounding (multi-agent coordination, organizational learning theory, stage-gate
processes).

### 6.5.2. Three Gateway Levels

**Hub Kickoff Gate (pre-Gateway 1):**
If the project was initiated by DSM Central (hub-to-spoke), verify that the hub
completed the scaffolding checklist (DSM_3 Section 6.2.2) before proceeding to
Gateway 1. This pre-check ensures the spoke inherits correct structure, reducing
Gateway 1 failures from missing scaffolding.

**Gateway 1: Project Setup Complete** (before any code/analysis)

| Check | Criterion |
|-------|-----------|
| CLAUDE.md | Created with `@` reference to DSM_0.2_Custom_Instructions_v1.1.md |
| Project type | Identified (Notebook/Application/Hybrid) |
| Directory structure | Follows DSM pattern for project type (see DSM_0 Section 3) |
| Environment | Virtual environment with dependencies documented |
| Feedback files | Two files initialized in `dsm-docs/feedback-to-dsm/` (backlogs.md, methodology.md) |
| Decision log | Initialized |
| Sprint plan | Created (with Phase 0.5 research if applicable) |

**Gateway 2: Sprint/Phase Boundary**

| Check | Criterion |
|-------|-----------|
| Deliverables | Phase deliverables meet Definition of Done |
| Decision log | Updated with sprint decisions |
| Feedback files | Updated with observations and section scores |
| Checkpoint | Document created in `dsm-docs/checkpoints/` |
| Deviations | No methodology deviations without documented rationale |
| Tests | Passing (DSM 4.0 projects) |
| Blog | Journal entry written for sprint |

**Gateway 3: Project Delivery**

| Check | Criterion |
|-------|-----------|
| Prior gateways | All previous gateways passed |
| Feedback files | Finalized (backlogs, methodology with scores) |
| Communication | Blog/communication deliverable complete |
| Cross-project | Observations documented with cross-project relevance noted |
| BACKLOG items | Generated for DSM improvements |
| After Action Review | Completed (what was planned vs actual, lessons learned) |

### 6.5.3. Gateway Review Process

1. **Project reaches milestone** and triggers review (self-triggered at boundary)
2. **Review against checklist** for the appropriate gateway level
3. **Produce alignment report** with:
   - Items met (confirmed)
   - Items missing or incomplete (recommendations)
   - Cross-project observations (relevant learning from other projects, if available)
   - Deviations noted (with or without documented rationale)
4. **Project addresses feedback** or documents rationale for deviation
5. **Gateway passed** when critical items met (non-critical items tracked)

**Key principle:** Gateways produce recommendations, not blockers. Projects retain
autonomy within guardrails. The governance model is facilitative rather than
directive.

### 6.5.4. Cross-Project Learning

When multiple projects use DSM concurrently, gateway reviews enable knowledge
transfer:

1. **Observation tagging:** Projects tag feedback items with "Cross-Project
   Relevance: Yes/No" to flag observations that may benefit other projects
2. **Aggregation:** At sprint boundaries, aggregate tagged observations across
   projects to identify patterns
3. **Distribution:** Include relevant cross-project observations in gateway
   alignment reports for other projects

### 6.5.5. Anti-Patterns to Avoid

| Anti-Pattern | Risk | Mitigation |
|-------------|------|------------|
| Compliance Theater | Gates become checkbox exercises | Focus on "does this help?" not "is this complete?" |
| Central Bottleneck | Projects blocked waiting for review | Asynchronous reviews; automate what possible |
| Over-Governance | Excessive controls slow projects | "Pull" not "push"; projects opt in to guidance |
| Stale Standards | Methodology falls behind practice | Fast feedback loops; projects can deviate with rationale |
| Lost Learning | Observations captured but never acted on | Schedule aggregation cycles at sprint boundaries |

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), PM Guidelines
Template 8 (Sprint Plan with Cadence Guidance)

### 6.5.6. DSM as Central Project Hub

DSM Central serves a dual role in the ecosystem:

**Role 1: Methodology Framework** - How to execute data science and software projects (Sections 2-5, DSM 4.0).

**Role 2: Project Planning Hub** - Where new projects are defined, planned, and tracked to ensure DSM alignment from inception.

**How it works:**
1. New project ideas are captured as backlog items in `plan/backlog/developments/`
2. The backlog item defines scope, architecture, and DSM alignment
3. A dedicated repository is created with `.claude/CLAUDE.md` referencing DSM Central
4. The project follows DSM methodology, contributing feedback via Gateway Reviews

**Backlog classification** (see PM Guidelines, Project Change Tracking):
- `developments/` - External project definitions (repositories that follow DSM)
- `improvements/` - Internal DSM enhancements (new sections, templates, standards)

**Hub-and-Spoke Ecosystem:**

```
                    +---------------------------+
                    |     DSM Central (Hub)     |
                    |  Methodology + Project Hub|
                    +-----------+---------------+
                                |
            +-------------------+-------------------+
            |                   |                   |
    +-------v-------+   +-------v-------+   +-------v-------+
    | Development   |   | Development   |   | Development   |
    | Projects      |   | Projects      |   | Projects      |
    | (DSM 4.0)     |   | (DSM 1.0)     |   | (Hybrid)      |
    +-------+-------+   +-------+-------+   +-------+-------+
            |                   |                   |
            +-------------------+-------------------+
                                |
                    +-----------v-----------+
                    |  Feedback to DSM      |
                    |  Gateway Review (6.5) |
                    +-----------------------+
```
