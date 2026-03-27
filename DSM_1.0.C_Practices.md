# DSM 1.0 Module C: Essential and Advanced Practices

**Parent document:** `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Module scope:** Section 4 (Essential Practices, Tier 1) + Section 5 (Advanced Practices, Tiers 2-4)

---

# 4. Essential Practices (Tier 1 - Always Use)

## 4.1. Decision Log Framework

### 4.1.1. When to Log Decisions

**Always Document:**
- Cohort definition choices (inclusion/exclusion criteria)
- Feature engineering approaches (why specific calculations)
- Model/algorithm selection (why this approach)
- Pivot decisions (changing direction based on data)
- Data quality compromises (accepting limitations)
- Stakeholder-driven changes (requirement modifications)

**Key Principle:** If you'll need to explain it to stakeholders or justify it later, log it now.

### 4.1.2. Decision Log Template

```markdown
## Decision [ID]: [Brief Title]

**Date:** YYYY-MM-DD
**Phase:** [0-4]
**Decision Maker:** [Your name, stakeholder name]
**Status:** [Proposed | Approved | Implemented | Revised]

### Context
Brief background on the situation requiring a decision.
What prompted this decision? What were we trying to solve?

### Options Considered
1. **Option A:** Description
   - Pros: ...
   - Cons: ...

2. **Option B:** Description
   - Pros: ...
   - Cons: ...

3. **Option C:** Description (Selected)
   - Pros: ...
   - Cons: ...

### Decision
Clear statement of what was decided.

### Rationale
Why this option was chosen over alternatives.
- Evidence from data
- Stakeholder input
- Technical constraints
- Business priorities

### Implementation
How the decision was executed.
- Code changes
- Process adjustments
- Communication to stakeholders

### Impact
Results of the decision.
- What changed?
- Was it successful?
- Lessons learned

### Related Decisions
Links to other decisions that informed or were informed by this one.
```

### 4.1.3. Implementation Guidelines

**File Location:**
- `dsm-docs/decision_log.md` in project root
- Or separate file: `dsm-docs/DEC-[ID]_[title].md` for complex decisions

**Decision Numbering:**
- Sequential: DEC-001, DEC-002, DEC-003...
- Phase-based: DEC-P1-001, DEC-P2-001... (optional)

**Timing:**
- Log decisions when made, not retroactively
- Update status as decision progresses
- Revisit if decision needs revision

**Linking:**
- Reference decision IDs in notebooks
- Cross-reference related decisions
- Link to relevant code/data files

### 4.1.4. Decision Log Example

**Illustrative Decision Log Entry:**

```markdown
## Decision DEC-003: Deviate from Initial Stakeholder Specification

**Date:** [Date]
**Phase:** 3 (Analysis)
**Decision Maker:** The analyst, with stakeholder approval
**Status:** Approved & Implemented

### Context
Initial requirement specified N segments. Statistical analysis revealed
evidence for fewer natural groupings.

### Options Considered
1. **Force N (as requested):** Matches requirement, but weak statistical support
2. **Use M (statistical optimum):** Strong validation metrics, clear separation
3. **Compromise (N-1):** Closer to expectation, but still weak support

### Decision
Proceed with M based on statistical evidence. Adapted delivery strategy to
map business requirements across M segments.

### Rationale
- Statistical validity: strongest validation metrics at M
- Business alignment: can still address all business requirements with M segments
- Data-driven: let data guide the analysis, not predetermined expectations
- Stakeholder buy-in: obtained after presenting statistical evidence

### Impact
- Clear, actionable results that stakeholders could act on
- Demonstrates value of data-driven pivots over rigid requirements
```

**Key Takeaway:** Decision logs enable clear stakeholder communication about why the analysis deviated from initial requirements.

### 4.1.5. Hypothesis Testing with Rejection Protocol

**Core Principle:** Design experiments that CAN fail, document negative results as valuable findings.

**Why This Matters:** A rejected hypothesis can be one of the most valuable findings in a project. For example, discovering that more training data actually degrades performance teaches a principle (temporal consistency matters more than volume) that improves all future work.

**Why This Matters:**
- Confirmation bias leads to only testing hypotheses we expect to succeed
- Negative results are scientifically valuable but often undocumented
- Explicit rejection criteria prevent "massaging" results to fit expectations
- Documenting failures prevents repeating mistakes

**Hypothesis Registration Template:**

```markdown
## HYPOTHESIS: [Clear, falsifiable statement]

