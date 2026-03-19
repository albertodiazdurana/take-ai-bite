# Project Management Guidelines for Data Science Projects

---

**Note:** For production/enterprise projects requiring governance, quality assurance, and risk management, reference **2.1_PM_ProdGuidelines_extension.md**

## Purpose

This document provides a standardized framework for planning, executing, and documenting data science projects.  
It ensures consistency, efficiency, and clarity across all phases â€” from data preparation to modeling and deployment.

**Objective:** Establish a clear, time-bound, and reproducible plan that delivers measurable outcomes aligned with business goals.

---

## Project Structure Overview

Each project plan should include the following core sections:

1. **Purpose**
   - Define the projectâ€™s main objective and deliverable.
   - Describe the expected impact or business value.
   - Specify available resources and time allocation.

2. **Inputs & Dependencies**
   - List all input datasets and their key characteristics (record count, features, source).
   - Reference outputs or dependencies from prior project phases.
   - Document data quality assumptions and preprocessing status.

### Technical Prerequisites

Before beginning Phase 1 work:

**Environment Setup:**
Run base environment setup script:
- Academic/exploratory: `scripts/setup_base_environment_minimal.py`
- Production/team: `scripts/setup_base_environment_prod.py`

**Environment Requirements:**
- Python virtual environment (`.venv`)
- Base packages installed (see Methodology Section 2.1 (Phase 0: Environment Setup))
- Jupyter kernel registered and functional
- VS Code configured with required extensions

**Note:** Minimal setup recommended for academic work (no formatting/linting).
See Collaboration Methodology Section 2.1 (Phase 0: Environment Setup) for details.

**Verification:**
- [ ] `requirements_base.txt` generated
- [ ] All base packages import successfully
- [ ] Jupyter kernel selectable in VS Code
- [ ] Code formatting and linting active

**Reference:** See Collaboration Methodology Section 2.1 (Phase 0: Environment Setup): Environment Setup for complete instructions.

3. **Execution Timeline**
   - Break the project into daily or sprint milestones.
   - Define key focus areas and deliverables for each time unit.
   - Provide estimated effort per phase (in hours or days).

4. **Detailed Deliverables**
   - Clearly outline goals, deliverables, and success metrics for each milestone.
   - Use bullet points to describe analytical steps, validation checks, and outputs.
   - Include both technical (code, models, reports) and analytical deliverables (insights, recommendations).
### Technical Deliverables

**Environment Documentation:**
- `requirements_base.txt` - Base environment packages
- `requirements_domain.txt` or `requirements_full.txt` - Complete package list
- `.vscode/settings.json` - VS Code configuration
- `setup_domain_extensions.py` - Custom extension script (if applicable)

**Purpose:** Enable environment reproduction by collaborators or for deployment

5. **Readiness Checklist**
   - Define preconditions for transitioning to the next phase (e.g., modeling readiness, deployment readiness).
   - Include data validation, documentation completeness, and reproducibility checks.

### Phase 1 Readiness Checklist

Before beginning data exploration:

**Environment Readiness:**
- [ ] Virtual environment created and activated
- [ ] All base packages installed and verified
- [ ] Jupyter kernel registered and selectable
- [ ] VS Code extensions installed and functional
- [ ] Domain-specific packages installed (if needed)
- [ ] Test notebook runs without import errors

6. **Success Criteria**
   - Quantitative: measurable indicators of completion or quality (e.g., number of features, model performance).
   - Qualitative: alignment with business logic, interpretability, or stakeholder expectations.
   - Technical: data quality, code reproducibility, and version control compliance.

7. **Documentation & Ownership**
   - Ensure all scripts, notebooks, and datasets are versioned and linked to the project plan.
   - Document assumptions, transformations, and limitations.
   - Include author name, role, and project timeline.

---

## Plan Structure Templates

The following templates provide standardized formats for organizing sprint/daily project plans. These templates help maintain consistency across all project phases.

### Template 1: Daily Task Breakdown Format

Break each day into timed parts with clear objectives and deliverables.

**Format:**
```markdown
### Day X - [Focus Area]
**Goal:** [One sentence objective]

**Total Time:** [X hours] (configure based on your sprint length - see Template 8: Sprint Plan with Cadence Guidance)

#### Part 0: [Task Name] ([Duration])
**Objective:** [What this accomplishes]
**Activities:**
- [Activity 1]
- [Activity 2]
**Deliverables:**
- [Output 1]
- [Output 2]

#### Part 1: [Task Name] ([Duration])
**Objective:** [What this accomplishes]
**Activities:**
- [Activity 1]
- [Activity 2]
**Deliverables:**
- [Output 1]
- [Output 2]

[Repeat for Parts 2, 3, 4...]
```

**Example:**
```markdown
### Day 1 - Project Setup & Planning
**Goal:** Establish project structure and validate environment

**Total Time:** 4 hours

#### Part 0: Environment Configuration (30 min)
**Objective:** Set up development environment and validate database connection
**Activities:**
- Install required Python libraries
- Test database connectivity
- Create project folder structure
**Deliverables:**
- Working Jupyter environment
- Successful database connection
- Project directory structure

#### Part 1: Data Inventory (1 hour)
**Objective:** Document available datasets and schemas
**Activities:**
- Query table schemas
- Count records per table
- Identify primary/foreign keys
**Deliverables:**
- Data inventory report
- Schema documentation
```

---

### Template 2: Phase Summary Format

Provide standardized summaries at end of each day/phase showing time allocation and achievements.

**Format:**
```markdown
## [Day/Phase] Summary

### Time Allocation ([X] hours total):
| Task           | Duration      | Percentage |
| -------------- | ------------- | ---------- |
| Part 0: [Task] | [X] min/hours | [Y]%       |
| Part 1: [Task] | [X] min/hours | [Y]%       |
| Part 2: [Task] | [X] min/hours | [Y]%       |
| **Total**      | **[X] hours** | **100%**   |

### Key Achievements:
- [Achievement 1]
- [Achievement 2]
- [Achievement 3]

### Outputs Created:
- [File/deliverable 1]
- [File/deliverable 2]
- [File/deliverable 3]

### Issues Encountered:
- [Issue 1 and resolution]
- [Issue 2 and resolution]
- None (if applicable)

### Ready for Next Phase:
- [Prerequisite 1 met]
- [Prerequisite 2 met]
```

