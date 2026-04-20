# File Naming Quick Reference Card

**Convention:** `sYY_dXX_PHASE_description.ext`

**Version:** 1.3.35
**Last Updated:** 2026-02-13

---

## Contents

1. [Phase Codes](#1-phase-codes)
2. [By File Type](#2-by-file-type)
3. [Examples by Sprint](#3-examples-by-sprint)
4. [Locations](#4-locations)
5. [Rules](#5-rules)
6. [Sprint 4 Consolidation](#6-sprint-4-consolidation)
7. [Blog Artifacts](#7-blog-artifacts)
8. [Citation Standards](#8-citation-standards)
9. [Reference File Size Protocol](#9-reference-file-size-protocol)
10. [Canonical Spoke Folder Names](#10-canonical-spoke-folder-names)
11. [Root File Policy](#11-root-file-policy)
12. [Document Structure: Section Numbering](#12-document-structure-section-numbering)
13. [Quick Checklist](#13-quick-checklist)

---

## 1. Phase Codes
- `SETUP` - Environment, data acquisition
- `EDA` - Exploratory data analysis
- `FE` - Feature engineering
- `MODEL` - Modeling and validation
- `REPORT` - Communication

---

## 2. By File Type

| Type | Working (S1-3) | Final (S4) |
|------|----------------|------------|
| **Notebook** | `s02_d01_FE_lags.ipynb` | `03_FE_lags-rolling.ipynb` |
| **Dataset** | `s02_d01_FE_with-lags.pkl` | `FE_features_v1.pkl` |
| **Visualization** | `s02_d01_FE_lag-validation.png` | `fig03_FE_lags.png` |
| **Decision** | `DEC-011_lag-nan-strategy.md` | (unchanged) |
| **Checkpoint** | `s02_d01_checkpoint.md` | (unchanged) |
| **Blog materials** | `YYYY-MM-DD_blog-materials-{scope}.md` | (unchanged) |
| **Blog draft** | `YYYY-MM-DD_blog-{scope}.md` | `YYYY-MM-DD_post-{scope}.md` |
| **LinkedIn post** | `YYYY-MM-DD_linkedin-{scope}.md` | (unchanged) |

---

## 3. Examples by Sprint

**Sprint 1 (EDA):**
- `s01_d01_SETUP_data-inventory.ipynb`
- `s01_d02_EDA_data-loading.ipynb`
- `s01_d03_EDA_quality-check.ipynb`
- `s01_d04_EDA_temporal-patterns.ipynb`
- `s01_d05_EDA_context-export.ipynb`

**Sprint 2 (Feature Engineering):**
- `s02_d01_FE_lags.ipynb`
- `s02_d02_FE_rolling.ipynb`
- `s02_d03_FE_oil.ipynb`
- `s02_d04_FE_aggregations.ipynb`
- `s02_d05_FE_final.ipynb`

**Sprint 3 (Modeling):**
- `s03_d01_MODEL_baseline-naive.ipynb`
- `s03_d02_MODEL_baseline-arima.ipynb`
- `s03_d03_MODEL_prophet.ipynb`
- `s03_d04_MODEL_lstm.ipynb`
- `s03_d05_MODEL_comparison.ipynb`

**Sprint 4 (Consolidation):**
- `01_SETUP_environment-data.ipynb`
- `02_EDA_comprehensive.ipynb`
- `03_FE_lags-rolling-aggregations.ipynb`
- `04_MODEL_baseline-advanced.ipynb`
- `05_REPORT_final-presentation.ipynb`

---

## 4. Locations

```
notebooks/           # sYY_dXX_*.ipynb
data/
  processed/         # sYY_dXX_*.pkl (working)
  results/           # PHASE_*_vX.pkl (final)
outputs/
  figures/
    eda/             # sYY_dXX_EDA_*.png
    features/        # sYY_dXX_FE_*.png
    models/          # sYY_dXX_MODEL_*.png
    final/           # figXX_*.png (Sprint 4)
dsm-docs/
  decisions/         # DEC-XXX_*.md
  plans/             # sYY_dXX_checkpoint.md
  reports/           # sYY_PHASE_report.md
  blog/              # blog-*, post-*, linkedin-*
```

---

## 5. Rules

1. **Sprint-first:** `sYY_dXX` not `dXX_sYY`
2. **Lowercase descriptions:** `lag-validation` not `Lag_Validation`
3. **Hyphens, not underscores:** `temporal-patterns` not `temporal_patterns`
4. **1-3 words max:** `rolling-smoothing` not `rolling-smoothing-validation-plot`
5. **Phase code required:** `s02_d01_FE_lags` not `s02_d01_lags`

---

## 6. Sprint 4 Consolidation

**Notebooks:** Merge daily → Sequential (01, 02, 03...)
**Datasets:** Move final to results/, archive working
**Visualizations:** Select best → figXX prefix, archive working
**Documentation:** Keep all (timestamped record)

---

## 7. Blog Artifacts

Blog content follows a three-document pipeline. Each phase has its own file type;
files progress through the pipeline and move to `dsm-docs/blog/done/` when published.

```
Session work → journal.md (append observations)
                  ↓ (project/epoch end, or explicit extraction)
              blog-materials-{scope}.md (structure one post)
                  ↓ (refinement)
              blog-{scope}.md + linkedin-{scope}.md (publish)
                  ↓ (URL confirmed)
              dsm-docs/blog/done/ (all related files)
```

### 7.1. Phase 1: Journal (capture)

| File | Pattern | Persistent? |
|------|---------|-------------|
| Journal | `journal.md` | Yes (no date prefix, single file per project) |

- Append-only file in `dsm-docs/blog/` for blog-worthy observations
- Capture triggers: explicit user request ("add this to the journal"), or agent
  noting something interesting during session work
- Entries accumulate across sessions; not consumed at session end
- When observations are extracted into a materials file, mark entries as extracted
  (do not delete; the journal is the historical record)

**Entry format:**
```markdown
### [YYYY-MM-DD] {Title}
{Observation, story, pattern, or insight}
```

### 7.2. Phase 2: Materials (structuring)

| File | Pattern | Example |
|------|---------|---------|
| Materials | `YYYY-MM-DD_blog-materials-{scope}.md` | `2026-02-06_blog-materials-feedback-loop.md` |

- One materials file per intended blog post
- Created from journal entries at project/epoch end, or directly for planned posts
- Contains: working title, story arc, key insights, technical details, draft outline
- Can also be created directly via explicit user request for specific events

### 7.3. Phase 3: Publish (drafting + posting)

| File | Pattern | Example |
|------|---------|---------|
| Draft | `YYYY-MM-DD_blog-{scope}.md` | `2026-02-06_blog-feedback-loop.md` |
| LinkedIn | `YYYY-MM-DD_linkedin-{scope}.md` | `2026-02-06_linkedin-feedback-loop.md` |

- Refined from materials into publishable form
- When published (URL confirmed), move all related files for that post to `dsm-docs/blog/done/`

**Date:** Publication or creation date (YYYY-MM-DD). Enables chronological sorting
and static site generator compatibility.

**Scope examples:**
- Topic-based: `feedback-loop`, `anti-patterns`, `hub-and-spoke`
- Sprint-based (spoke projects): `s01`, `s01-evaluation`, `s02-deployment`

**Location:** `dsm-docs/blog/`

**Metadata header:** All blog files (except journal.md) should include:

```markdown
**Date:** YYYY-MM-DD
**Author:** [Name]
**Status:** Draft | Review | Published
**Platform:** LinkedIn | Blog | GitHub | etc
```

**Diagrams:** Use Mermaid syntax for architecture and flow diagrams.
- Render at mermaid.live for PNG/SVG export
- Store `.mmd` source files in `dsm-docs/blog/` alongside posts
- Vertical layouts (`flowchart TB`) work better for LinkedIn feed
- Mermaid renders natively in GitHub markdown

**Anti-pattern:** Do not skip the journal and create materials files directly during
active work when you don't yet know which post an observation belongs to. The journal
exists precisely to decouple capture from structuring.

### 7.4. Publication Tracker

Every project with blog artifacts maintains a publication tracker at
`dsm-docs/blog/README.md`. This file serves as the index for all blog content and
tracks publication status across platforms.

**Standard table format:**

```markdown
# Blog Artifacts Index

Track creation and publication status of blog materials.

| File | Topic | Blog Published | LinkedIn Posted |
|------|-------|:-:|:-:|
| `2026-02-06_blog-feedback-loop.md` | Feedback loop post | No | No |
| `2026-02-06_blog-feedback-loop.md` | Feedback loop post | Yes (2026-03-01) | Yes (2026-03-02) |

## Status Key
- **No**: Created, not yet published
- **Yes (YYYY-MM-DD)**: Published with date
- **-**: Not applicable for this format
```

**When to update:**
- At sprint boundaries (per Sprint Boundary Checklist in DSM_2.0)
- After publication (Step 7 of Section 2.5.6 Blog Process)
- When moving published files to `dsm-docs/blog/done/`

**Scope by project type:**
- **Spoke projects and DSM Central:** `dsm-docs/blog/README.md` in the project repo
- **External contributions:** Blog artifacts about contributions live in DSM
  `{contributions-docs-path}/{project}/blog/`, not in the external repo.
  The tracker follows the blog content to that location.

### 7.1. Vocabulary Linking Convention (BL-239 T4)

Blog posts, external-facing deliverables, and public documents routinely
use DSM-specific terms (spoke, hub, Level 3 branch, `@` reference,
Pre-Generation Brief, Session Transcript, etc.). Readers outside the
project cannot be assumed to know these terms.

**Convention:** on first use of a DSM-specific term in a blog post or
public document, link to the matching entry in
`dsm-docs/guides/dsm-vocabulary.md`. Subsequent uses in the same document
do not need to re-link.

Format:

```markdown
... the [spoke project](dsm-docs/guides/dsm-vocabulary.md#spoke) sends
feedback to the hub via the inbox system ...
```

**Scope:** blog posts in `dsm-docs/blog/`, README.md, external-facing
guides in `dsm-docs/guides/` that a public reader might encounter.
Internal methodology files (DSM_0 through DSM_6) do not need links
because the vocabulary itself is part of the methodology set.

**Alternative for short posts:** if a post uses only 1-2 DSM terms, a
single "Terms used in this post" footer with links is acceptable.

**What NOT to do:** do not inline-define every term (bloats the post).
Do not re-link on every occurrence (noise). Do not link from internal
methodology files (redundant).

---

## 8. Citation Standards

**When to cite:**

| Document Type | Requirement |
|---------------|-------------|
| Research documents | Required for all external sources |
| Methodology (DSM_1-4) | Required for foundational concepts and frameworks |
| Backlog items | When referencing external standards or community practices |
| Blog materials | When referencing external sources |
| Checkpoints, handoffs, decisions | Not required (internal operational docs) |

**Format by source type:**

| Source Type | Format | Example |
|-------------|--------|---------|
| Academic book/paper | Author (Year). *Title*. Publisher/Journal. | Tukey (1977). *Exploratory Data Analysis*. Addison-Wesley. |
| Web page/blog post | [Title](URL) (Author, Year) | [RedMonk: AI Slopageddon](URL) (Holterhoff, 2026) |
| GitHub repository/file | [Project: File](URL) | [ClickHouse: AI_POLICY.md](URL) |
| Mailing list/forum | Description (source type, date) | Linux Kernel mailing list discussion (2025) |
| Internal cross-reference | Section X.Y or document name | See DSM_3 Section 6.4 |

**Location by document type:**

| Document Type | Citation Location |
|---------------|-------------------|
| Research documents | End-of-document `## Sources` section, categorized by topic |
| Methodology sections | Inline for brief attributions + footer `Research basis:` cross-reference |
| Backlog items | Inline with context (not bare URLs) |
| Blog posts | Inline references with numbered list at end (per Section 2.5.9) |

---

## 9. Reference File Size Protocol

Reference files (`_references/`, `dsm-docs/research/`, collected documentation) should
remain small enough for both the agent and the human to review in a single pass.

**Guidelines:**
- **Maximum recommended size:** ~500 lines per reference file
- **When a file exceeds the limit:** Split by topic, section, or source into
  multiple files. Prefer semantic names (`{topic}_{subtopic}.md`) over numbered
  parts (`{topic}_part1.md`)
- **Before reading large files:** Estimate context budget impact and warn the user
  if the file will consume a significant portion of the session's context window
- **Collection files:** When collecting multiple sources into one file (blog posts,
  forum threads, documentation), prefer one file per source over a monolithic dump

**Why this matters:** Large reference files degrade both agent performance (context
window consumption) and human oversight (impossible to review 2,000+ lines
meaningfully). This aligns with DSM_6.0 Principle 1 (Take a Bite): reference
materials should be digestible, not overwhelming.

---

## 10. Canonical Spoke Folder Names

Every DSM spoke project uses these exact folder names under `dsm-docs/`:

| Canonical Name | Content Type | Has done/? |
|---------------|-------------|------------|
| `dsm-docs/blog/` | Blog materials, drafts, posts | Yes |
| `dsm-docs/checkpoints/` | Milestone snapshots | Yes |
| `dsm-docs/decisions/` | Decision log entries (DEC-NNN) | No (permanent) |
| `dsm-docs/feedback-to-dsm/` | Methodology, backlog, and technical feedback | No (append-only) |
| `dsm-docs/guides/` | Reference guides, user docs | No (permanent) |
| `dsm-docs/handoffs/` | Session continuity documents | Yes |
| `_inbox/` | Hub-spoke communication transit (project root) | No (entries deleted) |
| `dsm-docs/plans/` | Sprint and project planning | Yes |
| `dsm-docs/research/` | Research documents and findings | Yes |

**done/ subfolder convention:** Folders marked "Has done/" contain artifacts with
a consumption lifecycle. Once an artifact is consumed, superseded, or published,
move it to `done/` within that folder and update its header:

```markdown
**Date Completed:** YYYY-MM-DD
**Outcome Reference:** [link to produced artifact: DEC-XXX, backlog item, URL]
```

| Folder | Move to done/ when |
|--------|-------------------|
| `handoffs/` | Consumed at next session start |
| `checkpoints/` | Newer checkpoint created (keep only latest active) |
| `research/` | Findings processed into feedback, decision, or plan |
| `blog/` | Post published (URL confirmed) |
| `plans/` | Plan completed or superseded |

**Feedback files:** `dsm-docs/feedback-to-dsm/` contains exactly three files: `backlogs.md`,
`methodology.md`, and `technical.md`. All session observations are appended as
dated entries within these files, not created as separate per-session files. Mark
individual entries with `**Pushed:** YYYY-MM-DD` when sent to DSM Central's inbox.
See DSM_0.2 Technical Progress Reporting for the `technical.md` template and
routing protocol.

**Anti-pattern:** Do not create `dsm-docs/feedback-to-dsm/YYYY-MM-DD_backlogs.md` or
similar dated files. The canonical files are the single source of truth;
per-session files fragment the record and leave the canonical files empty.

---

## 11. Root File Policy

Only ecosystem-required files belong in the project root. All project content
(plans, documentation, research) goes in the appropriate `dsm-docs/` subdirectory.

**Allowed in root:**

| File/Directory | Reason |
|----------------|--------|
| `README.md` | Repository convention |
| `CHANGELOG.md` | Repository convention |
| `LICENSE` | Repository convention |
| `.gitignore` | Git convention |
| `CODE_OF_CONDUCT.md` | OSS convention (optional) |
| `CONTRIBUTING.md` | OSS convention (optional) |
| `SECURITY.md` | OSS convention (optional) |
| `requirements.txt`, `pyproject.toml`, `setup.py` | Python packaging convention |
| `app.py`, `main.py` | Application entry point (Streamlit, FastAPI) |
| `Dockerfile`, `docker-compose.yml` | Container convention |
| `_inbox/` | DSM hub-spoke communication |
| `dsm-docs/`, `src/`, `tests/`, `notebooks/`, `data/` | Standard project directories |
| `.claude/`, `.venv/`, `.github/` | Tooling directories |
| `plan/`, `templates/`, `scripts/` | DSM project directories (as needed) |

**Not allowed in root (move to appropriate location):**

| Anti-pattern | Correct location |
|-------------|-----------------|
| `PROJECT_PLAN.md`, `PLAN.md` | `dsm-docs/plans/` |
| `DECISIONS.md`, `ADR-*.md` | `dsm-docs/decisions/` |
| `RESEARCH.md`, `STATE_OF_ART.md` | `dsm-docs/research/` |
| `HANDOFF.md`, `SESSION_NOTES.md` | `dsm-docs/handoffs/` |
| `prompts/` (non-standard directory) | `src/prompts/` or `data/prompts/` |
| Loose markdown files (notes, drafts) | Appropriate `dsm-docs/` subdirectory |

**Principle:** The root should contain only files that tools or platforms expect to
find there (pip, Streamlit, Docker, GitHub). Everything else goes in a subdirectory.
If a file does not serve a tool or platform at root level, it belongs elsewhere.

---

## 12. Document Structure: Section Numbering

All DSM methodology documents (DSM_0 through DSM_6, including modular files like
DSM_0.2.A-D) use hierarchical decimal numbering with trailing period at every
heading level:

```
## 6. Project Handover Protocols
### 6.7. Spoke Project Initialization Checklist
#### 6.7.2. CLAUDE.md Essentials
```

**Rules:**
1. Every structural heading (`##`, `###`, `####`) gets a number
2. Numbers are hierarchical: parent.child.grandchild
3. Trailing period after each number: `6.7.2.` not `6.7.2`
4. Title follows the number with a space: `## 6. Title`
5. Template headings inside code blocks are not numbered
6. The document title (`#`) is not numbered

**Why:** Numbered sections enable unambiguous cross-references ("DSM_0.2.A
Section 7" vs "the parallel session section"), stable citations (heading text
can change, numbers stay), and ordered structure within documents.

---

## 13. Quick Checklist

Before creating any file, ask:
- [ ] Is sprint number first? (`sYY_dXX`)
- [ ] Is phase code included?
- [ ] Is description lowercase with hyphens?
- [ ] Is description 1-3 words?
- [ ] Does it match the pattern for this file type?

---

**Print this card and keep it visible while working!**

**For detailed guidance, see:** Appendix E.11 in `1.0_Methodology_Appendices.md`

**Part of:** Deliberate Systematic Methodology (DSM)
