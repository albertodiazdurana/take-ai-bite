Create a new DSM backlog item.

**Flags:** `--sprint` forces sprint-plan template injection regardless of title; `--no-template` suppresses injection even when sprint intent is detected.

## Steps

1. Find the highest existing BACKLOG number by listing files in `plan/backlog/developments/`, `plan/backlog/improvements/`, and `plan/backlog/done/`
2. Ask the user for:
   - **Title:** Short description
   - **Priority:** High / Medium / Low
   - **Type:** Development (external repo) or Improvement (internal DSM)
   - **Problem:** What problem does this solve?
   - **Untracked files:** Will this change modify files outside git tracking?
     (user-level commands in `~/.claude/commands/`, gitignored files in `.claude/`,
     cross-repo artifacts). If yes, the backlog item MUST include a Revert Procedure
     section per the Revert Safeguards Protocol in DSM_0.2.
2.5. **Sprint-plan detection:** check the title and flags for sprint-plan intent. Sprint intent is detected when EITHER:
   - The title matches `^Sprint\s+\d+\b` (case-insensitive, e.g., "Sprint 5: RAG pipeline"), OR
   - The user passed `--sprint` as an argument.

   If sprint intent is detected AND the user did NOT pass `--no-template`, use the **Sprint Plan Template Scaffold** (below) instead of the standard **Backlog Template**. Otherwise use the standard template.

   The detection regex requires a digit after "Sprint" so titles like "Sprint Boundary Checklist tooling" do not falsely trigger injection. Origin: sprint-plan template injection, paired with the sprint-plan structural audit at `/dsm-align`.
3. Generate the next BACKLOG number (highest + 1)
4. Create the file at `plan/backlog/{developments|improvements}/BACKLOG-XXX_short-description.md`

## Backlog Template

```markdown
# BACKLOG-XXX: [Title]

**Status:** Proposed
**Priority:** [High/Medium/Low]
**Date Created:** YYYY-MM-DD
**Origin:** [Where the idea came from]
**Author:** {author}

---

## Problem Statement

[User's problem description]

## Proposed Solution

[Outline the approach]

## Success Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Test Plan

<!-- Required for BLs that use a feature branch.
     Exempt for direct-to-main commits (mechanical updates, session artifacts).
     Write at BL creation time, not at implementation time. -->

Conditions that must pass before the implementing branch merges to main:

- [ ] [Specific, verifiable condition 1]
- [ ] [Specific, verifiable condition 2]

## Risks (per DSM_0.2 §21.2)

<!-- MUST for any BL that modifies methodology files, skill files, hooks,
     settings, or introduces new behavioral protocols. MAY (optional) for
     mechanical status-update BLs (BL → done move, typo fix, version bump).
     "Risks: none known" is NOT acceptable; if no material risks, write
     "No material risks identified because [substantive reason]." -->

- **[Failure mode 1]:** [mitigation, or stated acceptance]
- **[Failure mode 2]:** [mitigation, or stated acceptance]

## Test Execution Log (per DSM_0.2 §21.3)

<!-- Filled by the implementer at close time, before proposing merge.
     Each Test Plan item gets a per-item result line with concrete evidence
     (command run + output captured, file path + line range, or behavioral
     observation with citation). "All passed" without per-item evidence is
     NOT acceptable closure.
     For tests deferred by design (e.g., next-session validation), write
     "T-N deferred: [trigger + verification plan]" and add to the Pending
     Verification subsection below.
     Trivial-BL exemption inherited from §21.2: mechanical status-update
     BLs do not need a Test Execution Log if no behavior change. -->

- T-1: [result + evidence]
- T-2: [result + evidence]

### Pending verification

<!-- List any deferred tests here. Each item is propagated to the next
     session's suggested work via the wrap-up handoff. Empty if all tests
     ran in-session. -->

- [ ] T-N: [what triggers verification, how to verify when triggered]

## Revert Procedure

<!-- Include this section if the change touches untracked files.
     Remove if all changes are git-tracked. See DSM_0.2 Revert Safeguards Protocol. -->

**Pre-edit snapshots:** `plan/archive/BL-XXX_pre-edit-snapshots.md`

1. [Step to undo change 1]
2. [Step to undo change 2]

**Verification:** [How to confirm the revert is clean]

---

**Author:** {author} (with AI assistance)
```

## Sprint Plan Template Scaffold

Use this scaffold instead of the standard Backlog Template when Step 2.5
detects sprint-plan intent. Provides headings + 1-line placeholders only;
**see DSM_2.0.C §1 Template 8 for the authoritative content guidance.**
The scaffold is intentionally minimal to avoid drift between this skill
and the methodology source: if Template 8 evolves, only the source needs
updating, and this scaffold continues to reference it.

```markdown
# BACKLOG-XXX: Sprint N , [Sprint Title]

**Status:** Proposed
**Priority:** [High/Medium/Low]
**Date Created:** YYYY-MM-DD
**Origin:** [Where the idea came from]
**Author:** {author}

**Duration:** [e.g., 2 weeks, 5 sessions]
**Goal:** [single sentence stating the sprint's primary outcome]
**Prerequisites:** [BLs, prior sprints, environmental conditions; "None" if standalone]

---

## Research Assessment

<!-- See DSM_2.0.C §1 Template 8 for guidance.
     Capture the research that grounds this sprint's plan, OR explain
     why no research pass is needed (e.g., mechanical extension of a
     prior sprint). -->

[Research assessment content]

## Deliverables

<!-- See DSM_2.0.C §1 Template 8 for guidance. List concrete artifacts
     the sprint will produce, with acceptance criteria each. -->

- [ ] [Deliverable 1 with acceptance criterion]
- [ ] [Deliverable 2 with acceptance criterion]

## Phases

<!-- See DSM_2.0.C §1 Template 8 for guidance. Break the sprint into
     phases with clear boundaries. Each phase ends with the Phase
     Boundary Checklist below. -->

### Phase 1: [Phase Name]

[Description, success criteria, exit conditions]

## Phase Boundary Checklist

<!-- See DSM_2.0.C §1 Template 8 for guidance. Run at the end of each
     phase to verify completeness before moving to the next. -->

- [ ] [Phase exit criterion 1]
- [ ] [Phase exit criterion 2]

## Sprint Boundary Checklist

<!-- See DSM_2.0.C §1 Template 8 for guidance. Run at sprint closure
     to verify all deliverables landed and no loose ends remain. The
     hard gate in /dsm-go Step 3.6 (sprint-plan structural audit) blocks closure when this
     section is missing. -->

- [ ] All Deliverables checked
- [ ] All Phase Boundary Checklists complete
- [ ] [Other sprint exit criteria]

## Test Plan

Conditions that must pass before the sprint is declared complete:

- [ ] [Specific, verifiable condition 1]
- [ ] [Specific, verifiable condition 2]

## Revert Procedure

<!-- Include this section if the sprint touches untracked files.
     Remove if all changes are git-tracked. See DSM_0.2 Revert Safeguards Protocol. -->

---

**Author:** {author} (with AI assistance)
```

5. Update the README in the target directory (`plan/backlog/{developments|improvements}/README.md`):
   - Add a new row to the **Active Items** table with the BL#, title, priority, status ("Proposed"), and today's date
   - Insert the row in priority order (High before Medium before Low), then by date within the same priority
6. Confirm the file was created, show the path, and note the README was updated. If the Sprint Plan Template Scaffold was used, also note "Sprint Plan template injected; fill the scaffold sections per DSM_2.0.C §1 Template 8."
