# DSM 5.0: Documentation Project Adaptation

**Version:** 1.0
**Date:** February 2026
**Purpose:** Track adaptation for projects where the primary deliverable is documentation, not code or data analysis.

---

## 1. When to Use This Adaptation

Use DSM 5.0 when the project's primary output is written documentation: methodology guides, knowledge bases, portfolios, blog sites, or technical writing.

**Indicators:**
- Directory contains `dsm-docs/`, markdown files, and configuration, but no `notebooks/` or `src/`
- Deliverables are documents, not code artifacts or analytical results
- Version control tracks content changes, not code changes

**Examples from the DSM ecosystem:**
- DSM Central (hub, methodology repository)
- dsm-data-science-portfolio (professional portfolio)
- dsm-blog-poster (blog site)

**What still applies from DSM 1.0/2.0:**
- DSM 2.0: Sprint planning, checkpoint protocol, deliverable tracking
- Section 2.5: Communication standards, writing conventions
- Section 6.1: Session management (handoffs, checkpoints)

**What does NOT apply:**
- Section 2.1: Environment setup (no Python environments for pure documentation)
- Section 2.2-2.4: EDA, feature engineering, modeling
- Appendices A-D: Phase-specific technical guidance

---

## 2. Project Structure Patterns

### 2.1 Recommended Directory Layout

```
project-root/
  README.md                     # Project overview and getting started
  CHANGELOG.md                  # Version history (keepachangelog format)
  LICENSE                       # License file
  .gitignore                    # Git ignore rules
  dsm-docs/                     # Project outputs
    blog/                       # Blog materials and posts
    checkpoints/                # Milestone snapshots (historical)
    handoffs/                   # Session-end resumption documents
    research/                   # Research findings (Phase 0.5)
    feedback-to-dsm/            # Methodology effectiveness tracking
  plan/                         # Planning artifacts
    backlog/                    # Backlog items
      improvements/             # Internal enhancements
      developments/             # External project definitions
      done/                     # Completed items
    archive/                    # Obsolete planning documents
  templates/                    # Reusable templates (optional)
  scripts/                      # Utility scripts (optional)
  .claude/                      # AI agent configuration (gitignored)
    memory/                     # Session memory
    CLAUDE.md                   # Project-specific agent instructions
```

### 2.2 Hub vs Spoke Variations

**Hub projects** (methodology repositories): Include `plan/backlog/`, `contributions-docs/`, `case-studies/`, core methodology files in root.

**Spoke projects** (documentation that follows DSM): Simpler layout. May only need `dsm-docs/`, `README.md`, `.claude/`. Add `plan/` and `templates/` as complexity grows.

---

## 3. File Naming Conventions

### 3.1 Core Documents

Pattern: `DSM_{N}.{sub}_{Descriptive_Name}_v{X}.{Y}.md`

- `{N}`: Document number (0-5+)
- `{sub}`: Sub-document number (optional)
- `{Descriptive_Name}`: CamelCase or underscore-separated title
- `_v{X}.{Y}`: Integration version suffix (incremented when the specific file changes)

### 3.2 Backlog Items

Pattern: `BACKLOG-{###}_{slug}.md`

- Sequential numbering across all categories
- Slug uses lowercase-kebab-case
- Location determines classification: `improvements/`, `developments/`, or `done/`

### 3.3 Date-Based Documents

Pattern: `YYYY-MM-DD_{type}-{scope}.md`

Types by context:
- Blog: `blog-materials-`, `blog-`, `post-`, `linkedin-`, `journal-`
- Checkpoints: `{scope}_checkpoint` or `v{X}.{Y}.{Z}_{scope}_checkpoint`
- Handoffs: `session-handoff` or `{scope}-handoff`
- Research: descriptive slug

### 3.4 General Rules

- Use lowercase-kebab-case for slugs
- Use underscores to separate structural components (date, type, scope)
- Never use spaces in filenames
- Use `.md` extension for all documentation

---

## 4. Metadata Standards

### 4.1 Backlog Item Headers

```markdown
# BACKLOG-###: Title

**Status:** Proposed | In Progress | Implemented
**Priority:** High | Medium | Low
**Date Created:** YYYY-MM-DD
**Date Implemented:** YYYY-MM-DD (when moved to done/)
**Origin:** Where the idea came from
**Author:** Name (with AI assistance)
```

### 4.2 Checkpoint Headers

```markdown
# Checkpoint: Scope Description

**Date:** YYYY-MM-DD
**Session:** Session number or identifier
**DSM Version:** vX.Y.Z (if applicable)
```

Followed by: What Was Accomplished, Context, Status, Next Steps.

### 4.3 Handoff Headers

```markdown
# Session Handoff

**Date:** YYYY-MM-DD
**From:** Session identifier
**To:** Next session
```

Followed by: Session Summary, What Was Done, Open Items, Pending Work.

### 4.4 Core Document Headers

```markdown
# Document Title

**Version:** X.Y.Z
**Date:** Month Year
**Purpose:** One-sentence description
```

---

## 5. Cross-Reference Conventions

### 5.1 Section References

Format: `Section X.Y.Z` (always with "Section" prefix)

- Refer to methodology sections by number, not by phase name
- Example: "See Section 2.1" not "See Phase 0"
- Valid levels: Section 2, Section 2.1, Section 2.1.3, Section 2.1.3.1

### 5.2 Appendix References

Format: `Appendix X.Y.Z` (always with "Appendix" prefix)

- Letters map to topics: A (Environment), B (Phases), C (Advanced), D (Domain), E (Quick Reference)

### 5.3 Backlog References

Format: `BACKLOG-###` (always with prefix, three-digit number)