**Registered:** [Date]
**Status:** TESTING / CONFIRMED / REJECTED

### Pre-Registration

**Hypothesis Statement:**
[Specific, testable claim - e.g., "Using additional training data will improve forecast accuracy"]

**Expected Outcome:**
[What you expect to see if hypothesis is true]
- Metric: [e.g., RMSE, F1, accuracy]
- Expected direction: [e.g., decrease by >5%]
- Baseline: [current metric value with current approach]

**Rejection Criteria (define BEFORE testing):**
- Reject if: [e.g., primary metric degrades by >10%]
- Reject if: [e.g., model fails to converge]
- Reject if: [e.g., validation metrics degrade]

**Test Design:**
- Data split: [training/validation/test]
- Metrics: [primary and secondary]
- Comparison: [baseline vs. experimental]

### Results

**Actual Outcome:**
[Fill after testing]
- Metric value: [actual result]
- vs Expected: [comparison]
- Statistical significance: [if applicable]

**Verdict:** CONFIRMED / REJECTED

### Post-Mortem (if rejected)

**Why Did This Fail?**
[Root cause analysis]

**What Did We Learn?**
[Valuable insight from failure]

**How Does This Change Our Approach?**
[Next steps based on finding]
```

**Illustrative Example:**

A hypothesis that "more training data improves performance" was tested and REJECTED when the expanded dataset degraded the primary metric by over 100%. The post-mortem revealed that data relevance (temporal, domain, or distributional alignment) matters more than volume. This rejection led to a new principle that improved all subsequent modeling decisions.

The template above captures this workflow: pre-registration prevents post-hoc rationalization, the rejection criteria make failure explicit, and the post-mortem extracts the generalizable lesson.

**Best Practices:**

1. **Pre-register rejection criteria** - Define what constitutes failure BEFORE running tests
2. **Document ALL hypotheses tested** - Not just the ones that succeeded
3. **Treat rejections as findings** - Failed hypotheses teach as much as successful ones
4. **Link related decisions** - Show how rejections led to better approaches
5. **Share negative results** - Include in reports and presentations as methodology validation

**Integration with Decision Log:**
- REJECTED hypotheses become decision log entries with "Status: REJECTED"
- Link rejected decisions to subsequent decisions they informed
- Include rejection count in project summaries (e.g., "Tested 8 hypotheses, confirmed 5, rejected 3")

---

## 4.2. Pivot Criteria & Failure Modes

### 4.2.1. When to Pivot

**Pivot Triggers:**
- Data reveals different patterns than expected
- Initial assumptions proven invalid
- Stakeholder requirements change
- Technical constraints emerge
- Better approach discovered mid-project
- Timeline or resource constraints require scope change

**Signs You Should Consider Pivoting:**
- Forcing data to match predetermined conclusions
- Repeated validation failures
- Stakeholder feedback indicates misalignment
- Key assumptions invalidated
- Better alternative approach emerges

**When NOT to Pivot:**
- Minor setbacks that can be addressed
- Personal preference for different approach
- Incomplete exploration of current approach
- Stakeholder impatience (without technical reason)

### 4.2.2. Pivot Decision Framework

**Step 1: Recognize Signal**
- Validation metrics consistently poor
- Data patterns contradict hypothesis
- Stakeholder priorities shift
- Technical blocker encountered

**Step 2: Assess Impact**
- How significant is the issue?
- Can current approach be salvaged?
- What's the cost of continuing vs. pivoting?
- What's at risk if we don't pivot?

**Step 3: Evaluate Alternatives**
- What other approaches are viable?
- Do we have evidence for alternative?
- What's the effort to pivot?
- What's the expected improvement?

**Step 4: Stakeholder Communication**
- Present evidence for pivot
- Show alternatives and trade-offs
- Get buy-in before proceeding
- Document decision (Section 4.1)

**Step 5: Execute Pivot**
- Update project plan
- Adjust timelines
- Communicate changes
- Proceed with new approach

### 4.2.3. Common Failure Patterns

**Pattern 1: Ignoring Statistical Evidence**
- **Symptom:** Poor validation metrics, but continuing anyway
- **Example:** Continuing with an approach despite weak validation metrics
- **Solution:** Pivot to the statistically supported alternative
- **Prevention:** Establish acceptance criteria upfront

**Pattern 2: Sunk Cost Fallacy**
- **Symptom:** "We've already spent 2 sprints on this approach..."
- **Example:** Continuing with approach that clearly won't work
- **Solution:** Accept losses, pivot to better approach
- **Prevention:** Regular checkpoint reviews with pivot criteria

**Pattern 3: Feature Engineering Rabbit Hole**
- **Symptom:** Creating hundreds of features without validation
- **Example:** 500+ features with unclear business meaning
- **Solution:** Pivot to core features with clear interpretation
- **Prevention:** Start simple, expand only if justified

**Pattern 4: Over-Optimization**
- **Symptom:** Endless tuning for marginal gains
- **Example:** Days spent improving metric by 0.01
- **Solution:** Pivot to next phase when diminishing returns
- **Prevention:** Set "good enough" thresholds upfront

**Pattern 5: Analysis Paralysis**
- **Symptom:** Trying every possible technique before deciding
- **Example:** Testing 10+ algorithms before committing to any
- **Solution:** Pick 2-3 reasonable approaches, choose best
- **Prevention:** Set decision criteria and timeline

### 4.2.4. Recovery Strategies

**When Behind Schedule:**
- Reduce scope to essential deliverables
- Simplify approach (complex → simple)
- Parallel work where possible
- Honest communication with stakeholders

**When Data Quality Issues Emerge:**
- Document limitations clearly
- Adjust analytical scope
- Use available data effectively
- Don't create misleading features to compensate

**When Stakeholder Requirements Change:**
- Assess feasibility with current work
- Negotiate timeline adjustments
- Prioritize new requirements
- Document change in decision log

**When Technical Challenges Arise:**
- Seek alternative approaches
- Simplify technical complexity
- Leverage existing solutions
- Don't reinvent wheel unnecessarily

---

## 4.3. Stakeholder Communication

### 4.3.1. Communication Cadence

**Sprint Updates (Recommended):**
- Progress summary (what was completed)
- Key findings (data insights)
- Decisions made (reference decision log)
- Next sprint plan (clear objectives)
- Blockers or concerns (flag early)

**Phase Completion Updates:**
- Comprehensive phase summary
- Key deliverables review
- Significant decisions and rationale
- Next phase preview
- Timeline check-in

**Ad-Hoc Communications:**
- Pivot decisions (immediate notification)
- Unexpected findings (proactive sharing)
- Data quality issues (early warning)
- Requirement clarifications (as needed)

**Template for Sprint Update:**
```markdown
## [Project Name] - Sprint [N] Update

