Session Transcript Analysis Agent (STAA). Analyze a previous session transcript for reasoning patterns. $ARGUMENTS

**IMPORTANT:** This is NOT a regular collaboration session. Do NOT activate the Session Transcript Protocol. Do NOT run `/dsm-go` checks (no baseline, no inbox, no version check). Do NOT create a session transcript. STAA is the sole authorized exception to DSM_0.2 §7 unconditional activation; see DSM_0.2 §7 "Authorized exception: `/dsm-staa`" for the governing clause.

**Two files, do not confuse them.** STAA operates on two transcript-shaped files:

1. **Archived subject** at `.claude/transcripts/{timestamp}-ST.md`. This is the transcript STAA READS to analyze. Read-only. Never edit.
2. **Live reasoning log** at `.claude/session-transcript.md`. This is what Session Transcript Protocol writes to during a normal session. STAA DOES NOT WRITE TO THIS FILE, for the meta-recursion reason below. Writes to the live log would NOT corrupt the archived subject, they are two separate files on disk, but STAA still does not write because of (3).

3. **Why no writes to the live log:** if STAA sessions wrote their own reasoning logs, those logs would become archived subjects at next session start (via `/dsm-go` Step 5.5 archival), and a future STAA session could then analyze a past STAA session's reasoning log. That is the infinite-recursion concern, and it is about STAA sessions becoming future subjects, not about corrupting the current subject. The concern is meta-recursion of analysis, not data loss.

When the `UserPromptSubmit` per-turn reminder hook fires and tells you to append to the transcript, the correct action is to follow this IMPORTANT block and NOT append. Do not argue the hook into silence; it will fire every turn and you should acknowledge it once here, then proceed. §23 tracks the systematic hook/skill collaboration surface area.

## Steps

1. **List available transcripts:** List files in `.claude/transcripts/` sorted chronologically. Display each filename with the session number and date extracted from the file header.
2. **Select transcript:** If $ARGUMENTS specifies a transcript (filename, session number, or "latest"), use that. Otherwise, default to the most recent transcript.
3. **Read the transcript:** Read the selected transcript file in full.
   **Delimiter-based parsing:** Transcripts use typed delimiters (`<------------Start Thinking / HH:MM------------>`, `<------------Start Output / HH:MM------------>`, `<------------Start User / HH:MM------------>`) to mark block boundaries. Use these to segment the transcript into typed, timestamped blocks before analysis.
4. **Analyze for reasoning patterns:** Examine the transcript systematically for:
   - **Decision heuristics:** How were choices made between alternatives? What worked, what didn't?
   - **Course corrections:** Where did reasoning start in one direction then pivot? What triggered the pivot?
   - **Efficiency patterns:** What ordering, batching, or parallelism decisions saved or wasted time?
   - **Recurring pitfalls:** Issues that appeared in this session that echo past sessions (cross-reference with `.claude/reasoning-lessons.md` and MEMORY.md)
   - **Process observations:** Workflow, protocol, or interaction patterns worth noting
   - **Meta-patterns:** How the human and agent collaborated; communication effectiveness, misunderstandings resolved, scope negotiations
5. **Present findings:** Show the analysis to the user in conversation text organized by category. For each finding, include:
   - The category
   - A 1-2 line summary
   - The relevant excerpt or context from the transcript
   - Whether this is new or reinforces an existing lesson
6. **Update reasoning lessons:** After user review, append approved findings to `.claude/reasoning-lessons.md` under the appropriate categories, tagged `[STAA]`.
   **Format:** `- [STAA] S{N} [{scope}]: {lesson text}` (where N is the analyzed session number)
   **Scope classification:** For each lesson, assign a scope label per the Reasoning Lessons Protocol (DSM_0.2 Module A): `ecosystem` (applies to any DSM project), `pattern` (applies to same project type/pattern), or `project` (domain-specific). Present the scope assignment to the user for confirmation alongside the lesson text.