**Example:**
```markdown
## Day 1 Summary

### Time Allocation ([X] hours total):
| Task                            | Duration    | Percentage |
| ------------------------------- | ----------- | ---------- |
| Part 0: Environment Setup       | 30 min      | 12.5%      |
| Part 1: Data Inventory          | 1 hour      | 25%        |
| Part 2: Initial Data Extraction | 1.5 hours   | 37.5%      |
| Part 3: Documentation           | 1 hour      | 25%        |
| **Total**                       | **[X] hours** | **100%**   |

### Key Achievements:
- Development environment fully operational
- All 4 source tables documented
- Initial dataset extracted (5,765 users)

### Outputs Created:
- `environment_setup_log.txt`
- `data_inventory_report.csv`
- `users_initial.csv`

### Issues Encountered:
- Database timeout on large query (resolved by adding LIMIT during testing)

### Ready for Next Phase:
- Database connection validated
- Data structure understood
- Project repository organized
```

---

### Template 3: Expected Outcomes Table Format

Quantify expected results with before/after comparisons and measurable improvements.

**Format:**
```markdown
## Expected Outcomes

| Metric      | Before             | After             | Improvement     | Target Met        |
| ----------- | ------------------ | ----------------- | --------------- | ----------------- |
| [Metric 1]  | [Value]            | [Value]           | [+X%]           | Yes/No            |
| [Metric 2]  | [Value]            | [Value]           | [+X%]           | Yes/No            |
| **Summary** | **[Total before]** | **[Total after]** | **[Overall %]** | **[X/Y targets]** |

### Key Benefits:
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]
```

**Example:**
```markdown
## Expected Outcomes

| Metric           | Before           | After           | Improvement       | Target Met      |
| ---------------- | ---------------- | --------------- | ----------------- | --------------- |
| Notebooks        | 15 files         | 6 files         | -60%              | Yes             |
| Total lines      | ~7,000           | ~3,200          | -54%              | Yes             |
| Code duplication | High             | Minimal         | N/A               | Yes             |
| Avg file size    | Variable         | 400-650 lines   | Standardized      | Yes             |
| **Summary**      | **15 notebooks** | **6 notebooks** | **60% reduction** | **4/4 targets** |

### Key Benefits:
- Easier code review and maintenance
- Consistent structure across all stages
- Professional repository organization
- Better modularity for iteration
```

---

### Template 4: Phase Prerequisites Format

Define clear handoff criteria between phases to ensure readiness.

**Format:**
```markdown
## Phase [X] Prerequisites

### Required Inputs:
- [ ] [Input 1 with specifications]
- [ ] [Input 2 with specifications]
- [ ] [Input 3 with specifications]

### Completion Criteria:
- [ ] [Criterion 1 - measurable]
- [ ] [Criterion 2 - measurable]
- [ ] [Criterion 3 - measurable]

### Quality Checks:
- [ ] [Check 1]
- [ ] [Check 2]
- [ ] [Check 3]

### Deliverables Ready:
- [ ] [Deliverable 1: filename/description]
- [ ] [Deliverable 2: filename/description]
- [ ] [Deliverable 3: filename/description]

### Next Phase Readiness:
After completing this phase, you will have:
- [Asset 1]
- [Asset 2]
- [Asset 3]
```

**Example:**
```markdown
## Phase 2 Prerequisites (Feature Engineering)

### Required Inputs:
- [ ] Clean user dataset (`users_cleaned.csv`, 5,765 rows)
- [ ] Validated cohort definition (>7 sessions, age 18-100)
- [ ] Data quality report showing <5% missing values

### Completion Criteria:
- [ ] All outliers removed using IQR method
- [ ] No missing values in critical fields
- [ ] User-level aggregation complete

### Quality Checks:
- [ ] Data types validated
- [ ] Range checks passed for all numerical fields
- [ ] Duplicate user_ids removed

### Deliverables Ready:
- [ ] `01_EDA_data_quality.ipynb` (runs without errors)
- [ ] `02_EDA_behavioral_analysis.ipynb` (runs without errors)
- [ ] `users_clean_final.csv` (validated dataset)

### Next Phase Readiness:
After completing Phase 1, you will have:
- Clean, validated user-level dataset ready for feature engineering
- Understanding of data distributions and patterns
- Documented data quality decisions
```

---

## Advanced Planning Framework: Version 2.0 Enhancements

**When to use Version 2.0 planning:**
- First time executing a complex phase with uncertain scope
- Phases prone to scope creep (exploration, feature engineering, analysis)
- When daily reflection and mid-course correction add value
- Multi-day phases where early drift detection matters

**Core principle:** Use structured daily reflection to enable agile adaptation and maintain progress visibility.

---

### Template 5: Daily Checkpoint Framework

**Purpose:** Enable systematic daily review to detect drift, adjust scope, and maintain progress visibility.

**Format:**
```markdown
## Day X Checkpoint - [Phase Name] (YYYY-MM-DD)

### Scope Completion
- [ ] Part 0: [Task name] - [Complete/Partial/Not started]
- [ ] Part 1: [Task name] - [Complete/Partial/Not started]
- [ ] Part 2: [Task name] - [Complete/Partial/Not started]
- [ ] Part 3: [Task name] - [Complete/Partial/Not started]
- [ ] Part 4: [Task name] - [Complete/Partial/Not started]

**Completion Rate:** [X/Y parts complete] = [XX%]

### Key Findings
1. **Most important finding:** [1-2 sentences]
2. **Second most important finding:** [1-2 sentences]
3. **Unexpected discovery:** [1-2 sentences or "None"]

### Quality Assessment
- **Output quality:** [Excellent/Good/Needs improvement] - [Why?]
- **Validation results:** [All passed/Partial/Failed] - [Details]
- **Code/analysis quality:** [Clean/Needs work/Has issues]

### Blockers & Issues
- **Technical blockers:** [List or "None"]
- **Data/resource issues:** [List or "None"]
- **Conceptual challenges:** [List or "None"]
- **Mitigation actions taken:** [What did you do?]

### Progress Tracking (if using priority tiers)
**MUST Deliverables ([X] total):**
- [ ] [Item 1] - [Complete/In progress/Planned]
- [ ] [Item 2] - [Complete/In progress/Planned]

**SHOULD Deliverables ([X] total):**
- [ ] [Item 3] - [Complete/In progress/Planned]
- [ ] [Item 4] - [Complete/In progress/Planned]

**COULD Deliverables ([X] total):**
- [ ] [Item 5] - [Complete/Skipped/Planned]

**Total Progress Today:** [X] deliverables completed  
**Cumulative Progress:** [XX] / [YY] target

### Adjustment Decisions for Day X+1

**Scope Changes:**
- [ ] Keep plan as-is
- [ ] Add activity: [Specify what and why]
- [ ] Remove activity: [Specify what and why]
- [ ] Simplify approach: [Specify what and why]

**Priority Adjustment:**
- [ ] Maintain current priority structure
- [ ] Focus only on MUST deliverables (contingency triggered)
- [ ] Skip COULD deliverables to maintain focus

### Next Day Preview
**Day X+1 Primary Objectives:**
1. [Objective 1]
2. [Objective 2]

**Day X+1 Success Criteria:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]

**Day X+1 Contingency Plan (if behind):**
- [What will you cut or simplify?]

### Decision Log Updates
- **DEC-XXX:** [Brief decision title]
  - Context: [1 sentence]
  - Decision: [1 sentence]
  - Impact: [What does this affect?]

### Notes & Learnings
- **What worked well today:** [1-2 items]
- **What could be improved:** [1-2 items]
- **Insights for next phase:** [Anything to carry forward]

### Appendix: Outputs Created

**Datasets:**
- `path/to/dataset.pkl` ([rows] rows x [cols] columns, [size] MB)

**Visualizations:**
- `path/to/figure.png` (description)

**Documentation:**
- `path/to/document.md` (purpose)

**Notebooks:**
- `path/to/notebook.ipynb` ([cells] cells, ~[lines] lines)

---

**Checkpoint completed by:** [Name]
**Next checkpoint:** Day [X+1], [Date]
```