**Date:** YYYY-MM-DD
**Phase:** [Current Phase]
**Status:** [On Track | Slight Delay | Blocked]

### This Sprint Accomplishments
- Completed [specific tasks]
- Key finding: [insight from data]
- Decision made: [reference DEC-ID]

### Key Insights
- [Data-driven insights]
- [Preliminary findings]
- [Patterns observed]

### Next Sprint Plan
- [Specific objectives]
- [Expected deliverables]
- [Questions for stakeholder]

### Concerns / Blockers
- [Any issues, if none state "None"]
```

### 4.3.2. Update Templates

**Executive Summary Format:**
```markdown
## Executive Summary - [Phase] Complete

**Bottom Line:** [One sentence key takeaway]

**Key Findings:**
1. [Finding with business impact]
2. [Finding with business impact]
3. [Finding with business impact]

**Recommendations:**
1. [Actionable recommendation]
2. [Actionable recommendation]

**Next Steps:**
- [What happens next]
- [Timeline]
```

**Technical Update Format:**
```markdown
## Technical Progress - [Phase]

**Data Status:**
- Cohort: [size, description]
- Features: [count, key features]
- Quality: [assessment]

**Analysis Progress:**
- Approach: [methodology]
- Validation: [metrics, results]
- Findings: [technical details]

