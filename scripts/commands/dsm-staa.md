Session Transcript Analysis Agent (STAA). Analyze a previous session transcript for reasoning patterns. $ARGUMENTS

**IMPORTANT:** This is NOT a regular collaboration session. Do NOT activate the Session Transcript Protocol. Do NOT run `/dsm-go` checks (no baseline, no inbox, no version check). Do NOT create a session transcript. STAA is the sole authorized exception to DSM_0.2 §7 unconditional activation; see DSM_0.2 §7 "Authorized exception: `/dsm-staa`" for the governing clause.

**Two files, do not confuse them.** STAA operates on two transcript-shaped files:

1. **Archived subject** at `.claude/transcripts/{timestamp}-ST.md`. This is the transcript STAA READS to analyze. Read-only. Never edit.
2. **Live reasoning log** at `.claude/session-transcript.md`. This is what Session Transcript Protocol writes to during a normal session. STAA DOES NOT WRITE TO THIS FILE, for the meta-recursion reason below. Writes to the live log would NOT corrupt the archived subject, they are two separate files on disk, but STAA still does not write because of (3).

3. **Why no writes to the live log:** if STAA sessions wrote their own reasoning logs, those logs would become archived subjects at next session start (via `/dsm-go` Step 5.5 archival), and a future STAA session could then analyze a past STAA session's reasoning log. That is the infinite-recursion concern, and it is about STAA sessions becoming future subjects, not about corrupting the current subject. The concern is meta-recursion of analysis, not data loss.

When the `UserPromptSubmit` per-turn reminder hook fires and tells you to append to the transcript, the correct action is to follow this IMPORTANT block and NOT append. Do not argue the hook into silence; it will fire every turn and you should acknowledge it once here, then proceed. §23 tracks the systematic hook/skill collaboration surface area.

**IMPORTANT (PII / egress safeguard).** The subject transcript may contain personal data (colleagues, clients, or other named individuals, on a project that handles sensitive data). STAA treats its own outputs as an **egress zone**: every excerpt it presents (Step 5) and every lesson it appends (Step 6) must be **name-free** — refer to people by **role, not name**. Never echo a matched name, or a name-bearing pattern, into `.claude/reasoning-lessons.md`, its compact mirror, or the conversation. This is the STAA-specific case of the Egress Leak-Scan Generic Reporting Rule (DSM_0.2.C §5.8).

**Why a name here propagates (it is not contained to the local file).** `.claude/reasoning-lessons.md` is not a dead end: `/dsm-wrap-up` Step 0 pushes new lessons to DSM Central's `_inbox` (a cross-gap write), and `/dsm-go` Step 1.5 reads the compact mirror as boot context every session. So one name in one `[STAA]` lesson can propagate across the air-gap and into every future boot. Step 6 appends after user review (a human gate), but that review is a PII gate, not only a quality gate.

**Scrub-before-analyse (projects with a declared PII/egress policy).** Prefer scrubbing names from the transcript before running STAA. The transcript is gitignored, so `git filter-repo` does **not** reach it — the transcript scrub is a separate, manual step from any tracked-history scrub.

## Step 0: Active-Session Detection

STAA shares the one git working copy with any other Claude Code conversation in this
directory, yet (unlike `/dsm-go` Step 0.7) it has historically run no concurrent-session
check. A STAA session started while a main session is live and unwrapped can race that
session's working copy — a concurrent-session incident where a STAA window created a branch
and committed a BL, moving the live session's `HEAD`. Before Step 1, STAA runs a **read-only**
§26 detection:

1. Read `.claude/session.lock`. If absent → no active session; proceed to Step 1.
2. If present, probe the recorded pid for liveness (reuse the `/dsm-go` Step 0.7a /
   DSM_0.2.A §26.3 snippet **verbatim** — same block, so the verdict logic never drifts):

   ```bash
   LOCK_PID=$(awk '/^pid:/ {print $2}' .claude/session.lock)
   case "$LOCK_PID" in
     ''|unknown|*[!0-9]*) echo "VERDICT=UNKNOWN" ;;
     *) if kill -0 "$LOCK_PID" 2>/dev/null && ps -p "$LOCK_PID" -o comm= 2>/dev/null | grep -q claude
        then echo "VERDICT=LIVE"; else echo "VERDICT=STALE"; fi ;;
   esac
   ```

