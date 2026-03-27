# DSM 2.0 Module B: Advanced Planning and Priority Framework

**Parent document:** DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md
**Scope:** Templates 5-7 (checkpoint, progressive outcomes, priority framework),
Version 2.0 planning enhancements (risk management, communication, decision tree,
best practices, integration guidance).

This module contains the Version 2.0 planning enhancements for complex, multi-day
phases with uncertain scope. Use these templates when daily reflection and
mid-course correction add value, particularly during first-time execution of
unfamiliar work or phases prone to scope creep.

## Contents

| § | Section | Description |
|---|---------|-------------|
| 1 | [Version 2.0 Planning Framework Overview](#1-version-20-planning-framework-overview) | When and why to use enhanced planning |
| 2 | [Template 5: Daily Checkpoint Framework](#2-template-5-daily-checkpoint-framework) | Systematic daily review for drift detection |
| 3 | [Template 6: Progressive Expected Outcomes Table](#3-template-6-progressive-expected-outcomes-table) | Incremental progress tracking across multi-day phases |
| 4 | [Template 7: MUST/SHOULD/COULD Priority Framework](#4-template-7-mustshouldcould-priority-framework) | Structured prioritization for scope management |
| 5 | [Enhanced Risk Management for V2.0 Plans](#5-enhanced-risk-management-for-v20-plans) | Additional risk considerations for enhanced planning |
| 6 | [Communication Plan Enhancement for V2.0](#6-communication-plan-enhancement-for-v20) | Daily checkpoint communication structure |
| 7 | [Decision Tree: V1.0 vs V2.0 Planning](#7-decision-tree-v10-vs-v20-planning) | When to use standard vs enhanced planning |
| 8 | [Version 2.0 Best Practices](#8-version-20-best-practices) | Practical guidance for effective enhanced planning |
| 9 | [Integration with Existing Plan Templates](#9-integration-with-existing-plan-templates) | Where to add V2.0 elements in project plans |

---

## 1. Version 2.0 Planning Framework Overview

This section introduces the enhanced planning framework and defines when it
should be applied. The core principle is structured daily reflection to enable
agile adaptation and maintain progress visibility.

**When to use Version 2.0 planning:**
- First time executing a complex phase with uncertain scope
- Phases prone to scope creep (exploration, prototyping, research)
- When daily reflection and mid-course correction add value
- Multi-day phases where early drift detection matters

---

## 2. Template 5: Daily Checkpoint Framework

Enable systematic daily review to detect drift, adjust scope, and maintain
progress visibility. This is the most comprehensive template in the V2.0
framework, providing structure for all aspects of daily reflection.

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

**Data/Artifacts:**
- `path/to/artifact` ([size], [format description])

**Visualizations/Figures:**
- `path/to/figure.png` (description)

**Documentation:**
- `path/to/document.md` (purpose)

**Code/Scripts:**
- `path/to/file` ([lines] lines, [description])

---

**Checkpoint completed by:** [Name]
**Next checkpoint:** Day [X+1], [Date]
```

**Filename Convention:** `sXX_dXX_checkpoint.md` (e.g., s01_d03_checkpoint.md)

**Location:** `dsm-docs/checkpoints/` or `dsm-docs/plans/`

**Benefits of Daily Checkpoints:**
- Enables recovery if session interrupted
- Tracks progress systematically
- Documents decisions as they are made
- Identifies issues early
- Provides foundation for handoff documents

---

## 3. Template 6: Progressive Expected Outcomes Table

Track incremental progress across multi-day phases to enable early drift
detection and scope adjustment. Use this template for phases lasting 3+ days
with clear mid-phase milestones.

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

**Example: 5-day Implementation Phase**
```markdown
## Expected Outcomes

| Metric             | Before Sprint 2        | After Days 1-2               | After Sprint 2 (Days 3-5)   | Target Met      |
| ------------------ | ---------------------- | ---------------------------- | ---------------------------- | --------------- |
| Components built   | 3 modules              | 3 + 4 (core modules)         | 12-14 modules                | Yes             |
| Core deliverables  | 0                      | 4 complete                   | 4 validated                  | Yes             |
| Extended scope     | 0                      | 0 (planned Days 3-5)         | 5-7 complete                 | Yes             |
| Stretch items      | 0                      | 0                            | 0-2 complete                 | Conditional     |
| **Summary**        | **Baseline state**     | **Core milestone reached**   | **Phase-complete delivery**  | **3/3 targets** |

### Key Benefits
- Early detection of scope issues (after Day 2 review)
- Mid-phase adjustment based on milestone achievement
- Clear go/no-go decision point before extended work
```

---

## 4. Template 7: MUST/SHOULD/COULD Priority Framework

Structured prioritization to prevent "everything is important" paralysis and
enable clear scope reduction decisions. Use this template for complex phases
with more than 10 deliverables, risk of scope creep, or uncertain capacity.

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
- Experimental or "nice to have"
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
- If on track with scope: Full scope (MUST + SHOULD + COULD)
- If 10-20% behind on scope: MUST + SHOULD only
- If >20% behind on scope: MUST only, document deferred work
```

**Example:**
```markdown
## Success Criteria - Structured by Priority

**MUST Deliverables (4 total - Non-negotiable):**
- [ ] Input validation complete (format checks, integrity, completeness)
- [ ] Core components implemented (primary modules, base functionality)
- [ ] Primary outputs generated (reports, artifacts, test results)
- [ ] Validated artifacts exported for next phase

**SHOULD Deliverables (6 total - Complete if on schedule):**
- [ ] Extended analysis or coverage (edge cases, secondary scenarios)
- [ ] Integration verification (cross-component, end-to-end)
- [ ] External dependency validation (APIs, services, data sources)
- [ ] Enhanced outputs (detailed reports, additional visualizations)
- [ ] Preliminary performance assessment
- [ ] Comprehensive decision log with rationale

**COULD Deliverables (3 total - Only if ahead):**
- [ ] Alternative approach comparison (method A vs method B vs method C)
- [ ] Extended coverage analysis (additional inputs, broader scope)
- [ ] Optimization or refinement pass

**Contingency Rules:**
- If on schedule after Day 2: Full scope (13 deliverables)
- If 10-20% behind after Day 2: MUST + SHOULD only (10 deliverables)
- If >20% behind after Day 2: MUST only (4 deliverables), document deferred
```

---

## 5. Enhanced Risk Management for V2.0 Plans

Additional risks to consider when using the V2.0 framework. These supplement
any project-level risk assessment with planning-specific risks.

| Risk                                             | Likelihood | Impact | Mitigation                                                   |
| ------------------------------------------------ | ---------- | ------ | ------------------------------------------------------------ |
| **Scope creep during exploration**               | Medium     | Medium | Daily checkpoints maintain MUST/SHOULD/COULD discipline      |
| **Interesting findings trigger scope expansion** | Medium     | Medium | Defer deep dives to future phases, document for later        |
| **Checkpoint fatigue in long phases**            | Low        | Medium | Reduce frequency after Sprint 1, maintain at key milestones  |

---

## 6. Communication Plan Enhancement for V2.0

Add this subsection to existing communication plans when using V2.0 planning.
It formalizes the daily checkpoint as a communication artifact.

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

## 7. Decision Tree: V1.0 vs V2.0 Planning

This section helps determine which planning level is appropriate for a given
phase or sprint.

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

## 8. Version 2.0 Best Practices

Practical guidance for making the most of the V2.0 planning framework without
introducing unnecessary overhead.

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

## 9. Integration with Existing Plan Templates

This section maps V2.0 elements to the standard project plan sections, showing
where each enhancement fits within the existing template structure.

**Section 3 (Timeline):**
- Define milestones and checkpoints

**Section 4 (Deliverables):**
- Add end-of-day checkpoint questions after each day (Template 10, Module C)

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

**Summary:** Version 2.0 planning adds structured daily discipline through
checkpoints, progressive tracking, and priority tiers to enable agile
adaptation in complex, multi-day phases with uncertain scope.

**When in doubt:** Use v2.0 for critical phases and first-time work; revert to
v1.0 once confidence is established.