**Filename Convention:** `sXX_dXX_checkpoint.md` (e.g., s01_d03_checkpoint.md)

**Location:** `dsm-docs/checkpoints/` or `dsm-docs/plans/`

**Benefits of Daily Checkpoints:**
- Enables recovery if session interrupted
- Tracks progress systematically
- Documents decisions as they're made
- Identifies issues early
- Provides foundation for handoff documents

---

### Template 6: Progressive Expected Outcomes Table

**Purpose:** Track incremental progress across multi-day phases to enable early drift detection and scope adjustment.

**When to use:** Phases lasting 3+ days with clear mid-phase milestones

**Format:**
```markdown
## Expected Outcomes

| Metric      | Before Phase       | After Days [1-X]       | After Phase Complete | Target Met        |
| ----------- | ------------------ | ---------------------- | -------------------- | ----------------- |
| [Metric 1]  | [Baseline]         | [Intermediate]         | [Final]              | Yes/No            |
| [Metric 2]  | [Baseline]         | [Intermediate]         | [Final]              | Yes/No            |
| [Metric 3]  | [Baseline]         | [Intermediate]         | [Final]              | Yes/No            |
| **Summary** | **[Total before]** | **[Milestone status]** | **[Total after]**    | **[X/Y targets]** |

### Key Benefits
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]
```

**Example: 5-day Feature Engineering Phase**
```markdown
## Expected Outcomes

| Metric            | Before Sprint 2      | After Days 1-2              | After Sprint 2 (Days 3-5)  | Target Met      |
| ----------------- | -------------------- | --------------------------- | -------------------------- | --------------- |
| Feature count     | 28 columns           | 28 + 10 (core features)     | 54-58 columns              | Yes             |
| Core features     | 0                    | 10 complete                 | 10 validated               | Yes             |
| Advanced features | 0                    | 0 (planned Days 3-5)        | 15-20 complete             | Yes             |
| Optional features | 0                    | 0                           | 0-3 complete               | Conditional     |
| **Summary**       | **Baseline dataset** | **Core features milestone** | **Modeling-ready dataset** | **3/3 targets** |

### Key Benefits
- Early detection of scope issues (after Day 2 review)
- Mid-phase adjustment based on milestone achievement
- Clear go/no-go decision point before advanced work
```

---

### Template 7: MUST/SHOULD/COULD Priority Framework

**Purpose:** Structured prioritization to prevent "everything is important" paralysis and enable clear scope reduction decisions.

**When to use:** Complex phases with >10 deliverables, risk of scope creep, or uncertain capacity

**Framework:**

**MUST Deliverables (20-30% of total):**
- Critical for phase completion
- Blocks next phase if incomplete
- Non-negotiable, even if behind schedule
- Complete first, validate thoroughly

**SHOULD Deliverables (50-60% of total):**
- High value, expected if on track
- Enhances quality but not strictly blocking
- Complete if progress is on track
- Skip selectively if behind on scope

**COULD Deliverables (10-20% of total):**
- Bonus features if ahead on scope
- Exploratory or "nice to have"
- First to cut when constrained
- Defer to future phases if needed

**Format:**
```markdown
## Success Criteria - Structured by Priority

**MUST Deliverables ([X] total - Non-negotiable):**
- [ ] [Deliverable 1] - [Description]
- [ ] [Deliverable 2] - [Description]
- [ ] [Deliverable 3] - [Description]

**SHOULD Deliverables ([X] total - Complete if on schedule):**
- [ ] [Deliverable 4] - [Description]
- [ ] [Deliverable 5] - [Description]
- [ ] [Deliverable 6] - [Description]

**COULD Deliverables ([X] total - Only if ahead):**
- [ ] [Deliverable 7] - [Description]
- [ ] [Deliverable 8] - [Description]

**Contingency Rules:**
- If on track with scope â†' Full scope (MUST + SHOULD + COULD)
- If 10-20% behind on scope â†' MUST + SHOULD only
- If >20% behind on scope â†' MUST only, document deferred work
```

**Example:**
```markdown
## Success Criteria - Structured by Priority

**MUST Deliverables (4 total - Non-negotiable):**
- [ ] Data quality assessment complete (outliers, missing values, validation)
- [ ] Core temporal features created (date components, basic aggregations)
- [ ] Primary visualizations generated (time series, distributions, correlations)
- [ ] Clean dataset exported for next phase

**SHOULD Deliverables (6 total - Complete if on schedule):**
- [ ] Store-level analysis (performance comparison, clustering)
- [ ] Product dynamics analysis (fast/slow movers, Pareto)
- [ ] External factor investigation (holidays, promotions)
- [ ] Advanced visualizations (heatmaps, interaction plots)
- [ ] Preliminary feature importance analysis
- [ ] Comprehensive decision log with rationale

**COULD Deliverables (3 total - Only if ahead):**
- [ ] Three-method outlier detection (IQR + Z-score + Isolation Forest)
- [ ] Transaction pattern analysis (basket size, traffic)
- [ ] Perishable waste risk modeling

**Contingency Rules:**
- If on schedule after Day 2 â†’ Full scope (13 deliverables)
- If 10-20% behind after Day 2 â†’ MUST + SHOULD only (10 deliverables)
- If >20% behind after Day 2 â†’ MUST only (4 deliverables), document deferred
```

---

### Template 8: Sprint Plan with Cadence Guidance

**Purpose:** Sprint-level planning template for multi-sprint projects. Combines task breakdown, prerequisites, and prioritization at the sprint level (rather than daily level). Encourages short sprint cadence with feedback at every boundary.

**When to use:** Projects with multiple sprints, or any sprint requiring structured planning with MUST/SHOULD/COULD deliverables.

