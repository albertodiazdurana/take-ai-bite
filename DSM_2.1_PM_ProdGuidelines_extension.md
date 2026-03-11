# Production Guidelines Extension for Data Science Projects

**Extends:** `2_ProjectManagement_Guidelines_v2.md`  
**Purpose:** This document contains production-specific guidance for enterprise and team-based data science projects. Use this extension in conjunction with the main Guidelines document for production environments.

**When to use:**
- Enterprise/production projects with formal governance
- Multi-person teams requiring role clarity (RACI matrices)
- Projects with regulatory compliance requirements (GDPR, audit trails)
- Formal QA and peer review processes
- Risk management and stakeholder reporting needs

**For academic or individual projects:** Use only `2_ProjectManagement_Guidelines_v2.md`

---

---

## Project Governance and Roles

Each project must define clear ownership and communication lines.

| Role                      | Responsibility                                                        |
| ------------------------- | --------------------------------------------------------------------- |
| **Project Lead**          | Oversees delivery, scope, and stakeholder communication.              |
| **Data Owner**            | Ensures data access, quality, and compliance with security standards. |
| **Model Owner / Analyst** | Develops models, validates results, and maintains code quality.       |
| **Reviewer / QA**         | Performs peer review of code, documentation, and analysis.            |
| **Stakeholders**          | Approve deliverables and validate business outcomes.                  |

Include a **RACI matrix** (Responsible, Accountable, Consulted, Informed) for all major activities to clarify accountability.

**RACI Matrix Template:**

| Activity / Deliverable | Project Lead | Data Owner | Model Owner | Reviewer | Stakeholders |
|------------------------|--------------|------------|-------------|----------|--------------|
| Data acquisition       | A            | R          | C           | I        | I            |
| Data quality validation| A            | C          | R           | C        | I            |
| Feature engineering    | A            | I          | R           | C        | I            |
| Model development      | A            | I          | R           | C        | I            |
| Model validation       | A            | I          | R           | R        | C            |
| Final presentation     | R            | C          | C           | I        | A            |

**Legend:**
- **R** = Responsible (does the work)
- **A** = Accountable (final decision maker)
- **C** = Consulted (input required)
- **I** = Informed (kept updated)

---

## Data Management and Versioning

All datasets, transformations, and intermediate outputs must be version-controlled and traceable.

**Data Versioning Requirements:**
- Each dataset must include metadata: version number, source, extraction date, and responsible owner
- Data transformations must be scripted (no manual adjustments)
- Intermediate datasets must be timestamped (e.g., `cleaned_20250116.csv`)
- Sensitive or personal data handling must follow legal and ethical standards (e.g., GDPR)
- Storage must occur in secure, centralized repositories (not local devices)
- Backups and archival versions must be maintained for auditability

**Dataset Naming Convention:**
```
{dataset_name}_{version}_{date}.{ext}

Examples:
- customer_data_v2_20250116.csv
- features_engineered_v3_20250120.pkl
- model_predictions_v1_20250125.parquet
```

**Metadata Template:**
```markdown
## Dataset: [Name]
- **Version:** [X.Y]
- **Source:** [Database/API/File location]
- **Extraction Date:** YYYY-MM-DD
- **Owner:** [Name/Team]
- **Record Count:** [N rows]
- **Quality Issues:** [None / List issues]
- **Transformations Applied:** [List or reference to script]
```

### Environment Versioning

**Requirements:**
- Pin package versions for production deployment
- Document Python version compatibility
- Track environment changes in version control
- Test environment reproduction before handoff

**Files to Version Control:**
- `requirements_base.txt`
- `requirements_domain.txt` or `requirements_full.txt`
- `setup_base_environment.py`
- `setup_domain_extensions.py` (if generated)
- `.vscode/settings.json`

**DO NOT Version Control:**
- `.venv/` directory (add to .gitignore)
- `__pycache__/` directories
- Compiled Python files (`.pyc`)

**Environment Handoff Checklist:**
- [ ] All package versions pinned in requirements files
- [ ] Python version documented (e.g., `Python 3.11.5`)
- [ ] Environment successfully reproduced on clean machine
- [ ] All notebooks run without import errors
- [ ] External dependencies documented (databases, APIs, credentials)

---

## Quality Assurance and Peer Review

Every deliverable must pass a formal quality review before sign-off.

**QA Process:**
- **Code Review:** Ensure compliance with internal coding standards and modularization principles
- **Reproducibility Check:** Confirm outputs can be regenerated using provided code and parameters
- **Result Validation:** Compare results against expected benchmarks or business rules
- **Documentation Review:** Verify that every assumption, transformation, and limitation is recorded

**QA Checklist Template:**

