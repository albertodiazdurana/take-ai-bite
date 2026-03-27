# DSM 2.0 Module A: Foundation Planning Templates

**Parent document:** DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md
**Scope:** Templates 1-4, the foundation planning templates for daily task
breakdown, phase summaries, expected outcomes, and phase prerequisites.

This module contains the four foundation templates used during project planning
and phase transitions. These templates apply to all project types and provide
the standard formats for organizing sprint/daily project plans.

## Contents

| § | Section | Description |
|---|---------|-------------|
| 1 | [Template 1: Daily Task Breakdown Format](#1-template-1-daily-task-breakdown-format) | Break each day into timed parts with clear objectives |
| 2 | [Template 2: Phase Summary Format](#2-template-2-phase-summary-format) | Standardized summaries at end of each day/phase |
| 3 | [Template 3: Expected Outcomes Table Format](#3-template-3-expected-outcomes-table-format) | Quantify expected results with before/after comparisons |
| 4 | [Template 4: Phase Prerequisites Format](#4-template-4-phase-prerequisites-format) | Define clear handoff criteria between phases |

---

## 1. Template 1: Daily Task Breakdown Format

Break each day into timed parts with clear objectives and deliverables. This
template provides the most granular level of task planning, suitable for daily
work organization within a sprint.

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
**Objective:** Set up development environment and validate toolchain
**Activities:**
- Install required dependencies
- Verify external service connectivity (if applicable)
- Create project folder structure
**Deliverables:**
- Working development environment
- Verified external connections
- Project directory structure

#### Part 1: Input Inventory (1 hour)
**Objective:** Document available inputs and their structure
**Activities:**
- Catalog input sources (datasets, APIs, documents, repositories)
- Document structure and formats
- Identify dependencies between inputs
**Deliverables:**
- Input inventory report
- Structure documentation
```

---

## 2. Template 2: Phase Summary Format

Provide standardized summaries at end of each day/phase showing time allocation
and achievements. Use this template to document what was accomplished, what
issues arose, and whether prerequisites for the next phase are met.

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

## 3. Template 3: Expected Outcomes Table Format

Quantify expected results with before/after comparisons and measurable
improvements. This template helps set clear expectations and provides a
framework for evaluating whether targets were met.

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
| Source files      | 15 files         | 6 files         | -60%              | Yes             |
| Total lines       | ~7,000           | ~3,200          | -54%              | Yes             |
| Code duplication  | High             | Minimal         | N/A               | Yes             |
| Avg file size     | Variable         | 400-650 lines   | Standardized      | Yes             |
| **Summary**       | **15 files**     | **6 files**     | **60% reduction** | **4/4 targets** |

### Key Benefits:
- Easier code review and maintenance
- Consistent structure across all deliverables
- Professional repository organization
- Better modularity for iteration
```

---

## 4. Template 4: Phase Prerequisites Format

Define clear handoff criteria between phases to ensure readiness. This template
prevents premature phase transitions by making readiness conditions explicit and
checkable.

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
## Phase 2 Prerequisites (Implementation)

### Required Inputs:
- [ ] Validated input artifacts from Phase 1 (documented, reviewed)
- [ ] Acceptance criteria defined for Phase 2 deliverables
- [ ] Quality report from Phase 1 showing all checks passed

### Completion Criteria:
- [ ] All Phase 1 deliverables reviewed and accepted
- [ ] No blocking issues in critical artifacts
- [ ] Phase 1 outputs integrated and accessible

### Quality Checks:
- [ ] Artifact formats validated
- [ ] Automated checks passing (tests, linters, validators)
- [ ] No duplicate or conflicting outputs

### Deliverables Ready:
- [ ] Phase 1 artifacts executable/buildable without errors
- [ ] Phase 1 documentation complete and reviewed
- [ ] Validated outputs ready for Phase 2 consumption

### Next Phase Readiness:
After completing Phase 1, you will have:
- Validated, reviewed artifacts ready for implementation
- Understanding of inputs, constraints, and patterns
- Documented quality decisions and assumptions
```