**Technical Decisions:**
- [Decision reference with rationale]

**Next Technical Steps:**
- [Specific tasks]
```

### 4.3.3. Technical Translation Guidelines

**Principle:** Stakeholders don't need to understand the how, but must understand the what and why.

**Translation Examples:**

**Technical:** "Algorithm X on N features yielded K groups with validation score 0.38"
**Stakeholder:** "Analysis identified K distinct groups with clear behavioral differences"

**Technical:** "Metric A calculated as ratio of event counts to total observations"
**Stakeholder:** "Measured how likely each entity is to exhibit the target behavior"

**Technical:** "Dimensionality reduction captured 65% of variance in 5 components"
**Stakeholder:** "Simplified N characteristics into 5 key patterns that capture most variation"

**Technical:** "Validation metric improved from 1.8 to 1.2"
**Stakeholder:** "Group separation improved significantly, results are more reliable"

**Guidelines:**
- Replace jargon with plain language
- Focus on business impact, not statistical mechanics
- Use analogies where helpful
- Provide technical details in appendix if requested

### 4.3.4. Multi-Stakeholder Management

**Different Audiences, Different Needs:**

**Executive Leadership:**
- **Focus:** Business impact, ROI, strategic decisions
- **Format:** 1-2 page executive summary, 5-slide deck
- **Language:** Business terms, minimal technical jargon
- **Frequency:** Phase completions, major pivots

**Technical Team:**
- **Focus:** Methodology, reproducibility, code quality
- **Format:** Detailed notebooks, technical reports
- **Language:** Statistical terms, code examples
- **Frequency:** Regular updates, code reviews

**Operational Team:**
- **Focus:** Implementation, actionable insights
- **Format:** Persona descriptions, recommendation lists
- **Language:** Practical examples, clear instructions
- **Frequency:** Final deliverables, Q&A sessions

**Cross-Functional Meetings:**
- **Prepare:** Multiple versions (exec summary + technical details)
- **Start:** High-level findings (everyone understands)
- **Detail:** Available on request (for technical audience)
- **Close:** Clear next steps and ownership

**Example Multi-Level Communication:**
- **Email to stakeholder:** "3 segments identified with distinct behaviors. Recommend targeted interventions for each segment based on their characteristics."
- **Tech Doc:** Complete analysis methodology, validation metrics, code repository link
- **Operational Guide:** "Segment 1: High-value frequent users. Key behaviors and recommended actions for this segment."

---

# 5. Advanced Practices (Tiers 2-4 - Selective Use)

## 5.1. When to Activate Advanced Practices

### 5.1.1. Complexity Assessment

**Use Advanced Practices When:**
- Project has production deployment goals
- Multiple stakeholders with conflicting requirements
- Large-scale data (millions of rows, hundreds of features)
- Novel problem requiring literature review
- High-stakes decisions with significant business impact
- Team environment requiring code standards
- Long-term maintenance expected

**Skip Advanced Practices When:**
- Academic coursework with clear scope
- Exploratory one-time analysis
- Small datasets (<10K rows)
- Well-understood problem domain
- Single stakeholder with clear requirements
- Short timeline (<4 sprints)

### 5.1.2. Selection Criteria

**Tier 2 (Enhanced Analysis):**
- **Activate When:** Multiple model iterations, hypothesis testing needed
- **Examples:** ML projects, comparative studies, research projects
- **Time Investment:** +20-30% project time
- **Practices:** Experiment tracking, hypothesis management, baseline benchmarking

**Tier 3 (Production Preparation):**
- **Activate When:** Production deployment planned, team collaboration
- **Examples:** Deployed models, shared codebases, regulated domains
- **Time Investment:** +40-60% project time
- **Practices:** Testing, ethics/bias review, data versioning

**Tier 4 (Enterprise Scale):**
- **Activate When:** Large teams, long-term projects, technical complexity
- **Examples:** Multi-year projects, novel research, scalable systems
- **Time Investment:** +80-100% project time
- **Practices:** Technical debt management, scalability planning, literature review, risk management

### 5.1.3. Tier System Explanation

**Cumulative Tiers:**
- Tier 2 includes Tier 1 (Essential Practices)
- Tier 3 includes Tier 1 + Tier 2
- Tier 4 includes Tier 1 + Tier 2 + Tier 3

**Example Project Classifications:**

**Academic Analysis Project:**
- **Tier Used:** Tier 1 + selective Tier 2
- **Rationale:** Academic project, no production deployment, clear stakeholder
- **Activated:** Experiment tracking (for model selection), hypothesis management (for validation)
- **Skipped:** Testing, versioning, technical debt, scalability (not needed)

**Production ML System:**
- **Tier Used:** Tier 1 + 2 + 3
- **Rationale:** Deployed model, ongoing maintenance, team collaboration
- **Activated:** All Tier 3 practices for production readiness
- **Skipped:** Tier 4 (unless scaling to millions of users)

### 5.1.4. Activation Guidelines

**Decision Process:**
1. **Start with Tier 1 (Essential):** Always use
2. **Assess Project Complexity:** Use criteria in 5.1.1
3. **Select Tier:** Match project needs
4. **Pick Specific Practices:** Not all practices in tier may be needed
5. **Document Choice:** Note in project plan which practices activated

**Red Flags (You Might Need Higher Tier):**
- "How do we track all these experiments?"
- "We need to deploy this to production."
- "Multiple teams will use this code."
- "This needs to scale to 10M users."
- "No one has solved this problem before."

---

## 5.2. Tier 2 Practices (Enhanced Analysis)

### 5.2.1. Experiment Tracking

**When to Use:**
- Training multiple models with different parameters
- Comparing different feature sets
- Iterating on model architecture
- A/B testing different approaches

**What It Provides:**
- Systematic tracking of model experiments
- Parameter and metric logging
- Comparison of model performance
- Reproducibility of best model

**Key Components:**
- Experiment naming convention
- Parameter logging
- Metric tracking
- Model artifact storage

**Example Use Case:**
Testing multiple model configurations (e.g., hyperparameters, feature sets), tracking primary and secondary metrics, and comparing business interpretability for each variant.

**For complete implementation guidance, see Appendix C.1: Experiment Tracking Implementation.**

### 5.2.2. Hypothesis Management

**When to Use:**
- Research-oriented projects
- Projects with clear hypotheses to test
- Stakeholder expectations need validation
- Claims requiring statistical support

**What It Provides:**
- Structured hypothesis formulation
- Pre-registration of tests (avoid p-hacking)
- Systematic results tracking
- Clear distinction between exploratory and confirmatory analysis

**Key Components:**
- Hypothesis documentation template
- Pre-registration process
- Results tracking
- Statistical test selection

**Example Use Case:**
"H1: High-value users respond differently to intervention X" -- test before implementing the strategy.

**For complete implementation guidance, see Appendix C.2: Hypothesis Management Implementation.**

### 5.2.3. Performance Baseline & Benchmarking

**When to Use:**
- Evaluating model improvements
- Comparing to existing solutions
- Justifying new approach
- Setting success criteria

**What It Provides:**
- Clear performance baseline (naive, simple, existing)
- Meaningful comparison metrics
- Progress tracking over iterations
- Success criteria validation

**Key Components:**
- Baseline establishment (naive, simple model)
- Success criteria definition
- Progress tracking dashboard
- Benchmark selection

**Example Use Case:**
Establish baseline with a naive approach, compare two or three candidate methods, track improvement over iterations.

**For complete implementation guidance, see Appendix C.3: Performance Baseline Implementation.**

---

## 5.3. Tier 3 Practices (Production Preparation)

### 5.3.1. Ethics & Bias Considerations

**When to Use:**
- Models affecting people (hiring, lending, healthcare)
- Sensitive attributes (race, gender, age)
- Regulated industries
- Public-facing applications

**What It Provides:**
- Bias detection in data and models
- Fairness metric evaluation
- Disparate impact analysis
- Mitigation strategies
- Documentation for compliance

**Key Components:**
- Bias audit checklist
- Fairness metrics (demographic parity, equalized odds)
- Privacy assessment
- Ethical review triggers

**Example Use Case:**
Ensuring analysis results don't discriminate based on protected characteristics, validating that recommendations are fair across demographics.

**For complete implementation guidance, see Appendix C.4: Ethics & Bias Implementation.**

### 5.3.2. Testing Strategy

**When to Use:**
- Production deployments
- Team collaboration
- Code reuse across projects
- Long-term maintenance

**What It Provides:**
- Automated validation of data pipelines
- Regression prevention
- Confidence in refactoring
- Documentation through tests

**Key Components:**
- Unit tests for functions
- Integration tests for pipelines
- Data validation tests
- Regression tests

**Example Use Case:**
Test that feature engineering functions produce expected outputs, validate data transformations don't break with new data.

**For complete implementation guidance, see Appendix C.5: Testing Strategy Implementation.**

### 5.3.3. Data Versioning & Lineage

**When to Use:**
- Multiple data versions
- Reproducibility critical
- Regulatory requirements
- Team data sharing

**What It Provides:**
- Track data changes over time
- Reproduce analyses with specific data versions
- Understand data provenance
- Collaboration without conflicts

**Key Components:**
- Versioning strategy (semantic versioning)
- Lineage tracking (data transformations)
- Change logs (what changed, why)
- Reproducibility protocol

**Example Use Case:**
Track `users_v2.0.csv` → `users_v2.1.csv` changes, document why cohort definition changed, enable reproduction of v2.0 analysis.

**For complete implementation guidance, see Appendix C.6: Data Versioning Implementation.**

---

## 5.4. Tier 4 Practices (Enterprise Scale)

### 5.4.1. Technical Debt Register

**When to Use:**
- Long-term projects (>6 months)
- Growing codebase
- Team projects
- Production systems

**What It Provides:**
- Systematic tracking of shortcuts and workarounds
- Prioritization of refactoring
- Prevention of debt accumulation
- Team awareness of code quality issues

**Key Components:**
- Debt documentation template
- Prioritization matrix (impact vs effort)
- Debt tolerance thresholds
- Paydown planning

**Example Use Case:**
"TD-003: Feature engineering code duplicated across 3 notebooks. Impact: High maintenance burden. Plan: Consolidate into shared module."

**For complete implementation guidance, see Appendix C.7: Technical Debt Implementation.**

### 5.4.2. Scalability Considerations

**When to Use:**
- Data growth expected (10x, 100x)
- User base expansion
- Real-time requirements emerging
- Performance bottlenecks observed

**What It Provides:**
- Resource estimation
- Optimization triggers
- Architecture decisions
- Performance monitoring

**Key Components:**
- Scalability checkpoints (when to optimize)
- Resource estimation (memory, compute)
- Optimization strategies
- Architecture decision checklist

**Example Use Case:**
"Current: 5K records, in-memory processing. Trigger: Optimize when >100K records. Strategy: Move to distributed processing."

**For complete implementation guidance, see Appendix C.8: Scalability Implementation.**

### 5.4.3. Literature Review Phase

**When to Use:**
- Novel problem domain
- Research-oriented projects
- No established best practices
- Academic publications planned

**What It Provides:**
- State-of-art understanding
- Best practice identification
- Methodology justification
- Citation foundation for publications

**Key Components:**
- Review scope definition
- Information extraction template
- Synthesis and application
- Citation management

**Example Use Case:**
"No established approach for XYZ problem. Review: 25 papers on similar domains. Finding: Technique ABC shows promise, adapt to our context."

**For complete implementation guidance, see Appendix C.9: Literature Review Implementation.**

### 5.4.4. Risk Management

**When to Use:**
- High-stakes decisions
- Multiple dependencies
- Uncertain requirements
- Long timelines with many unknowns

**What It Provides:**
- Risk identification
- Mitigation strategies
- Monitoring approach
- Contingency planning

**Key Components:**
- Risk identification framework
- Impact and probability assessment
- Mitigation planning
- Monitoring and triggers

**Example Use Case:**
"Risk: Stakeholder requirements change mid-project. Probability: Medium. Impact: High. Mitigation: Sprint check-ins, documented requirements, flexible architecture."

**For complete implementation guidance, see Appendix C.10: Risk Management Implementation.**