```markdown
## Phase [X] Quality Assurance Checklist

### Code Quality
- [ ] Code follows team style guide (PEP 8 for Python)
- [ ] Functions have docstrings with input/output specifications
- [ ] No hard-coded paths or credentials
- [ ] Error handling implemented for critical operations
- [ ] Code is modular (functions <50 lines, notebooks <500 lines per section)

### Reproducibility
- [ ] All random seeds set and documented
- [ ] All data sources accessible and versioned
- [ ] All notebooks run end-to-end without errors
- [ ] Results match documented outputs (within tolerance)
- [ ] Environment requirements complete and tested

### Results Validation
- [ ] Output metrics within expected ranges
- [ ] Business logic validation passed
- [ ] Edge cases tested and documented
- [ ] Statistical significance confirmed (if applicable)
- [ ] Visual outputs reviewed for accuracy

### Documentation
- [ ] README complete with setup instructions
- [ ] Data dictionary up to date
- [ ] Decision log includes all major choices
- [ ] Assumptions explicitly documented
- [ ] Limitations and risks identified

### Approval
- **Reviewer:** [Name]
- **Review Date:** [YYYY-MM-DD]
- **Status:** [Pass / Pass with comments / Fail]
- **Sign-off:** [Signature/Initials]
```

**Peer Review Process:**
1. Developer completes work and self-reviews using checklist
2. Submits pull request or shares notebooks for review
3. Reviewer performs line-by-line code review
4. Reviewer runs reproducibility check
5. Reviewer validates results against business requirements
6. Reviewer provides feedback (approve / request changes)
7. Developer addresses feedback and resubmits
8. Reviewer approves and documents sign-off

---

## Risk Management

Projects must proactively identify and manage potential risks.

**Risk Management Framework:**
- **Risk Identification:** Data unavailability, resource limits, modeling issues, or time constraints
- **Classification:** Each risk categorized by **likelihood** (High/Medium/Low) and **impact** (High/Medium/Low)
- **Mitigation Plan:** Define preventive and contingency measures for each critical risk
- **Ownership:** Assign responsible individuals for monitoring and resolution
- **Review Cycle:** Update risk log each sprint or at each major milestone

**Risk Register Template:**

| Risk ID | Description | Likelihood | Impact | Priority | Mitigation Strategy | Owner | Status |
|---------|-------------|------------|--------|----------|---------------------|-------|--------|
| R-001 | Data source unavailable after cutoff | Medium | High | Critical | Establish backup data source, daily availability checks | Data Owner | Active |
| R-002 | Model performance below threshold | Medium | High | Critical | Baseline model ready, multiple algorithms tested | Model Owner | Mitigated |
| R-003 | Key team member unavailable | Low | Medium | Medium | Cross-training, documentation up to date | Project Lead | Monitored |
| R-004 | Compute resources insufficient | Low | Medium | Medium | Cloud scaling plan, budget pre-approved | Project Lead | Monitored |

**Risk Prioritization Matrix:**

|            | **Low Impact** | **Medium Impact** | **High Impact** |
|------------|----------------|-------------------|-----------------|
| **High Likelihood** | Medium | High | Critical |
| **Medium Likelihood** | Low | Medium | High |
| **Low Likelihood** | Low | Low | Medium |

**Risk Review Cadence:**
- **Per Sprint:** Review all active and critical risks during team sync
- **Phase transitions:** Full risk register review before moving to next phase
- **Trigger events:** Immediate review when risk materializes or new risks identified
- **Documentation:** All risk decisions logged in decision log

---

## Communication and Reporting Standards

To maintain transparency and alignment across technical and business teams:

**Sprint Progress Summary Template:**

```markdown
## Sprint [X] Progress Summary
**Project:** [Name]
**Date:** [YYYY-MM-DD]
**Submitted by:** [Name]

### Completed This Sprint
- [Task 1]: [Brief description and outcome]
- [Task 2]: [Brief description and outcome]
- [Task 3]: [Brief description and outcome]

### Key Metrics
- [Metric 1]: [Value] (Target: [X])
- [Metric 2]: [Value] (Target: [Y])
- [Metric 3]: [Status]

### Issues & Blockers
- **Issue 1:** [Description]
  - **Impact:** [How it affects timeline/scope]
  - **Mitigation:** [Action taken]
  - **Owner:** [Name]
  - **Status:** [Open/Resolved]

### Next Sprint Plan
- [Task 1]: [Expected completion date]
- [Task 2]: [Expected completion date]
- [Task 3]: [Expected completion date]

### Risks & Concerns
- [Risk 1]: [Brief description]
- [Ask/Decision needed]: [What you need from stakeholders]
```

**Reporting Best Practices:**
- Maintain a **sprint progress summary** capturing completed work, issues, and next steps
- Visual results (charts, tables) should emphasize clarity and interpretability
- Executive summaries should highlight actionable insights, not implementation details
- Store reports, meeting notes, and presentations in a centralized `/docs` directory
- Use consistent naming conventions for reports (e.g., `Sprint3_Model_Evaluation_Report.pdf`)

**Stakeholder Communication Matrix:**