3. Act on the verdict per §26.3 (the verdict is a finding, never a recommendation):
   - **`LIVE`** → **non-suppressible stop.** Display the lockfile contents and the verdict,
     then halt: "Session {N} is active and unwrapped; wrap it up before running STAA
     (concurrent working-copy hazard)." Do not proceed to Step 1. Non-suppressible under
     DSM_0.2 §8.9.1 — auto mode does not bypass it.
   - **`STALE` / `UNKNOWN`** → warn (non-halting): report the verdict and the lock's
     transcript mtime as a weak secondary signal, and let the user decide whether to
     proceed. Do not convert mtime into a verdict (a long-cold lock is equally consistent
     with a crashed window and an idled-then-resumed one).

**STAA reads, never writes, the lock.** STAA does not create or modify `.claude/session.lock`
— it runs in a separate conversation and must not claim the single-session invariant (the
§26.5 parallel-sibling reasoning). This detection is additive to §26: it does not change
`/dsm-go` Step 0.7, the §26.3 verdict logic, or the §26.5 parallel-session exemption.

## Steps

1. **List available transcripts:** List files in `.claude/transcripts/` sorted chronologically. Display each filename with the session number and date extracted from the file header.
2. **Select subject transcript (per BL-509):** Selection is a decision over three markers, not a default plus a warning. Read all three before choosing:

   | Symbol | Source | Meaning |
   |---|---|---|
   | `A` | the `# Session N Transcript` header of the newest file in `.claude/transcripts/` | latest **archived** session |
   | `W` | `session:` in `.claude/last-wrap-up.txt` | latest **wrapped** session |
   | `S` | `analyzed_session:` in `.claude/last-staa.txt` | latest **analysed** session |

   Parse `A` from the file's own header, never from its filename (the filename carries the session's start timestamp, not its number). A missing or unparseable `last-staa.txt` means nothing has been analysed: treat `S` as lower than every candidate, which is BL-442's degrade-to-conservative direction and can only produce a subject, never a halt. A missing `last-wrap-up.txt` means treat `W` as equal to `A`.

   **There are at most two candidate subjects.** The latest archived transcript (session `A`) and, only when `W > A`, the live `.claude/session-transcript.md` (session `W`), which the wrap-up did not archive because `/dsm-go` Step 5.5 is the only archiver. A candidate is **unanalysed** when `S` is below its session number. Select on how many candidates are unanalysed:

   | Condition | Unanalysed candidates | Behaviour |
   |---|---|---|
   | `$ARGUMENTS` names a transcript | n/a | Use it; explicit user intent always wins. If `S` is at or above its header session, warn (non-halting) that it is already analysed, then proceed |
   | `W > A` and `S < A` | 2 (archived **and** live) | **Halt and ask which**, naming both by session number and path |
   | `W > A` and `A <= S < W` | 1 (live only) | **Default to the live transcript**, stating that the archived one is already analysed. Do not default to the archived one and then warn |
   | `W <= A` and `S < A` | 1 (archived only) | **Default to the latest archived transcript.** This is the ordinary path, after a `/dsm-go` has archived the wrapped session |
   | `S >= W` and `S >= A` | 0 | **Halt before Step 4. No unanalysed subject exists.** See the halt contract below |

   **The five rows are exhaustive and non-overlapping** over the two comparisons `W` vs `A` and `S` vs each candidate. A sixth row is therefore not a gap being filled but a new state being invented, and needs its own BL rather than a silent edit.

   **Halt contract for the zero-candidate row (per BL-509 T-6).** Report the three marker values that drove the decision and the path each was read from, so a wrong halt is diagnosable in one read rather than presenting as a bare "nothing to analyse". Then **stop**: Steps 6, 7, 8 and 9 are all skipped. Step 9 especially: a null run must never overwrite `.claude/last-staa.txt`, because that marker carries the provenance of the last real run.

   **Supersedes BL-442's off-by-one warning.** BL-442 added a non-halting warning for the `W > A` window and recorded in its Risks the expectation that the warning would fire only inside that window rather than on every default invocation. Measurement falsified that expectation: the window was active on six consecutive runs (S241 through the 2026-08-19 run, per the `.claude/reasoning-lessons.md` provenance header) and the default was overridden on all six. A default taken zero times out of six is the wrong default, so rows 2 and 3 replace the warning rather than soften it. BL-442's section C had already written this option down.