- Used in: commit messages, CHANGELOG entries, cross-document references
- Example: "Implement BACKLOG-080: Documentation Project Best Practices"

### 5.4 Document References

Format: backtick-quoted filename with relative path

- Example: `` `DSM_1.0_Data_Science_Collaboration_Methodology_v1.1.md` ``
- For sections within a document: "Section 3.2 in `DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md`"

---

## 6. Versioning Workflow

### 6.1 Semantic Versioning for Content

Adapted from software semver:

| Change Type | Version Component | Examples |
|-------------|------------------|----------|
| Structural reorganization, breaking changes | MAJOR (X) | Splitting a document, renaming core files, changing numbering scheme |
| New content, new sections, new documents | MINOR (Y) | Adding DSM_5.0, new appendix, new template |
| Corrections, clarifications, formatting | PATCH (Z) | Fixing cross-references, typo fixes, wording improvements |

### 6.2 Version Bump Cadence

- One version bump per session (batch changes within a session)
- CHANGELOG entry required for every version
- Git tag (`vX.Y.Z`) for releases; optional `-consistency` suffix for post-release cleanup

### 6.3 Release Workflow

1. Make content changes
2. Update CHANGELOG.md (keepachangelog format, reference BACKLOG-### items)
3. Update README.md version section
4. Update DSM_0 if new sections or documents added
5. Commit with descriptive message
6. Create git tag for releases
7. Push commits and tags

---

## 7. Content Quality Standards

### 7.1 Writing Standards

- Professional tone, no emojis
- Text conventions: "WARNING:" not warning emojis, "OK:" not checkmarks, "ERROR:" not crosses
- Punctuation: commas for connecting phrases (not em-dashes)
- Hierarchical numbering: self-documenting structure (no table of contents needed)
- Code blocks with language specification when applicable

### 7.2 Pre-Release Quality Checklist

Before committing a content release:

- [ ] Cross-references verified (Section X.Y.Z targets exist)
- [ ] BACKLOG references match actual items
- [ ] File naming follows conventions (Section 3)
- [ ] Metadata headers present and complete (Section 4)
- [ ] No orphaned links or references to deleted content
- [ ] CHANGELOG updated with version entry
- [ ] DSM_0 listing current (if new documents added)

### 7.3 Factual Accuracy

- Never estimate metrics, counts, or measurements
- State actual computed values or admit uncertainty
- Verify file paths before referencing them
- Cite sources for external claims

---

## 8. Session Management for Documentation Projects

### 8.1 What "Done" Means

A documentation sprint is complete when:
- All planned content is written and reviewed
- Cross-references are verified
- CHANGELOG entry is written
- Version is bumped (if releasing)
- Checkpoint or handoff is created

### 8.2 Checkpoints vs Handoffs

**Checkpoints** (`dsm-docs/checkpoints/`): Historical milestone snapshots. Created at significant milestones (releases, major feature completions). Kept permanently as recovery points.

**Handoffs** (`dsm-docs/handoffs/`): Session-end resumption documents. Created every session that has pending work. Consumed and replaced by the next session.

### 8.3 Session Close-Out

1. Commit all pending changes
2. Push to remote
3. Create handoff if complex work remains
4. Update session memory (MEMORY.md)

---

## 9. Documentation Review Cycle

### 9.1 Self-Review Checklist

Before finalizing any document:

1. Read the document end-to-end (not just the section you edited)
2. Verify all cross-references resolve
3. Check metadata headers are complete
4. Confirm naming convention compliance
5. Run the pre-release quality checklist (Section 7.2) for releases

### 9.2 Cross-Reference Validation

For projects with extensive cross-references:
- Maintain a reference map (which documents reference which sections)
- When renaming or removing sections, search for all inbound references
- Consider automated tooling (BACKLOG-048: Semantic Cross-Reference Validation)

### 9.3 Feedback Integration

Documentation projects in the DSM ecosystem should track methodology effectiveness:
- `dsm-docs/feedback-to-dsm/methodology.md`: Per-section scores for DSM guidance used
- `dsm-docs/feedback-to-dsm/backlogs.md`: Feedback-derived backlog items for DSM Central

**Hub exemption:** Hub projects (DSM Central) route improvements directly to
`plan/backlog/`; the `dsm-docs/feedback-to-dsm/` directory pattern applies to spoke projects
that propose changes upstream. The hub processes incoming feedback via `_inbox/`
and creates backlog items directly.

---

## 10. Integration with Standard DSM

### 10.1 Applicable DSM Sections

| DSM Section | Applies to Documentation Projects? | Notes |
|-------------|-------------------------------------|-------|
| DSM 1.0 Section 2.5 (Communication) | Yes | Writing standards, stakeholder communication |
| DSM 1.0 Section 6.1 (Session Management) | Yes | Handoffs, checkpoints, memory |
| DSM 2.0 (PM Guidelines) | Yes | Sprint planning, deliverable tracking, templates |
| DSM 3.0 (Implementation Guide) | Partially | CLAUDE.md setup, `@` references, feedback system |
| DSM 0.2 (Custom Instructions) | Yes | Project type detection, pre-generation brief |

### 10.2 CLAUDE.md Configuration

Every documentation project CLAUDE.md must include:
1. `@` reference to DSM_0.2 Custom Instructions
2. Project type declaration: "Documentation"
3. DSM Central introduction block (for spoke projects)
4. Reinforcement of pre-generation brief protocol
5. Command execution rules (read-only vs write)
6. Session management references

See `dsm-data-science-portfolio/.claude/CLAUDE.md` for a working example.

---

## 11. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-08 | Initial release. Codifies DSM Central's implicit conventions for documentation projects. BACKLOG-080. |
