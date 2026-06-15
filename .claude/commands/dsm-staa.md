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
   **Off-by-one warning (per BL-442):** when defaulting to the latest archived transcript, the wrap-up that just ran does NOT archive its own transcript (only the next `/dsm-go` Step 5.5 does), so "latest archived" is the session BEFORE the one the user most recently wrapped up. If `.claude/last-wrap-up.txt` exists and its `session:` value is greater than the session number parsed from the latest archived transcript's `# Session N Transcript` header, surface (conversation text, non-halting): "Defaulting to {filename} (S{N}). Note: you most recently wrapped up S{N+1}, whose transcript is not yet archived (the next `/dsm-go` archives it). To analyze S{N+1} now, pass its live transcript explicitly; otherwise proceeding with the latest archived S{N}." Proceed with the latest-archived default unless the user redirects. The warning fires only in this specific off-by-one window, not on every default invocation.
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
8. **Regenerate compact reasoning-lessons mirror (per BL-433, transform per BL-447):** After Step 6's appends and any Step 7 prunes have landed in `.claude/reasoning-lessons.md`, regenerate `.claude/reasoning-lessons-compact.md`. **Run the canonical regeneration transform defined in DSM_0.2.A §8.1 ("Canonical regeneration transform")**, then run the two post-generation sanity checks specified there. Do NOT re-inline a transform here: the canonical awk in §8.1 is the single source of truth (re-inlining a divergent copy was the BL-447 drift bug that silently emptied the mirror on flat-structured spoke files). The §8.1 transform is shape-tolerant (works whether or not the live file has a `## Categories` heading), strips the `[auto]`/`[STAA]` provenance prefix, preserves `### Category` headings, and fails loud (entry-count + size-floor warnings) instead of producing a silent header-only mirror.

   **Why:** /dsm-go Step 1.5 reads the compact mirror as the boot-time canonical context. /dsm-staa runs OUTSIDE the wrap-up flow, so its appends to the live file create staleness in the mirror that persists until the next /dsm-wrap-up (potentially 24+ hours later). Regenerating here closes the gap so the next session boot reads a fresh mirror.

   **Cross-reference:** /dsm-wrap-up Step 0 owns the same rule. If the rule changes (new entry-prefix tag, category-heading shape, freshness-header drift), both /dsm-wrap-up Step 0 and /dsm-staa Step 8 must update together. See **DSM_0.2.A Reasoning Lessons Protocol** for the canonical specification. The auto-generated comment in the mirror header references both regenerators ("/dsm-wrap-up Step 0 or /dsm-staa Step 8") so provenance is honest.

   **Origin:** BL-433 (S207, derived from haystack-magic S7 STAA continuation 2026-05-02). After /dsm-staa appended 6 [STAA] entries and pruned 2 [auto] entries at ~22:17, the compact mirror remained at its 22:04 state from S7 wrap-up, 13 min stale, missing 6 lessons and including 2 pruned ones. The agent regenerated inline manually; this step makes the regeneration a normative part of /dsm-staa.
9. **Write `last-staa.txt` (per BL-442):** After the analysis lands, write `.claude/last-staa.txt` so `/dsm-go` Step 5.7 can suppress the STAA reminder for sessions already analyzed. Parse the analyzed session number `N` from the subject transcript's `# Session N Transcript` header (not the filename). Schema:

   ```
   # Last /dsm-staa run
   date: YYYY-MM-DD
   analyzed_session: N
   analyzed_transcript: .claude/transcripts/{file}
   appended_lessons: M
   pruned_lessons: K
   ```

   `M` is the count appended in Step 6, `K` the count pruned in Step 7 (0 if none). The marker is gitignored and local-only; on a missing marker `/dsm-go` Step 5.7 degrades to "remind" (the conservative direction). Multi-pass STAA on the same session overwrites the marker (it tracks "last analyzed", not "ever analyzed"). This is the one project-file write STAA performs beyond `.claude/reasoning-lessons.md` and its compact mirror.

## Notes

- This agent produces NO session transcript. The IMPORTANT block at the top of this file explains the two files involved (archived subject vs live reasoning log) and the meta-recursion concern. Do not re-derive the rationale; read the IMPORTANT block.
- This agent does NOT modify any project files except `.claude/reasoning-lessons.md`, its compact mirror `.claude/reasoning-lessons-compact.md` (Step 8), and `.claude/last-staa.txt` (Step 9). All three are gitignored local-only artifacts; none is committed.
- The analysis session is lightweight; no git commits, no wrap-up needed
- If the transcript is very long (500+ lines), warn about context budget and offer to analyze in sections
- Cross-reference findings with existing MEMORY.md entries to avoid redundancy
- Be specific in lessons; "be more careful" is not actionable, "check file existence before editing" is
