# DSM 1.0 Module B: Working Standards and Progressive Execution

**Parent document:** `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md`
**Module scope:** Section 3 (Working Standards) + Section 7 (Progressive Execution)

---

# 3. Working Standards

## 3.1. Notebook Structure

### 3.1.1. Standard Template (5-6 Sections)

Every notebook follows a consistent structure:

**Section 1: Setup & Environment Configuration**
- Import statements
- Path constants
- Configuration parameters
- Helper functions

**Section 2: Data Loading & Validation**
- Load data from files
- Validate data structure
- Check for expected columns and types
- Report data shape and basic info

**Sections 3-5: Core Processing**
- Main analytical work (3-4 sections)
- Each section has clear purpose
- Progressive building of insights
- Regular validation checkpoints

**Section 6: Validation & Export**
- Final validation checks
- Export processed data/results
- Save artifacts (models, visualizations)
- Document output locations

**Section 7: Summary & Next Steps**
- Recap key findings
- Document decisions made
- List next steps
- Flag issues or concerns

### 3.1.2. Line Count Guidelines

**Target:** ~400 lines per notebook

**Rationale:**
- Maintainable size for review and debugging
- Fits on screen with reasonable scrolling
- Each section ~60-80 lines
- Balance between detail and readability

**When to Split:**
- Notebook exceeds 600 lines
- More than 6-7 major sections
- Distinct analytical phases (EDA → Feature Engineering)
- Natural breakpoints in workflow

**Example Split:**
```
# Instead of one 800-line notebook:
01_EDA_data_quality.ipynb (400 lines)
02_EDA_behavioral_patterns.ipynb (400 lines)

# Better than:
01_EDA_complete.ipynb (800 lines)
```

### 3.1.3. Section Naming Conventions

**Markdown Headers:**
```markdown
### Section 1: Setup & Configuration
Code and output here...

### Section 2: Data Loading
Code and output here...
```

**Clear Descriptive Names:**
- "Section 3: Cohort Definition" (specific purpose)
- "Section 3: Analysis" (too vague, be more specific)

**Progressive Narrative:**
- Each section builds on previous
- Clear flow from setup → analysis → export
- Tells a story

### 3.1.4. Output Display Requirements

**All code cells must show visible output:**
```python
# Good: Shows output
df = pd.read_csv('data.csv')
print(f"Loaded {df.shape[0]:,} rows, {df.shape[1]} columns")
print(df.head(3))

# Bad: Silent operation
df = pd.read_csv('data.csv')
```

**Informative Outputs (Use):**
- Show actual data/results: shapes, counts, correlations, statistics
- Example: `print(f"Correlation: {value:.3f}")`

**Confirmation Messages (Avoid):**
- Generic success messages: "Complete!", "Done!", "Ready!", "Success!"
- Example: `print("Data ready for model training!")` ← Remove this

**Print Statement Standards:**
- Numbers with commas: `print(f"Count: {value:,}")`
- Decimals appropriate to context: `{price:.2f}`, `{corr:.4f}`
- Descriptive labels: `print(f"Mean CLV: ${mean_clv:,.2f}")`

---

## 3.2. Code Standards

### 3.2.1. Text Conventions

**Professional Text Standards:**
- Use "WARNING:" instead of warning emoji
- Use "OK:" instead of checkmark
- Use "ERROR:" instead of cross mark
- No emojis in code, markdown, or deliverables

**Applies To:**
- Notebook markdown cells
- Print statements in code
- Documentation files
- Presentation materials
- Email communications

**Examples:**
```python
# Good
print("WARNING: Missing values detected in 'age' column")
print("OK: All validations passed")
print("ERROR: Unexpected data type for 'date'")

# Bad
print("WARNING: Missing values detected")
print("OK: All validations passed")
print("ERROR: Unexpected data type")
```

### 3.2.2. Output Standards

**Number Formatting:**
```python
# Always use comma separators
print(f"Customers: {len(customers):,}")  # "Customers: 5,765"
print(f"Revenue: ${revenue:,.2f}")       # "Revenue: $1,234,567.89"
```

**Decimal Precision:**
```python
# Context-appropriate precision
print(f"Price: ${price:.2f}")            # Currency: 2 decimals
print(f"Percentage: {pct:.1f}%")         # Percentage: 1 decimal
print(f"Correlation: {corr:.4f}")        # Statistics: 4 decimals
```

**List Formatting:**
```python
# Short lists (<5 items): Single line
features = ['age', 'income', 'trips', 'spend']

# Long lists (>10 items): Multi-line with clear structure
important_features = [
    'customer_lifetime_value',
    'trip_frequency',
    'avg_booking_value',
    'cancellation_propensity',
    'discount_usage_rate',
    'days_since_last_trip'
]
```