3. **Read the transcript:** Read the selected transcript file in full.
   **Delimiter-based parsing:** Transcripts use typed delimiters (`<------------Start Plan / HH:MM------------>`, `<------------Start Output / HH:MM------------>`, `<------------Start User / HH:MM------------>`) to mark block boundaries. Use these to segment the transcript into typed, timestamped blocks before analysis.
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
   - The relevant excerpt or context from the transcript — **with person-names generalized to roles in the quote** (per the PII/egress safeguard above; never paste a verbatim name-bearing line)
   - Whether this is new or reinforces an existing lesson
6. **Update reasoning lessons:** After user review, append approved findings to `.claude/reasoning-lessons.md` under the appropriate categories, tagged `[STAA]`.
   **Format:** `- [STAA] S{N} [{scope}]: {lesson text}` (where N is the analyzed session number)
   **Scope classification:** For each lesson, assign a scope label per the Reasoning Lessons Protocol (DSM_0.2 Module A): `ecosystem` (applies to any DSM project), `pattern` (applies to same project type/pattern), or `project` (domain-specific). Present the scope assignment to the user for confirmation alongside the lesson text.
   **PII check (not only quality):** before appending, confirm the lesson text contains no person-name — refer to people by role. A name written here propagates per the egress note in the IMPORTANT block above (wrap-up push + boot read), so this is a write-time PII gate, per DSM_0.2.C §5.8.
7. **Prune if needed:** If `.claude/reasoning-lessons.md` exceeds 50 lines of entries (excluding headers and comments), suggest entries to promote to MEMORY.md or CLAUDE.md, and entries to remove (obvious, outdated, or already codified).

   **Provenance header update (per BL-510; canonical rule in DSM_0.2.A §8.1):** After the appends above (Step 6) and any prune (this step) have landed, update the live file's `**Last appended:**` line, and `**Last pruned:**` when entries were removed, with this run's identifier, date, counts and a one-line note. Four properties, all four required. **Chain, never replace:** move the superseded value behind `Prior:` (the form the file already uses) rather than overwriting it. **No-op when nothing changed:** if nothing was appended and nothing pruned, make no header change. **Same run, not the next one:** do it here, not in a later step or a later skill, because deferring is the structure that produced the gap. **Create when absent (property 4, BL-526):** where the `**Last appended:**` line does not exist, create it and state within the line that this run created it and that earlier appends predate the header, so its date is not misread as the file's first write. Absence is not a reason to skip; property 2 still governs, so a run that appended and pruned nothing makes no header change even when the line is missing. The failure this closes is specific to STAA and is the reason BL-510 exists: Step 9 below writes `.claude/last-staa.txt` unconditionally, so a run that skips the header produces two artifacts making opposite claims, the marker asserting a run happened and the file it operated on still naming the previous run. The S244-STAA run pruned 28 entries into exactly that state and it went undetected for a full day.
7b. **Prune the ecosystem aggregation file if over bound (per BACKLOG-567):** **Skip this step silently if `dsm-docs/reasoning-lessons-ecosystem.md` does not exist** — it is a DSM-Central-only aggregation file; spoke projects have no such file, so on a spoke STAA run this step is a no-op. Otherwise, check the tracked aggregation file `dsm-docs/reasoning-lessons-ecosystem.md` against its ~120 KB / ~30K-token soft **review-cost** bound (canonical rule in DSM_0.2.A §8.3, "Aggregation file review-cost bound and prune"). This is a **separate file** from the local `.claude/reasoning-lessons.md` pruned in Step 7: the local file is the boot-primed mirror (§8.1 byte bound), the aggregation file is the non-boot-read cross-project record (§8.3 review-cost bound). Cadence: check at every STAA run, prune only when over the bound (not every run).

   When over bound, apply the three ordered actions from §8.3, each leaving a tombstone (no silent drop):
   1. **Archive-on-codification (primary):** replace a lesson escalated into a DSM protocol / BL / MEMORY with `<!-- Archived SNNN-STAA: {summary} codified in {destination} -->`.
   2. **Consolidate cross-spoke duplicates** into one entry, all attributions preserved.
   3. **Tombstone dead-project lessons** (`project`-scope, originating project retired) with `<!-- Archived SNNN: {summary}, project retired -->`.

   Also apply the ~600-char **body-only** ceiling (attribution prefix excluded): compress or split an over-length body, never drop it.

   **STAA does not commit this edit.** Consistent with STAA's no-commit design (scope note below), the prune edits the tracked file but leaves it **uncommitted**; the next `/dsm-wrap-up` commits it with the session's other changes. Record the prune (file, before/after size, actions applied) in `.claude/last-staa.txt` (Step 9). No compact-mirror regeneration applies — the aggregation file has no compact mirror (it is not boot-read).