7. **Prune if needed:** If `.claude/reasoning-lessons.md` exceeds 50 lines of entries (excluding headers and comments), suggest entries to promote to MEMORY.md or CLAUDE.md, and entries to remove (obvious, outdated, or already codified).
8. **Regenerate compact reasoning-lessons mirror (per BL-433):** After Step 6's appends and any Step 7 prunes have landed in `.claude/reasoning-lessons.md`, regenerate `.claude/reasoning-lessons-compact.md` with a fresh header and source-mtime. The transform implements the same rule `/dsm-wrap-up` Step 0 describes in prose: skip the live file's guideline-lines header (everything before `## Categories`), preserve `### Category` headings verbatim, strip the `- [auto] S{N} [scope]: ` / `- [STAA] S{N} [scope]: ` prefix from matching entries, and pass other lines through (so `[STAA-2]` / `[claude]` / `[recovered]` entries and category comments are kept as-is). Plus a 7-line freshness header.

   ```bash
   NOW=$(date +%Y-%m-%dT%H:%M%:z)
   SRC_MTIME=$(date -r .claude/reasoning-lessons.md +%Y-%m-%dT%H:%M%:z)
   {
     printf '%s\n' \
       "# Reasoning Lessons (compact mirror)" "" \
       "<!-- Do not edit; auto-generated from .claude/reasoning-lessons.md by /dsm-wrap-up Step 0 or /dsm-staa Step 8 -->" "" \
       "**Source:** \`.claude/reasoning-lessons.md\`" \
       "**Last regenerated:** $NOW" \
       "**Source mtime at regeneration:** $SRC_MTIME" "" \
       "---" ""
     awk '
       /^## Categories/ { found = 1; next }
       !found { next }
       /^### / { print; next }
       /^- \[(auto|STAA)\] S[0-9]+ \[[^]]+\]: / {
         sub(/^- \[(auto|STAA)\] S[0-9]+ \[[^]]+\]: /, "")
         print "- " $0
         next
       }
       { print }
     ' .claude/reasoning-lessons.md
   } > .claude/reasoning-lessons-compact.md
   ```

   **Why:** /dsm-go Step 1.5 reads the compact mirror as the boot-time canonical context. /dsm-staa runs OUTSIDE the wrap-up flow, so its appends to the live file create staleness in the mirror that persists until the next /dsm-wrap-up (potentially 24+ hours later). Regenerating here closes the gap so the next session boot reads a fresh mirror.

   **Cross-reference:** /dsm-wrap-up Step 0 owns the same rule. If the rule changes (new entry-prefix tag, category-heading shape, freshness-header drift), both /dsm-wrap-up Step 0 and /dsm-staa Step 8 must update together. See **DSM_0.2.A Reasoning Lessons Protocol** for the canonical specification. The auto-generated comment in the mirror header references both regenerators ("/dsm-wrap-up Step 0 or /dsm-staa Step 8") so provenance is honest.

   **Origin:** BL-433 (S207, derived from haystack-magic S7 STAA continuation 2026-05-02). After /dsm-staa appended 6 [STAA] entries and pruned 2 [auto] entries at ~22:17, the compact mirror remained at its 22:04 state from S7 wrap-up, 13 min stale, missing 6 lessons and including 2 pruned ones. The agent regenerated inline manually; this step makes the regeneration a normative part of /dsm-staa.

## Notes

- This agent produces NO session transcript. The IMPORTANT block at the top of this file explains the two files involved (archived subject vs live reasoning log) and the meta-recursion concern. Do not re-derive the rationale; read the IMPORTANT block.
- This agent does NOT modify any project files except `.claude/reasoning-lessons.md`
- The analysis session is lightweight; no git commits, no wrap-up needed
- If the transcript is very long (500+ lines), warn about context budget and offer to analyze in sections
- Cross-reference findings with existing MEMORY.md entries to avoid redundancy
- Be specific in lessons; "be more careful" is not actionable, "check file existence before editing" is