**Sprint Cadence Guidance:**
- Prefer 1-3 focused sprints over 1 large sprint
- Each sprint should deliver a testable, demonstrable increment
- Each sprint boundary triggers the Sprint Boundary Checklist below
- Split sprints when: original scope has >2 distinct deliverable types, would exceed 3 sessions without a feedback point, or natural delivery boundaries exist

**Format:**

```markdown
# Sprint [N]: [Sprint Title]

**Duration:** [Estimated sessions]
**Goal:** [One-sentence sprint objective]
**Prerequisites:** [What must be complete before starting]

## Research Assessment (before detailing deliverables)

After initial research and any decisions, evaluate:
- Can I describe the scope in enough detail for a concrete task breakdown?
- Are there unresolved unknowns that would make task estimates speculative?

If unknowns remain, conduct targeted deep-dive research (see DSM_0.2 Phase 0.5,
tiered research pattern) before proceeding to deliverables. This prevents plans
built on speculative assumptions.

## Experiment Gate (before implementation begins)

If the sprint introduces a new user-facing capability, an experiment must be
defined before implementation starts:

- [ ] **Capability sprint:** EXP-XXX defined in epoch/project plan with success
  criteria, realistic test data, and expected output (see DSM 4.0 Section 4.4,
  Appendix C.1.3)
- [ ] **Performance-only sprint** (no new capability): experiment skip justified
  in sprint notes

When work emerges between sprints (e.g., findings from a prior experiment reveal
a new capability need), update the epoch/project plan with an experiment
definition before the capability is considered complete.

## Branch Strategy

For multi-sprint projects, each sprint creates a Level 3 sprint branch
(`sprint-N/short-description`) off the session branch (Level 2). The sprint
branch merges back to the session branch when all sprint plan items are
checked off. See DSM_0.2 Three-Level Branching Strategy for the full model.

---

## Deliverables

### MUST (Sprint fails without these)
- [ ] [Deliverable 1] -- [brief description]
- [ ] [Deliverable 2] -- [brief description]

### SHOULD (Expected, defer if blocked)
- [ ] [Deliverable 3] -- [brief description]

### COULD (Stretch goals)
- [ ] [Deliverable 4] -- [brief description]

---

## Phases

### Phase 1: [Phase Name]
- **Focus:** [What this phase accomplishes]
- **Deliverables:** [Which items from above]
- **Execution mode:** notebook | script | both
- **DSM references:** [Relevant DSM sections for this phase type]
- **Success criteria:** [How to know phase is complete]

### Phase 2: [Phase Name]
- **Focus:** [What this phase accomplishes]
- **Deliverables:** [Which items from above]
- **Execution mode:** notebook | script | both
- **DSM references:** [Relevant DSM sections for this phase type]
- **Success criteria:** [How to know phase is complete]

**Phase planning notes:**
- Tag each phase with an execution mode. Use `script` when the phase involves
  long-running computation (>2 min), batch processing, or results that must
  persist independently. The notebook should import from or call scripts, not
  replicate computation inline.
- For evaluation/benchmarking phases, reference DSM Appendix C.1
  (Experiment Templates) and Section 5.2.1 (Experiment Tracking).

---

## Phase Boundary Checklist (intra-sprint)
- [ ] Update methodology.md with phase observations and scores
- [ ] Create checkpoint if significant milestone reached
- [ ] Log decisions made during phase (dsm-docs/decisions/)
- [ ] Update blog materials if insights worth sharing

---

## Open Design Questions
1. [Question that needs answering during sprint]
2. [Question that needs answering during sprint]

---

## How to Resume
1. Read this sprint plan
2. Read the most recent checkpoint in dsm-docs/checkpoints/
3. [Project-specific resume steps]

---

## Sprint Boundary Checklist
- [ ] Checkpoint document created (dsm-docs/checkpoints/)
- [ ] Feedback files updated (backlogs, methodology)
- [ ] Decision log updated with sprint decisions
- [ ] Tests passing (DSM 4.0 projects)
- [ ] Blog journal entry written
- [ ] Blog publication tracker updated (`dsm-docs/blog/README.md`)
- [ ] Repository README updated (status, results, structure)
- [ ] Next steps summary (3-5 sentences: next sprint goal, key deliverables, relevant plan reference)
```

**Example:**

```markdown
# Sprint 1: Parser MVP

**Duration:** 1-2 sessions
**Goal:** Extract section headings and cross-references from DSM markdown files
**Prerequisites:** Project setup complete (Phase 0), research survey done (Phase 0.5)

---

## Deliverables

### MUST (3 total - Non-negotiable)
- [ ] Section heading parser -- Extract numbered, appendix, and unnumbered headings
- [ ] Cross-reference extractor -- Find Section X.Y.Z, Appendix X.Y, DSM_X.Y patterns
- [ ] Unit test suite -- 80%+ coverage, TDD approach

### SHOULD (2 total - Complete if on track)
- [ ] Test fixture with realistic DSM patterns
- [ ] Architecture Decision Record for parser library choice

### COULD (1 total - Stretch)
- [ ] Code block skip handling (avoid false positives in fenced blocks)

---

## Phases

### Phase 1: Section Parser
- **Focus:** Extract headings from markdown
- **Deliverables:** Section parser, initial tests
- **Success criteria:** Handles all 4 heading formats, tests pass

### Phase 2: Cross-Reference Extractor
- **Focus:** Find references in body text
- **Deliverables:** Cross-ref extractor, expanded tests
- **Success criteria:** Finds all 3 pattern types, skips code blocks

---

## Sprint Boundary Checklist
- [ ] Checkpoint: dsm-docs/checkpoints/sprint1-complete.md
- [ ] Feedback: dsm-docs/feedback-to-dsm/ updated with DSM observations
- [ ] Decisions: DEC-001 recorded
- [ ] Tests: pytest passing, 80%+ coverage
- [ ] Blog: Sprint 1 journal entry written
- [ ] Blog: Publication tracker updated (`dsm-docs/blog/README.md`)
- [ ] Next steps: Sprint 2 goal, deliverables, and epoch plan reference
```

---

### Template 10: End-of-Day Checkpoint Questions

**Purpose:** Quality gates to prevent compounding errors and ensure readiness for next day.

**When to use:** Embed 3-5 critical questions at the end of each day's deliverables section.

**Categories of checkpoint questions:**

**1. Technical Validation Questions:**
- Is [technical requirement] correctly implemented?
- Did validation confirm [expected behavior]?
- Are [metrics] within expected ranges?
- Should we adjust [approach] based on findings?

**2. Quality Assessment Questions:**
- Does output meet [quality standard]?
- Are visualizations clear and interpretable?
- Is documentation complete and accurate?
- Are there any silent errors or edge cases?