8. **Regenerate compact reasoning-lessons mirror (per BL-433, transform per BL-447):** After Step 6's appends and any Step 7 prunes have landed in `.claude/reasoning-lessons.md`, regenerate `.claude/reasoning-lessons-compact.md`. **Run the canonical regeneration transform defined in DSM_0.2.A §8.1 ("Canonical regeneration transform")**, then run the two post-generation sanity checks specified there. Do NOT re-inline a transform here: the canonical awk in §8.1 is the single source of truth (re-inlining a divergent copy was the BL-447 drift bug that silently emptied the mirror on flat-structured spoke files). The §8.1 transform is shape-tolerant (works whether or not the live file has a `## Categories` heading), strips the `[auto]`/`[STAA]` provenance prefix, preserves `### Category` headings, and fails loud (entry-count + size-floor warnings) instead of producing a silent header-only mirror.

   **Why:** /dsm-go Step 1.5 reads the compact mirror as the boot-time canonical context. /dsm-staa runs OUTSIDE the wrap-up flow, so its appends to the live file create staleness in the mirror that persists until the next /dsm-wrap-up (potentially 24+ hours later). Regenerating here closes the gap so the next session boot reads a fresh mirror.

   **Cross-reference:** /dsm-wrap-up Step 0 owns the same rule. If the rule changes (new entry-prefix tag, category-heading shape, freshness-header drift), both /dsm-wrap-up Step 0 and /dsm-staa Step 8 must update together. See **DSM_0.2.A Reasoning Lessons Protocol** for the canonical specification. The auto-generated comment in the mirror header references both regenerators ("/dsm-wrap-up Step 0 or /dsm-staa Step 8") so provenance is honest.

   **Origin:** BL-433 (S207, derived from S7 STAA continuation 2026-05-02). After /dsm-staa appended 6 [STAA] entries and pruned 2 [auto] entries at ~22:17, the compact mirror remained at its 22:04 state from S7 wrap-up, 13 min stale, missing 6 lessons and including 2 pruned ones. The agent regenerated inline manually; this step makes the regeneration a normative part of /dsm-staa.
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
- This agent does NOT modify any project files except `.claude/reasoning-lessons.md`, its compact mirror `.claude/reasoning-lessons-compact.md` (Step 8), `.claude/last-staa.txt` (Step 9), and — only when over bound (Step 7b, BACKLOG-567) — the tracked aggregation file `dsm-docs/reasoning-lessons-ecosystem.md`. The first three are gitignored local-only artifacts. The aggregation file is the one tracked file STAA may edit; STAA still **commits nothing** (its no-commit property holds), so the prune is left uncommitted for the next `/dsm-wrap-up` to commit with the session's other changes.
- The analysis session is lightweight; no git commits, no wrap-up needed
- **STAA files no BL and makes no git commit (write scope).** If STAA finds a BL-worthy issue, it records the finding in its conversation output (and may note it in `.claude/reasoning-lessons.md`, a gitignored artifact) for a later `/dsm-go` session to file through the fork-local BL workflow (DSM_0.2 §21.5). Creating a branch or committing a BL from a STAA session — a concurrent-session incident — is the prohibited action this codifies against, and is exactly what makes the missing Step 0 detection dangerous: STAA's only writes are the three gitignored local artifacts named above, never a tracked file and never a commit
- If the transcript is very long (500+ lines), warn about context budget and offer to analyze in sections
- Cross-reference findings with existing MEMORY.md entries to avoid redundancy
- Be specific in lessons; "be more careful" is not actionable, "check file existence before editing" is