### 3.2.3. Code Quality Guidelines

**For Academic/Exploratory Work:**
- Focus on readability and reproducibility
- Avoid code quality tools (black, flake8)
- Clear variable names
- Adequate comments for complex logic

**For Production/Team Work:**
- Use code quality tools (Section 2.1.2)
- Consistent formatting
- Type hints where helpful
- Comprehensive documentation

**General Best Practices:**
```python
# Good: Clear variable names
monthly_revenue = calculate_revenue(transactions)

# Bad: Unclear abbreviations
mr = calc(trx)

# Good: Documented complex logic
# Calculate ratio of events to total, handling division by zero
event_ratio = event_count / total_count if total_count > 0 else 0

# Bad: Uncommented complex logic
er = ec / tc if tc > 0 else 0
```

### 3.2.4. Path Management

**Use Constants:**
```python
# Good: Constants at top of notebook
DATA_DIR = '../data/raw/'
OUTPUT_DIR = '../data/processed/'
RESULTS_DIR = '../results/'

df = pd.read_csv(f'{DATA_DIR}customers.csv')
df.to_csv(f'{OUTPUT_DIR}data_clean.csv', index=False)
```

**Avoid Hard-Coded Paths:**
```python
# ERROR: Hard-coded paths throughout
df = pd.read_csv('../data/raw/dataset_a.csv')
# ... 50 lines later ...
df2 = pd.read_csv('../data/raw/dataset_b.csv')
# ... 100 lines later ...
df.to_csv('../data/processed/output.csv')
```

### 3.2.5. Print Statement Standards

**DO Print (Informative Outputs):**
- Data shapes: `print(f"Shape: {df.shape}")`
- Specific metrics: `print(f"Correlation: {corr:.3f}")`
- Counts and statistics: `print(f"Outliers: {n} ({pct:.2f}%)")`
- Quantitative findings: `print(f"Weekend lift: +{lift:.1f}%")`
- Validation results: `print(f"Missing values: {df.isnull().sum().sum()}")`

**DO NOT Print (Generic Confirmations):**
- ERROR: "Complete!", "Done!", "Success!", "Ready!"
- ERROR: "Data loaded successfully!"
- ERROR: "Processing finished!"
- ERROR: "All set for next step!"
- ERROR: "Correlation computed successfully!"

**Rationale:**
Results should speak for themselves. Generic confirmations add noise without information.
If output shows `df.shape = (300896, 28)`, there's no need to also print "Data loaded successfully!"

**Examples:**

```python
# WRONG
df = pd.read_pickle('data.pkl')
print("Data loaded successfully!")  # ERROR: Generic, no value

# RIGHT
df = pd.read_pickle('data.pkl')
print(f"Loaded: {df.shape[0]:,} rows x {df.shape[1]} columns")  # OK: Informative

# WRONG
correlation = df['x'].corr(df['y'])
print("Correlation analysis complete!")  # ERROR: Useless

# RIGHT
correlation = df['x'].corr(df['y'])
print(f"Correlation (x, y): r = {correlation:.4f}")  # OK: Specific

# WRONG
df_clean = remove_outliers(df)
print("Outliers removed successfully!")  # ERROR: How many? What method?

# RIGHT
before = len(df)
df_clean = remove_outliers(df)
after = len(df_clean)
print(f"Outliers removed: {before - after} ({(before-after)/before*100:.2f}%)")  # OK: Quantified
```

---

### 3.2.6. Coding Anti-Patterns

Best practices tell you what to do; anti-patterns tell you what NOT to do. This section complements the code quality guidelines (Section 3.2.3) with common defective patterns across four categories.

| Category | Patterns | Focus |
|----------|----------|-------|
| Python Fundamentals | 8 | Correctness, maintainability, security |
| Data Science | 9 | Notebook hygiene, reproducibility |
| ML Engineering | 8 | Pipeline integrity, architecture |
| Agent Collaboration | 8 | Human-agent workflow quality |

**Quick reference, top 5 anti-patterns by impact:**

| Anti-Pattern | Category | Consequence |
|-------------|----------|-------------|
| Feature Leakage | ML Engineering | Inflated metrics, production failure |
| God Notebook | Data Science | Unmaintainable, unreproducible |
| Blind Acceptance | Agent Collaboration | Bugs, security issues |
| Mutable Default Arguments | Python | Shared state across calls |
| Training-Serving Skew | ML Engineering | Silent prediction errors |