| Stakeholder Type | Frequency | Format | Content Focus |
|------------------|-----------|--------|---------------|
| Executive Sponsor | Monthly | Executive summary (1 page) | Business impact, ROI, key decisions |
| Project Sponsor | Per Sprint | Progress report (2-3 pages) | Milestones, blockers, budget |
| Technical Lead | Daily/As needed | Slack/Email | Technical issues, code reviews |
| Business Users | Bi-weekly | Demo + slides | Feature walkthrough, feedback collection |
| QA/Compliance | Phase completion | Detailed report | QA checklist, audit trail |

**Escalation Path:**
1. **Level 1:** Team member >Project Lead (blockers, technical issues)
2. **Level 2:** Project Lead >Project Sponsor (scope, timeline, resource issues)
3. **Level 3:** Project Sponsor >Executive Sponsor (strategic decisions, budget)

---

## Post-Project Review

At the conclusion of each project phase or full engagement:

**Retrospective Framework:**
- Document **lessons learned**, challenges, and successful approaches
- Identify **reusable assets** (e.g., feature libraries, preprocessing scripts, visualizations)
- Archive all notebooks, datasets, and outputs in versioned storage
- Conduct a short **retrospective meeting** to propose improvements for future cycles

**Post-Project Review Template:**

```markdown
## Post-Project Review: [Project Name]
**Date:** [YYYY-MM-DD]  
**Participants:** [List names and roles]  
**Phase/Project:** [Phase X / Full Project]

### Objectives Review
**Original Objectives:**
1. [Objective 1]
2. [Objective 2]

**Achievement Status:**
1. [Objective 1]: [Achieved/Partially achieved/Not achieved] - [Explanation]
2. [Objective 2]: [Achieved/Partially achieved/Not achieved] - [Explanation]

### What Went Well
1. [Success 1]: [Why it worked, what we can repeat]
2. [Success 2]: [Why it worked, what we can repeat]
3. [Success 3]: [Why it worked, what we can repeat]

### What Could Be Improved
1. [Challenge 1]: [What happened, why, how to prevent next time]
2. [Challenge 2]: [What happened, why, how to prevent next time]
3. [Challenge 3]: [What happened, why, how to prevent next time]

### Metrics Summary
| Metric | Target | Actual | Variance |
|--------|--------|--------|----------|
| Timeline | [X sprints] | [Y sprints] | [+/- Z%] |
| Budget | [X hours] | [Y hours] | [+/- Z%] |
| Quality | [Target score] | [Actual score] | [+/- Z%] |

### Reusable Assets Created
- **Code libraries:** [List with locations]
- **Feature engineering patterns:** [List with references]
- **Visualizations/templates:** [List with locations]
- **Documentation templates:** [List with references]

### Action Items for Future Projects
1. [Action 1]: [Owner] - [Due date]
2. [Action 2]: [Owner] - [Due date]
3. [Action 3]: [Owner] - [Due date]

### Recommended Process Changes
- [Change 1]: [What to change and why]
- [Change 2]: [What to change and why]

### Archive Locations
- **Code repository:** [URL/path]
- **Dataset storage:** [URL/path]
- **Documentation:** [URL/path]
- **Presentations:** [URL/path]

### Signatures
- **Project Lead:** [Name] - [Date]
- **Project Sponsor:** [Name] - [Date]
- **Team Members:** [Names] - [Date]
```

**Post-Review Actions:**
1. **Immediate (Within 1 sprint):**
   - Archive all materials in version-controlled storage
   - Document lessons learned in team knowledge base
   - Share reusable assets with broader team

2. **Short-term (Within 1 month):**
   - Update process documentation based on learnings
   - Implement quick-win improvements for next project
   - Schedule follow-up on action items

3. **Long-term (Quarterly):**
   - Review aggregated learnings across multiple projects
   - Update templates and guidelines
   - Propose systematic process improvements

---

## Integration with Main Guidelines

**How to use this extension with the main document:**

1. **Planning Phase:**
   - Use main Guidelines templates (1-5) for daily/sprint planning
   - Add RACI matrix from this extension for role clarity
   - Incorporate risk register from this extension

2. **Execution Phase:**
   - Follow main Guidelines workflow and deliverables
   - Apply QA checklist from this extension at phase completion
   - Maintain sprint progress reports per this extension's format

3. **Documentation Phase:**
   - Use main Guidelines documentation standards
   - Add data versioning requirements from this extension
   - Include environment versioning per this extension

4. **Review Phase:**
   - Apply main Guidelines success criteria
   - Conduct post-project review per this extension's template
   - Archive per this extension's requirements

**Quick Reference:**

| Project Type | Use Main Guidelines | Use Extension |
|--------------|---------------------|---------------|
| Academic/Individual | Yes | No |
| Small team (2-3 people) | Yes | Optional (RACI, QA) |
| Enterprise/Production | Yes | Yes (All sections) |
| Regulated industry | Yes | Yes (Especially versioning, QA, audit) |

---

**End of Production Guidelines Extension**

**Version:** 1.0  
**Last Updated:** 2025-11-12  
**Maintained by:** [Your Name/Team]