**3. Scope Management Questions:**
- Did we complete all planned parts within [X]h budget?
- Should we add/remove analyses for next day?
- Are findings interesting enough to warrant deeper exploration?
- Do we need to adjust next day's scope?

**4. Readiness Questions:**
- Are prerequisites met for next day's work?
- Is intermediate dataset saved and validated?
- Are blockers documented and addressed?
- Do we have clarity on tomorrow's objectives?

**Format (embed at end of each day's section):**
```markdown
#### **End-of-Day X Checkpoint**

**Critical Review Questions:**
1. [Technical validation question]?
2. [Quality assessment question]?
3. [Scope management question]?
4. [Readiness question]?
5. [Budget/schedule question]?

**Adjustment Options:**
- If ahead of schedule â†’ [Expansion option]
- If behind schedule â†’ [Reduction option]
- If [condition] found â†’ [Mitigation action]

**Use Daily Checkpoint Template (Section [X]) to document decisions.**
```

**Example:**
```markdown
#### **End-of-Day 2 Checkpoint**

**Critical Review Questions:**
1. Are rolling windows (7/14/30 days) smoothing noise as expected?
2. Did min_periods=1 reduce NaN to <1% as planned?
3. Are high-volatility items identifiable for further analysis?
4. Should we add rolling max/min features tomorrow (optional)?
5. Are we on track for external data integration (Day 3)?

**Adjustment Options:**
- If ahead of schedule â†’ Add rolling max/min features on Day 3
- If behind schedule â†’ Reduce Day 3 scope to core features only
- If smoothing insufficient â†’ Revisit window sizes on Day 3

**Use Daily Checkpoint Template (Section 11) to document decisions.**
```

---

### Template 11: Q&A Preparation Document

**Purpose:** Prepare for presentation questions and reinforce understanding of work

**When to Create:** After each major sprint (especially Sprint 1, Sprint 3)

**Filename:** `Sprint[N]_QA_Presentation_Prep.md`

**Location:** `dsm-docs/`

**Structure:**

```markdown
# Sprint [N] Q&A - Presentation Preparation

**Project:** [Name]
**Scope:** [Sprint objectives]
**Total Questions:** ~35 (7 per major notebook/section)

## Table of Contents
1. [Topic 1 - Notebook/Analysis Area]
2. [Topic 2 - Notebook/Analysis Area]
...

---

## Topic 1 - [Notebook/Analysis Name]

### Q1: [Technical question about methodology]

**Technical Answer:**
[Detailed explanation with metrics, algorithms, statistical reasoning]

**Business Answer:**
[Stakeholder-friendly explanation focusing on outcomes and decisions]

**Key Insight:**
[One sentence takeaway that captures essence]

---

### Q2: [Business question about findings]

**Technical Answer:**
[Statistical details, correlation coefficients, test results]

**Business Answer:**
[Action-oriented response with ROI implications]

**Key Insight:**
[Memorable sound bite for presentations]
```

**Question Distribution Guidelines:**

**Sprint 1 (Exploration):**
- 40% Technical (data quality, methodology choices, statistical tests)
- 40% Business (insights, patterns discovered, implications)
- 20% Contextual (scope decisions, limitations, alternatives considered)

**Sprint 3 (Modeling):**
- 40% Technical (algorithms, hyperparameters, validation approach)
- 30% Business (performance metrics, deployment readiness)
- 30% Comparison (why Model A vs Model B, tradeoffs)

**Question Types to Cover:**

1. **Methodology Questions:**
   - "Why did you use [method X] instead of [method Y]?"
   - "How did you handle [specific challenge]?"
   - "What assumptions did you make?"

2. **Results Questions:**
   - "What was your most important finding?"
   - "What surprised you in the data?"
   - "How confident are you in these results?"

3. **Decision Questions:**
   - "Why did you choose [Option A] over [Option B]?"
   - "What alternatives did you consider?"
   - "How would you approach this differently next time?"

4. **Business Questions:**
   - "What should we do with these insights?"
   - "How much improvement can we expect?"
   - "What are the limitations we should know?"

**Benefits:**
- Forces deep understanding (teaching effect - if you can't explain it, you don't understand it)
- Identifies knowledge gaps early (before presentation)
- Builds presentation confidence (practiced responses)
- Creates reference material for final report
- Demonstrates systematic thinking to stakeholders

---

### Template 12: Scope Limitations Log

**Purpose:** Transparently document what is OUT of scope and why

**When to Create:** Sprint 1 (after scope finalized)

**When to Update:** Whenever scope boundary discovered or confirmed

**Filename:** `scope_limitations.md`

**Location:** `dsm-docs/`

**Template:**

```markdown
# Scope Limitations - [Project Name]

**Project:** [Name]
**Last Updated:** [Date]
**Version:** [X]

---

## In Scope

**Included in this analysis:**
- [What IS covered - be specific]
- [What IS covered - include metrics if relevant]
- [What IS covered - reference decisions if applicable]

**Example:**
- OK: Guayas region (11 stores, 73.8% in Guayaquil)
- OK: Top-3 product families: GROCERY I, BEVERAGES, CLEANING (59% of catalog)
- OK: Non-perishable items only (2,296 items, 0% perishable)
- OK: Daily sales forecasting (March 2014 test period)
- OK: 300K sample for development, full dataset for validation

---

## Out of Scope

**Excluded from this analysis:**
- [What is NOT covered] - **Reason:** [Why excluded - resource/time/data/priority]
- [What is NOT covered] - **Reason:** [Why excluded]

**Example:**
- ERROR: Perishable categories (PRODUCE, DAIRY, MEATS, BREAD/BAKERY)
  - **Reason:** Top-3 families contain 0% perishables (per DEC-010). Perishables require different forecasting approach (daily vs weekly), shorter forecast horizons, higher accuracy requirements. Out of scope for 4-sprint timeline.

- ERROR: Regions outside Guayas (43 stores in other provinces)
  - **Reason:** Guayas provides sufficient variety (11 stores, mixed types) for methodology validation. Other regions may have different climate, demographics, product mix. Expanding to national scope would triple data volume and complexity, exceeding 4-sprint timeline.

---

## Discovered Limitations

**Limitations identified during analysis:**

| Item | Discovered When | Impact | Mitigation | Status |
|------|-----------------|--------|------------|--------|
| [Limitation] | [Sprint X, Day Y] | [Effect on project] | [How we addressed it] | [Accepted/Workaround/Future] |

**Example:**
| Item | Discovered When | Impact | Mitigation | Status |
|------|-----------------|--------|------------|--------|
| Perishables 0% in sample | Sprint 1, Day 5 | Cannot forecast PRODUCE, DAIRY | Document limitation, note for Phase 2 | Accepted |
| 16% missing promotions (2013-2014) | Sprint 1, Day 3 | Cannot distinguish no-promo vs not-tracked | Fill with 0 (conservative assumption per DEC-003) | Workaround |

---

## Future Scope Expansion

**Potential additions for Phase 2 or future work:**

1. **[Potential addition]**
   - **Value proposition:** [Business benefit]
   - **Prerequisites:** [What needs to happen first]
   - **Priority:** High / Medium / Low
```

**Benefits:**
- Prevents stakeholder surprise ("why didn't you do X?")
- Documents justification for scope decisions
- Creates roadmap for future phases
- Demonstrates project management discipline
- Protects against scope creep

---

### Enhanced Risk Management for Version 2.0 Plans

**Additional risks to consider when using v2.0 framework:**

| Risk                                             | Likelihood | Impact | Mitigation                                                   |
| ------------------------------------------------ | ---------- | ------ | ------------------------------------------------------------ |
| **Scope creep during exploration**               | Medium     | Medium | Daily checkpoints maintain MUST/SHOULD/COULD discipline      |
| **Interesting findings trigger scope expansion** | Medium     | Medium | Defer deep dives to future phases, document for later        |
| **Checkpoint fatigue in long phases**            | Low        | Medium | Reduce frequency after Sprint 1, maintain at key milestones  |

---

### Communication Plan Enhancement for Version 2.0

**Add to existing communication plan:**

```markdown
### Daily Checkpoints ([Phase Name])
- **Timing:** End of each day
- **Format:** Structured review using checkpoint template (Section [X])
- **Content:**
  - Scope completion (all parts done?)
  - Quality assessment (outputs validated?)
  - Findings (unexpected discoveries?)
  - Adjustment decisions (add/remove tasks for next day?)
- **Output:** Daily checkpoint document (Day[X]_Checkpoint_[Phase].md)
- **Purpose:** Enable agile adaptation, prevent scope creep, maintain progress visibility
```

---

### Decision Tree: Should You Use Version 2.0 Planning?

**Use Version 1.0 (Standard) if:**
- Experienced with this type of work (know what to expect)
- Straightforward scope with minimal uncertainty
- Short phase duration (1-2 days)

**Use Version 2.0 (Enhanced) if:**
- First time doing this type of work (uncertain scope)
- Complex scope prone to drift or creep
- Multi-day phase where early detection matters
- High value of systematic reflection and adjustment

---

### Version 2.0 Best Practices

**1. Commit to the discipline:**
- Complete checkpoint before closing for the day
- Keep checkpoints concise and focused

**2. Be honest in assessments:**
- Document real blockers, not excuses
- Adjust scope proactively when behind

**3. Focus on trends, not precision:**
- "Ahead/On/Behind" is sufficient granularity
- Progress status guides decisions

**4. Use checkpoints for agility:**
- Scope adjustments are normal and expected
- MUST/SHOULD/COULD framework enables clean cuts
- Deferred work is documented, not abandoned

**5. Carry learnings forward:**
- Checkpoint notes inform next phase planning
- Adjustment decisions build project wisdom

**6. Know when to stop:**
- If phase consistently on track, reduce checkpoint frequency
- If scope is straightforward, revert to v1.0

---

### Integration with Existing Templates

**Where to add Version 2.0 elements in project plans:**

**Section 3 (Timeline):**
- Define milestones and checkpoints

**Section 4 (Deliverables):**
- Add end-of-day checkpoint questions after each day (Template 8)

**Section 6 (Success Criteria):**
- Restructure using MUST/SHOULD/COULD framework (Template 7)

**Section 8 (Risk Management):**
- Add scope creep, checkpoint overhead, and exploration drift risks

**Section 9 (Expected Outcomes):**
- Replace 2-stage table with 3-stage progressive table (Template 6)

**Section 10 (Communication Plan):**
- Add "Daily Checkpoints" subsection with template reference

**New Section 11:**
- Add complete Daily Checkpoint Template (Template 5)

---

**End of Version 2.0 Planning Framework**

**Summary:** Version 2.0 planning adds structured daily discipline through checkpoints, progressive tracking, and priority tiers to enable agile adaptation in complex, multi-day phases with uncertain scope.

**When in doubt:** Use v2.0 for critical phases and first-time work; revert to v1.0 once confidence is established.
---

## Recommended Style and Structure

| Section               | Format                                                 | Description                                                                       |
| --------------------- | ------------------------------------------------------ | --------------------------------------------------------------------------------- |
| **Headers**           | Use H2/H3 hierarchy (`##`, `###`)                      | Maintain consistent hierarchy and clarity                                         |
| **Tables**            | Markdown tables for timelines and deliverables         | Use columns for *Day/Sprint*, *Focus Area*, and *Deliverables*                    |
| **Bullets**           | Concise, action-oriented                               | Begin each bullet with an actionable verb (e.g., *Define*, *Compute*, *Validate*) |
| **Metrics & Outputs** | Use bold formatting for key metrics and filenames      | e.g., **user_features.csv**, **RFM score**, **accuracy >= 0.85**                   |
| **Separation**        | Use `---` for visual separation between major sections | Enhances readability and consistency                                              |

---

## Tone and Style

All documentation, project plans, and notebooks should adhere to a **professional, concise, and objective tone**.  

**Requirements:**
- **Professional language only.** Avoid informal expressions and personal opinions.  
- **No emojis or decorative symbols** in any document or notebook.  
- **Each section** of a markdown or project plan must include a **short, informative description** summarizing its content and intent.  
- **Each Jupyter Notebook cell** must:
  - Contain a short markdown description explaining what the cell does.  
  - Generate **at least one visible output** (table, plot, metric, or print statement) to demonstrate results or intermediate checks.  
- **Formatting consistency** should be prioritized â€” all text, tables, and figures must be clear, aligned, and free of unnecessary embellishments.  
- **Comments in code** should be brief, meaningful, and written in complete sentences where relevant.

This section ensures the deliverables communicate technical rigor and are accessible to both technical and non-technical stakeholders.

### Character and Symbol Restrictions

To ensure compatibility across all systems and maintain professional standards:

**Prohibited:**
- Emojis of any kind
- Unicode checkmarks or symbols
- Special decorative characters

**Required:**
- Standard markdown checkboxes: `[ ]` for incomplete, `[x]` for complete
- Plain text status prefixes: "OK:", "WARNING:", "ERROR:"
- ASCII-only characters in all documentation

**Applies to:**
- Project plans and reports
- Notebook markdown cells
- README files
- All markdown documentation

### Notebook Cell Quality Checklist

Quick reference for cell-by-cell development (supplements Section 7.1):

**Before each code cell:**
- [ ] Markdown cell explaining WHAT this cell does and WHY
- [ ] Cell number comment (e.g., `# Cell 3`)

**After each code cell:**
- [ ] Output shows actual values (shapes, counts, metrics, samples)
- [ ] No generic confirmations ("Success!", "Done!", "Complete!")

**At section transitions:**
- [ ] Summary markdown cell with key findings from the section
- [ ] Variables and state carried forward are noted

**Per notebook:**
- [ ] Title markdown cell with notebook purpose and context
- [ ] Final summary cell with key outputs and next steps
- [ ] All cells run in sequence without errors (Kernel > Restart & Run All)

### Notebook Portability Checklist

When notebooks must run in multiple environments (local, Colab, shared compute):

**Directory Safety:**
- [ ] Use `os.makedirs(path, exist_ok=True)` instead of assuming directories exist
- [ ] Use `pathlib.Path` for cross-platform path handling

**Package Management:**
- [ ] Include `!pip install` cell at notebook start for cloud environments
- [ ] Guard with `try/except ImportError` for optional packages
- [ ] Pin versions for reproducibility: `!pip install pandas==2.3.3`

**Data Access:**
- [ ] Provide fallback for data download (local path vs. API download)
- [ ] Handle authentication via environment variables, not hardcoded credentials
- [ ] Document any external API changes (e.g., Kaggle auth method updates)

**Runtime:**
- [ ] Document GPU/CPU requirements in notebook header
- [ ] Note expected runtime per section for long computations
- [ ] Test in target environment before delivery

**Environment Detection:**
```python
import sys
IN_COLAB = 'google.colab' in sys.modules
```

Cross-reference: Appendix A.7 (Environment Tool Selection), Appendix A.9 (WSL & Cross-Platform)

### Visualization Quality Checklist

Before including any figure in a deliverable (notebook, blog, presentation):

**Content:**
- [ ] Descriptive title present
- [ ] Both axes labeled with units where applicable
- [ ] Legend present if multiple series or categories shown
- [ ] Annotations or callouts for key data points where helpful

**Formatting:**
- [ ] Font size readable at target medium (notebook, slide, blog image)
- [ ] Color scheme consistent across all project figures
- [ ] Colorblind-friendly palette used (avoid red-green only distinctions)
- [ ] Resolution sufficient: 150+ DPI for web, 300+ DPI for print/slides

**Output:**
- [ ] Figure saved to `outputs/figures/` with descriptive filename
- [ ] Source data indicated in caption or annotation
- [ ] Figure referenced in notebook markdown or report text

**Context-Specific:**
- For presentations: ensure readability at projected size (larger fonts, simpler layouts)
- For blog posts: ensure figures work as standalone images (include context in title/caption)
- For notebooks: balance detail with inline readability

Cross-reference: Section 2.5 (Communication), Section 2.5.6 (Blog Process)

### Debugging Log Template

When a technical issue requires 3 or more attempts to resolve, capture the debugging
sequence using this template. This creates a reference for future projects encountering
the same issue.

```markdown
## Debugging Log: [Issue Title]

**Date:** YYYY-MM-DD
**Impact:** [Blocked progress / Degraded performance / Minor inconvenience]
**Iterations:** [Number of approaches tried]

### Problem
[What was expected vs what happened]

### Attempts

| # | Approach | Result | Why It Failed |
|---|----------|--------|---------------|
| 1 | [First attempt] | Failed | [Root cause] |
| 2 | [Second attempt] | Failed | [Root cause] |
| 3 | [Final attempt] | Success | -- |

### Root Cause
[Underlying issue that caused the problem]

### Solution
[What worked and why]

### Prevention
[How to avoid this in future projects]
```

**When to use:** Any issue requiring 3+ attempts to resolve, especially environment
or dependency issues that block progress. Include in checkpoint documents or as a
standalone entry in the project docs folder.

Cross-reference: DSM_1.0 Section 6.4 (Checkpoint Protocol), DSM_1.0 Section 6.1 (Session Management)

### Scope Review Checkpoint

When project scope expands beyond the original plan, conduct a lightweight scope review
to acknowledge and approve the change.

**Trigger Conditions (any of these):**
- COULD items are being worked on before all MUST and SHOULD items are complete
- Timeline extends beyond original plan
- New deliverables are added (e.g., blog post not in original plan)
- Significant unplanned work emerges (e.g., data leakage fix, API debugging)

**Review Questions:**

| Question | Purpose |
|----------|---------|
| Are all MUST items complete or on track? | Ensure core deliverables are not at risk |
| What COULD items are being added? | Document scope expansion |
| What is the timeline impact? | Acknowledge extension |
| Is the expansion justified? | Learning value, portfolio value, stakeholder request |
| Should any items be deferred? | Prevent unbounded scope creep |

**Documentation:** Add a one-line entry to the daily checkpoint:
```
Scope review: [COULD items X, Y added | Timeline extended to Day N | Justified because...]
```

Cross-reference: Template 7 (MUST/SHOULD/COULD Priority Framework),
Template 12 (Scope Limitations Log)

---

## Example Project Flow

| Sprint      | Focus Area                 | Key Outputs                                               |
| ----------- | -------------------------- | --------------------------------------------------------- |
| **Day 0**   | Environment Setup          | Virtual environment, base packages, VS Code configuration |
| **Sprint 1**| Data collection & cleaning | Validated datasets ready for analysis                     |
| **Sprint 2**| Feature engineering        | Analytical base and feature dictionary                    |
| **Sprint 3**| Modeling & validation      | Trained models, evaluation reports                        |
| **Sprint 4**| Deployment & reporting     | Production pipeline, stakeholder presentation             |

---

## Best Practices

- **Environment Setup:** Complete environment configuration (Day 0) before beginning analysis work. Generate domain-specific package scripts based on project documentation. See Methodology Section 2.1 (Phase 0: Environment Setup) for automated setup procedures.
- **Modularization:** Structure notebooks by phase (e.g., `01_data_cleaning.ipynb`, `02_feature_engineering.ipynb`).
- **Reproducibility:** Store parameters, transformations, and random seeds.
- **Transparency:** Keep assumptions and exclusions explicit.
- **Version Control:** Commit all code and documents to Git with descriptive messages. Use semantic versioning tags for releases:
  - `vX.Y.Z` - Content/feature release
  - `vX.Y.Z-consistency` - Post-release cleanup (version alignment, documentation fixes)
  - This creates clear recovery points and documents work progression
- **Documentation:** Maintain a centralized README linking datasets, notebooks, and reports.
- **Validation:** Integrate both statistical and business validation for each phase.
- **Communication:** Provide concise daily or sprint summaries of progress and blockers.

---

## Operational Monitoring

Track infrastructure resources consumed during AI-assisted work. This formalizes
resource tracking as a project management practice, providing consistent metrics
across projects and sessions.

### Metric Categories

| Category | Examples | Collection Method |
|----------|----------|-------------------|
| Network traffic | Bandwidth per hour/session | vnstat (daemon, persistent logging) |
| Network diagnosis | Per-process bandwidth | nethogs (real-time, on-demand) |
| API consumption | Tokens used, API calls made | Provider dashboards, session logs |
| Session efficiency | Duration, tool calls, iterations | Agent session metadata |
| Data transfer | Dataset/model download sizes | pip/conda logs, git transfer stats |
| Compute | CPU/GPU hours, memory peaks | /proc, nvidia-smi, time command |
| Storage | Repo sizes, artifact growth | du, git count-objects |

### Recommended Tool Stack

| Tool | Purpose | Install | Persistent? |
|------|---------|---------|-------------|
| vnstat | Hourly/daily bandwidth logging | `sudo apt install vnstat` | Yes (daemon) |
| nethogs | Per-process bandwidth (diagnosis) | `sudo apt install nethogs` | No (real-time) |
| /proc, ps | CPU/memory snapshots | Built-in | No |
| du, git count-objects | Storage tracking | Built-in | No |

### Integration Points

- **Session close-out (Section 6.1.5):** Optional `vnstat -h` snapshot in handoff metadata. See DSM_0.2 Session Management for the bandwidth reporting convention.
- **Checkpoints (dsm-docs/checkpoints/):** Resource summary alongside milestone context.
- **Sprint boundaries:** Cumulative resource report for the sprint, comparing planned vs actual.
- **Project retrospectives:** Cost analysis across sessions, identifying resource-intensive phases.

### Reporting Format

Append this block to handoffs or checkpoints when resource tracking is active:

```markdown
## Operational Metrics

- **Session duration:** X hours
- **Bandwidth:** X MB received / X MB sent (vnstat)
- **API tokens:** X tokens consumed
- **Notable transfers:** [large downloads, model pulls, dataset fetches]
```

Not all fields are required every session. Include what is available and relevant.

---

## Project Change Tracking

### Backlog System

Track proposed enhancements, project definitions, and ideas in `plan/backlog/`:

```
project/
└── plan/
    └── backlog/
        ├── developments/                     # External project definitions
        │   ├── BACKLOG-001_project-name.md   # Repos that follow DSM
        │   └── BACKLOG-002_tool-name.md
        ├── improvements/                     # Internal DSM enhancements
        │   ├── BACKLOG-003_new-section.md    # New sections, templates, standards
        │   └── BACKLOG-004_enhancement.md
        └── done/
            └── BACKLOG-000_completed.md      # Implemented
```

**Classification:**
- **Developments:** External project definitions, new repositories/tools that follow DSM, contribute feedback, and extend the ecosystem
- **Improvements:** Internal enhancements to methodology documents, new sections, templates, standards

**Backlog Item Template:**
```markdown
# BACKLOG-###: [Title]

**Status:** Proposed | In Progress | Implemented
**Priority:** High | Medium | Low
**Date Created:** YYYY-MM-DD
**Origin:** [Where this idea came from]

## Problem Statement
[What gap or need does this address]

## Proposed Solution
[How to address it]

## Expected Outcome
[What success looks like]
```

**Workflow:**
- Create backlog items when ideas arise
- Prioritize during sprint planning
- When implementing: follow Version Update Workflow (update CHANGELOG, README, relevant docs)
- Move to `done/` folder when implemented
- Update Status to "Implemented" with Date Implemented

### Archive Pattern

Store completed/obsolete planning documents in `plan/archive/`:
- Planning docs for completed work
- Superseded analyses
- Old session checkpoints

Keep in `plan/` root: Active reference docs (gap analyses, roadmaps)

### Changelog Maintenance

Maintain `CHANGELOG.md` in project root using [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- [New feature] (BACKLOG-###)

### Changed
- [Modification]

### Fixed
- [Bug fix]
```

Update changelog with each release, referencing backlog items.

### Git Tagging Convention

| Tag Type | Format | When to Use |
|----------|--------|-------------|
| Release | `vX.Y.Z` | Feature/content releases |
| Checkpoint | `vX.Y.Z-checkpoint` | Post-release cleanup, docs fixes |

**Semantic Versioning:**
- MAJOR (X): Breaking changes or major redesign
- MINOR (Y): New features, backward compatible
- PATCH (Z): Bug fixes, documentation updates

**Version Bump Cadence:**

| Trigger | Version Bump | Tag Required? |
|---------|-------------|---------------|
| 3+ backlog improvements implemented in a session | Patch (x.y.Z) | Yes |
| Repository organization or housekeeping only | Patch (x.y.Z) | Optional |
| New DSM section or methodology track | Minor (x.Y.0) | Yes |
| Breaking change to methodology structure | Major (X.0.0) | Yes |

**Rules:**
- Batch backlog implementations per session; one version bump per session
- Always update CHANGELOG before tagging
- Always create a git tag for content releases
- Do not create one version per backlog item; group related changes

### Version Update Workflow

1. Make changes to methodology files (DSM_1 through DSM_4)
2. Validate alignment across root documents:
   - DSM_0: Update section descriptions and version references
   - DSM_0.1: Update if naming conventions changed
   - DSM_0.2 (Custom Instructions): Update if workflows, protocols, or instructions changed
   - README.md: Update version info and relevant sections
   - CHANGELOG.md: Add version entry with backlog references (BACKLOG-###)
3. Update line counts if significant additions
4. Run `python scripts/document_structure_metrics.py --update` to record structural snapshot
5. Commit with descriptive message
6. Create git tag: `git tag -a vX.Y.Z -m "Description"`
7. Push commits and tags: `git push && git push --tags`
8. Post-push audit: verify all root files are consistent with changes

### Backlog Priorities

| Priority | When to Use | Action Timeline |
|----------|-------------|-----------------|
| High | Addresses significant gap, blocks other work | Next sprint |
| Medium | Valuable enhancement, can wait | When capacity allows |
| Low | Nice to have, future consideration | Backlog review |

---

## File Naming Standards

**Notebooks:**
- Working development: `sYY_dXX_PHASE_description.ipynb` (e.g., `s01_d01_EDA_data_quality.ipynb`)
- Final deliverables: `XX_PHASE_description.ipynb` (e.g., `01_EDA_data_quality_cohort.ipynb`)
- Consolidation occurs in Phase 4 (Sprint 4)

See Collaboration Methodology for complete naming conventions.
---

## Template Reference

**Filename Convention:**
`<ProjectName>_ProjectPlan_<Phase>.md`
Example: `CustomerChurn_ProjectPlan_Sprint1.md`

**Author Section:**
```
**Prepared by:** [Your Name]
**Timeline:** [Sprint/Phase/Duration]
**Next Phase:** [Next Planned Stage]
```