Each anti-pattern includes Problem, Example (bad code), Fix (correct code), and a DSM Reference linking to the relevant best practice.

**For the complete anti-patterns reference with code examples, see Appendix F: Coding Anti-Patterns.**

---

## 3.3. File Naming Standards

### 3.3.1. Notebook Naming

**Standard Pattern:**
```
[Number]_[PHASE]_[description].ipynb
```

**Examples:**
- `01_EDA_data_quality_cohort.ipynb`
- `02_EDA_behavioral_analysis.ipynb`
- `03_FE_core_features.ipynb`
- `04_FE_advanced_features.ipynb`
- `05_ANALYSIS_model_selection.ipynb`
- `06_ANALYSIS_validation_interpretation.ipynb`

**Phase Codes:**
- `EDA`: Exploration (Phase 1)
- `FE`: Feature Engineering (Phase 2)
- `ANALYSIS`: Analysis (Phase 3, optionally use technique name: `CLUSTERING`, `CLASSIFICATION`, etc.)
- `FINAL`: Communication (Phase 4)

**Numbering:**
- Sequential from 01
- Reflects execution order
- Gaps allowed for inserted notebooks

### 3.3.2. Data File Naming

**Pattern:**
```
[entity]_[version]_[date].csv
```

**Examples:**
- `users_v2.1_20251108.csv`
- `user_features_v1.0_20251115.csv`
- `cluster_assignments_v1.0_20251120.csv`

**Versioning:**
- `v1.0`: Initial version
- `v1.1`: Minor updates (added columns, fixed calculations)
- `v2.0`: Major changes (different cohort, new logic)

### 3.3.3. Output File Naming

**Deliverables:**
```
[Project]_[Type]_[Audience].ext
```

**Examples:**
- `ProjectName_Executive_Summary.pdf`
- `ProjectName_Technical_Report.pdf`
- `ProjectName_Presentation.pptx`
- `ProjectName_QA_Document.md`

### 3.3.4. Complete File Naming Guide

For comprehensive file naming standards across all project types, see:
**`1.2_File_Naming_Standards_Comprehensive.md`**

---

## 3.4. Directory Structure

### 3.4.1. Standard Layout

```
project_root/
├── .venv/                      # Virtual environment (not committed)
├── .vscode/                    # VS Code settings
│   └── settings.json
├── data/
│   ├── raw/                    # Original data (read-only)
│   ├── processed/              # Cleaned data
│   └── features/               # Engineered features
├── notebooks/
│   ├── 01_EDA_*.ipynb
│   ├── 02_EDA_*.ipynb
│   ├── 03_FE_*.ipynb
│   └── ...
├── results/
│   ├── figures/                # Visualizations
│   ├── models/                 # Trained models
│   └── reports/                # Written deliverables
├── dsm-docs/
│   ├── project_plan.md
│   ├── decision_log.md
│   └── feature_dictionary.md
├── requirements_base.txt       # Base packages
├── requirements.txt            # All packages
└── README.md
```

### 3.4.2. Data Folders Organization

