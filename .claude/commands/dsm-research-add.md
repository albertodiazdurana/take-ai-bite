Add a new research file to `dsm-docs/research/` and register it in the active index.

## Usage

The user invokes `/dsm-research-add` with no arguments, or with a topic hint
(e.g., "/dsm-research-add humanizer audit"). The skill prompts for the rest.

## Steps

1. Ask the user for:
   - **Topic / one-line title:** what the research is about (used for both filename and README row).
   - **Linked BL (optional):** existing BL number this research is tied to or informs. Empty if no BL yet.
   - **Sub-table category:** pick one of:
     1. Tied to an active backlog item (research is the BL's primary deliverable)
     2. Informs an active BL but is not its primary deliverable
     3. Findings ready for promotion to a BL (no BL filed yet)
     4. Tool / methodology assessments awaiting decision
     5. Untracked carryover (use only when the file already exists outside git)

   Default selection: if a linked BL is supplied, default to (1). If not, default to (3).
2. Compute the filename: `YYYY-MM-DD_{kebab-case-topic}.md` using today's date and a short kebab-cased version of the topic. If the topic is too long for a clean filename, ask the user for a shorter slug.
3. Validate filename against the convention `YYYY-MM-DD_{topic}.md`. If non-conforming (legacy `.txt` files or folders are allowed but warned), ask the user to confirm before proceeding.
4. Validate the linked BL (if supplied):
   - Run `ls dsm-docs/plans/BACKLOG-{N}_*.md dsm-docs/plans/done/BACKLOG-{N}_*.md 2>/dev/null`
   - If no match, prompt: "BL-{N} not found in active or done plans. Continue with this link anyway?"
5. Create `dsm-docs/research/{filename}` with the header stub below. Substitute `{topic}`, `{date}`, `{linked-bl-or-none}`, `{author}`.
6. Insert a row into `dsm-docs/research/README.md` under the chosen sub-table heading. Preserve date-ascending order within the sub-table. Row format depends on the sub-table:
   - Sub-table 1 (Tied to active BL): `| {date} | [{topic}]({filename}) | BL-{N} | {status} |`
     where `{status}` is "Active" by default.
   - Sub-table 2 (Informs an active BL): `| {date} | [{topic}]({filename}) | BL-{N} | Active |`
   - Sub-table 3 (Ready for promotion): `| {date} | [{topic}]({filename}) | File BL "{topic}" or move to done | New finding |`
   - Sub-table 4 (Tool / methodology assessments): `| {date} | [{topic}]({filename}) | {decision-needed-by-user} | Awaiting decision |`
   - Sub-table 5 (Untracked carryover): `| {date} | [{topic}]({filename}) | {decision-needed-by-user} | Untracked since S{N} |`
7. Stage the new research file and the README change with `git add`. Do NOT commit; let the user decide when.
8. Confirm to the user: filename created, sub-table updated, BL link validated.

## Header stub template

```markdown
# {topic}

**Date:** {date}
**Linked BL:** {linked-bl-or-"(none, candidate for promotion)"}
**Author:** {author}
**Status:** Active
**Validation depth:** [Single-pass internal | Multi-pass (per DSM_0.2 §10.1)]

---

## Purpose / Question

[One paragraph stating what this research investigates and why.]

## Sources

[List sources with URLs and dates fetched, per DSM_0.2 §10.]

## Findings

[Findings narrative; sub-headings as needed.]

## Conclusion

[Recommendation, decision, or hand-off to the consuming BL.]
```

## Important

- Do NOT auto-commit; the user decides when to commit.
- Filename convention is mandatory for new files. Legacy non-conforming files (`.txt`, `folders/`, missing-underscore dates) are tolerated but never created by this skill.
- The skill modifies only `dsm-docs/research/{filename}` (new) and `dsm-docs/research/README.md` (existing). No mirror sync, no FEATURES.md update; research files are internal artifacts.
- Pairs with `/dsm-research-done`, which moves the file to `done/` and removes its README row.
- Origin: BL-425 (closes the research/README maintenance gap surfaced in S205).