**raw/**: Original data files (never modified)
- As received from source
- Preserved for reproducibility
- Version controlled filenames

**processed/**: Cleaned data
- After quality checks
- Missing data handled
- Outliers addressed
- Ready for feature engineering

**features/**: Engineered features
- Entity-level features
- Aggregated metrics
- Derived and interaction features
- Versioned files

### 3.4.3. Output Organization

**figures/**: All visualizations
- EDA plots
- Model validation charts
- Final presentation graphics
- Organized by notebook or phase

**models/**: Serialized models
- Trained models
- Scalers and transformers
- Versioned with date

**reports/**: Written deliverables
- Executive summaries
- Technical reports
- Presentations
- Q&A documents

### 3.4.4. Documentation Folders

**dsm-docs/**: Project documentation
- Project plan and timeline
- Decision log
- Feature dictionary
- Data dictionary
- Meeting notes
- Stakeholder communications

**notebooks/**: Analysis notebooks
- Numbered sequentially
- Phase-based organization
- Consolidated final notebook

### 3.4.5. Feature Dictionary Standard

**Purpose:** Document all features (original + engineered) for reproducibility and stakeholder communication

**When to Create/Update:**
- After Sprint 1 (Exploration) - original features
- After Sprint 2 (Feature Engineering) - engineered features
- When features change - create versioned copy

**Filename:** `feature_dictionary.txt` or `feature_dictionary_v[N].txt`

**Location:** `dsm-docs/`

**Format:**

```
Feature Dictionary - [Dataset Name]
Version: [N]
Last Updated: [Date]
Project: [Project Name]

==================================================

ORIGINAL FEATURES ([count])
==================================================

[feature_name_1]    [Data type] - [Description with units, source]
[feature_name_2]    [Data type] - [Description]

Example:
value               Float64 - Primary metric (target variable, >=0)
category            String  - Item category (10 unique values)
event_date          DateTime - Event date (YYYY-MM-DD, range: 2023-01-01 to 2024-12-31)

==================================================

ENGINEERED FEATURES - Sprint 2 ([count])
==================================================

[Temporal Features]
value_lag7          Float64 - Value 7 days ago (NaN ~10% per DEC-011)
value_7d_avg        Float64 - 7-day moving average (min_periods=1, NaN <1%)

[Aggregation Features]
group_avg           Float64 - Historical average for group (baseline, constant within group)

[Interaction Features]
flag_x_group_avg    Float64 - Flag indicator x group average (scaled interaction)
```

**Minimum Information Per Feature:**
- Name (as it appears in dataset)
- Data type (Float64, Int64, Boolean, DateTime, String)
- Description (what it represents)
- Units (if numerical - USD, units, days, percentage)
- Source (original data, engineered in Sprint X, merged from file.csv)
- Calculation method (if derived - e.g., "lag 7 days", "7-day rolling mean")
- Special handling (NaN strategy, transformations, clipping)
- Reference to decisions (if applicable - "per DEC-011")

**Versioning:**
- v1: After Sprint 1 (original features only)
- v2: After Sprint 2 (+ engineered features)
- v3: After Sprint 3 (if features added/removed based on modeling)

**Example Entry (Complete):**

```
value_lag14         Float64 - Value 14 days ago
                    Source: Engineered in Sprint 2
                    Calculation: groupby(['group_id']).shift(14)
                    NaN handling: Keep NaN (11.7% of rows, tree models handle natively per DEC-011)
                    Correlation with target: r = 0.32 (moderate positive)
                    Domain meaning: Captures bi-weekly cycles
```

**Benefits:**
- Onboarding: New team members understand features quickly
- Debugging: Trace feature calculations when errors occur
- Stakeholder communication: Explain features in business terms
- Model interpretation: Reference when explaining feature importance
- Reproducibility: Clear documentation enables recreation

## 3.5. Inclusive Language

Technical writing should be welcoming to all readers. Choose examples and
terminology that demonstrate concepts without reinforcing stereotypes.

### 3.5.1. Terminology

**Avoid:**

| Term | Preferred Alternative |
|------|----------------------|
| master/slave | primary/replica, leader/follower |
| whitelist/blacklist | allowlist/denylist |
| sanity check | validation check, confidence check |
| dummy (variable) | indicator (variable), placeholder |

**Prefer:**
- Gender-neutral language: "they", "the user", "the developer"
- Descriptive terms over metaphorical: "primary branch" over "master branch"

### 3.5.2. Examples and Illustrations

When illustrating technical concepts, prefer examples that are domain-relevant
rather than culturally loaded:

**Word embeddings (NLP):**
- Instead of: "king - man + woman = queen" (gendered royalty)
- Use: "Paris - France + Japan = Tokyo" (geography analogy)
- Use: "good - better = bad - worse" (linguistic analogy)

**General principle:** If an example works equally well with neutral content,
choose the neutral version.

---

# 7. Progressive Execution with the Agent

## 7.1. Cell-by-Cell Development

### 7.1.1. Progressive Pattern

**Recommended Workflow:**
1. Write one cell (or one section)
2. Execute and validate output
3. Use output to inform next cell
4. Iterate based on results

**Why This Works:**
- Catches errors immediately
- Validates assumptions step-by-step
- Allows data-driven decisions
- Builds confidence in approach
- Easier debugging (small increments)

**Example Progression:**
```python
# Cell 1: Load data
df = pd.read_csv('data.csv')
print(f"Loaded {df.shape[0]:,} rows, {df.shape[1]} columns")
print(df.head())
# → Validate: Is shape expected? Are columns correct?

# Cell 2: Check for duplicates (informed by Cell 1 output)
duplicates = df.duplicated().sum()
print(f"Duplicates: {duplicates:,}")
# → Decide: Do we need to remove duplicates?

# Cell 3: Handle duplicates (decision based on Cell 2)
if duplicates > 0:
    df = df.drop_duplicates()
    print(f"OK: Removed {duplicates:,} duplicates")
# → Validate: Confirm duplicates removed
```

### 7.1.2. Output Validation

**Every Cell Should Answer:**
- Did it work? (No errors)
- Is output expected? (Shape, values make sense)
- What do I learn? (Insights inform next step)
- What to do next? (Clear next action)

**Validation Questions:**
```python
# After data loading
print(f"Rows: {df.shape[0]:,}, Columns: {df.shape[1]}")
# → Expected row count? Expected columns present?

# After filtering
print(f"Before: {len(df_before):,}, After: {len(df_after):,}")
# → Reasonable filter rate? Too many removed?

# After aggregation
print(f"Unique entities: {df['entity_id'].nunique():,}")
# → Matches expected cohort size?
```

### 7.1.3. Feedback Loop Best Practices

**Effective Feedback to Agent:**
- "Output shows 5,765 customers. Expected ~6,000. Let's investigate why 235 are missing."
- "This doesn't look right."

- "Correlation between X and Y is 0.95, which seems too high. Let's check if there's a calculation error."
- "Something is wrong."

- "Model A shows score 0.38. Let's also test Model B and Model C to compare."
- "Try more values."

**Agent Responds Better When You:**
- Share specific observations from outputs
- State what you expected vs. what you got
- Ask targeted questions
- Provide context on business meaning
- Reference previous work in session

---

## 7.2. Validation Patterns

### 7.2.1. Immediate Validation

**After Every Transformation:**
```python
# Before transformation
print(f"Before: shape {df.shape}, nulls {df.isnull().sum().sum()}")

# Transform
df_transformed = transform_function(df)

# After transformation - validate
print(f"After: shape {df_transformed.shape}, nulls {df_transformed.isnull().sum().sum()}")
assert df_transformed.shape[0] == df.shape[0], "Row count changed unexpectedly"
```

**Sanity Checks:**
```python
# Check ranges
assert df['age'].min() >= 0, "Negative age found"
assert df['age'].max() <= 120, "Unrealistic age found"

# Check completeness
assert df['customer_id'].isnull().sum() == 0, "Missing customer IDs"

# Check business logic
assert (df['revenue'] >= 0).all(), "Negative revenue found"
```

### 7.2.2. Checkpoint Creation

**After Major Steps:**
```python
# Checkpoint: Save progress
df.to_csv('../data/processed/customers_cleaned_v1.0.csv', index=False)
print(f"OK: Checkpoint saved - {df.shape[0]:,} customers")
```

**Benefits:**
- Can restart from checkpoint if needed
- Version control of intermediate data
- Easier debugging (revert to known good state)
- Share intermediate data with stakeholders

### 7.2.3. Rollback Strategies

**When Things Go Wrong:**
```python
# Keep copy before risky operation
df_backup = df.copy()

# Try operation
try:
    df = risky_transformation(df)
except Exception as e:
    print(f"ERROR: Transformation failed: {e}")
    df = df_backup  # Rollback
    print("Rolled back to previous state")
```

**Notebook Rollback:**
- Save intermediate CSV files
- Use Git for notebook versions
- Keep "last known good" notebook copy
- Document what state each file represents

---

## 7.3. Collaboration Best Practices

### 7.3.1. Clear Communication

**Effective Prompts to Agent:**
- "Create a scatter plot of metric_a vs. metric_b, colored by segment, with axis labels and title."
- "Make a chart."

- "Calculate event_ratio as: (event_count / total_count). Handle zero totals with 0."
- "Calculate the ratio."

- "Load data.csv, filter for records with date >= '2023-01-01', print resulting count."
- "Load and filter data."

**Context Sharing:**
- Explain domain context when relevant
- Reference previous work ("As we calculated in Cell 5...")
- Note assumptions ("Assuming no activity means no risk...")
- State preferences ("I prefer histograms over box plots for this...")

### 7.3.2. Context Maintenance

**Help Agent Remember:**
- Reference earlier findings: "We found 3 segments earlier..."
- Cite decision log: "As per DEC-003, we're using approach X..."
- Mention file locations: "We saved features in ../data/features/..."
- Note column names: "The segment column is called 'segment_id'..."

**Update Agent on Changes:**
- "I manually edited the CSV to fix encoding issues."
- "Stakeholder changed requirement: now need 4 segments instead of 3."
- "We're pivoting from approach A to approach B."

### 7.3.3. Iterative Refinement

**Progressive Improvement:**
```
Iteration 1: "Create basic histogram of the target variable"
→ Review output →

Iteration 2: "Add custom bin edges and format y-axis with commas"
→ Review output →

Iteration 3: "Add vertical lines for segment means, with legend"
→ Final output
```

**Benefits of Iteration:**
- Start simple, add complexity
- Validate each addition
- Easier to identify issues
- More control over final result

**When to Iterate:**
- Initial output close but needs refinement
- Complex visualization or calculation
- Uncertain about best approach
- Learning new technique
