---
date: 2026-04-15
session: 1
project: take-ai-bite
type: first-clone-test
reporter: Claude (Opus 4.6) + adiaz (repo creator)
---

# First-Clone Test Feedback — take-ai-bite

Context: first-ever clone of the public `take-ai-bite` repo by its creator, running `/dsm-go` as the very first session. All friction points captured live as they surface.

## Findings

### 1. Scaffold ships incomplete (BLOCKER for /dsm-go Step 0.5)

On fresh clone, only 2 of 9 canonical `dsm-docs/` subdirectories exist: `blog/`, `guides/`. Missing: `checkpoints/`, `decisions/`, `feedback-to-dsm/`, `handoffs/`, `plans/`, `research/`, `inbox/`.

`/dsm-go` Step 0.5 detects this (2 < 5 threshold) and warns, then defers the fix to Step 1.8's unconditional `/dsm-align` invocation. But see finding #2.

**Recommendation:** Either ship the full 9-folder scaffold in the public repo with `.gitkeep` files, or ship `/dsm-align` as a reachable skill (see #2) so the deferred fix actually works.

### 2. `/dsm-*` commands ship as markdown prompts, not as registered Claude Code skills

`scripts/commands/` ships 18 `dsm-*.md` files (`dsm-align`, `dsm-go`, `dsm-wrap-up`, etc.), but they are **prompt-template markdown**, not registered Claude Code skills. A cloner cannot type `/dsm-go` and have it auto-invoke — they must ask the agent to "run `dsm-go.md` as a skill," which is what happened in this session. The agent then reads the file and executes its steps manually.

**Empirical confirmation during this session (2026-04-15):**

After `/dsm-go` completed inline, the user typed `/dsm-wrap-up` and Claude Code returned `Unknown command: /dsm-wrap-up`. This proves the gap directly — even after a successful `/dsm-go` run that scaffolded the project, no `/dsm-*` slash commands become available. The cloner must keep using the "run X.md as skill" workaround for every subsequent DSM command (`dsm-light-go`, `dsm-checkpoint`, `dsm-wrap-up`, etc.).

This is significantly worse friction than just session 1: it persists for every session forever unless the cloner manually deploys the commands. A typical DSM session uses 2-4 different `/dsm-*` commands, each of which fails at the slash-command layer.

**Impact:** Every internal reference to `/dsm-align`, `/dsm-wrap-up`, etc. inside these files assumes the slash command works. Step 1.8's "unconditional" rule requires the agent to notice the reference and manually read-and-execute `dsm-align.md` in turn — chaining prompt-templates across tool calls. This works but depends on the agent noticing, and the protocol documents are written as if the slash commands are first-class.

The full `/dsm-align` file even has a Step 11 ("Check command file drift") that diffs `scripts/commands/*.md` against `~/.claude/commands/{filename}` and `.claude/commands/{filename}`. That diff implies a deployment mechanism exists somewhere — but no install script, no instructions, and no automatic deployment ship in the public clone. The drift-check exists for a deployment that the cloner has no way to perform.

**Update (2026-04-15, after grep): the install script ALREADY ships.**

`scripts/sync-commands.sh --deploy` exists and does exactly the right thing:
- Source: `scripts/commands/*.md` (all 18 DSM commands)
- User-level target: `~/.claude/commands/` (most commands like `dsm-go`, `dsm-wrap-up`, `dsm-align`, etc.)
- Project-level target: `.claude/commands/` (5 specific: `dsm-backlog`, `dsm-backlog-done`, `dsm-checkpoint`, `dsm-review-feedback`, `dsm-version-update`)

After running `bash scripts/sync-commands.sh --deploy`, the slash commands `/dsm-go`, `/dsm-wrap-up`, etc. become real Claude Code slash commands.

**So the actual finding is: the mechanism is built, but the README never tells the cloner to run it.** README.md and TAKE_A_BITE.md (verified in this session) contain no Quick Start section that mentions the deploy script. A first-time cloner has zero way to discover it without grepping `scripts/`.

There is also a secondary failure mode: line 32-35 of `sync-commands.sh` errors out if `~/.claude/commands/` doesn't exist:
```
if [ ! -d "$USER_TARGET" ]; then
    echo "ERROR: User target directory not found: $USER_TARGET"
    exit 1
fi
```
For a Claude Code installation that hasn't created `~/.claude/commands/` yet, the script will fail-closed. The script should `mkdir -p "$USER_TARGET"` (it already does this for `$PROJECT_TARGET` on line 37) rather than erroring.

**Recommendations (revised, prioritized):**
- **(a) Add a "Quick start" section to README.md** — single most valuable change. Three lines:
  ```
  ## Quick start
  1. Clone this repo
  2. Run: `bash scripts/sync-commands.sh --deploy`
  3. In Claude Code, type: `/dsm-go`
  ```
- **(b) Fix the fail-closed `mkdir` gap** in `sync-commands.sh`: replace the `exit 1` block with `mkdir -p "$USER_TARGET"`. Trivial change, removes one of the two install failure modes.
- **(c) Document the deploy step inside `dsm-go.md` Step 0.5** ("Scaffold Completeness Check") so even if the cloner skips the README and starts with `run dsm-go.md as skill`, the agent can offer to run the deploy script as part of scaffolding.
- **(d) Optional: name the script more discoverably.** `sync-commands.sh` reads as a maintenance utility ("sync" = drift-check ↔ deploy). Renaming or aliasing to `install-dsm-commands.sh` would make grep-discovery easier for first-time cloners.

### 3. No `.claude/` directory on clone

Missing entirely: `.claude/CLAUDE.md`, `.claude/reasoning-lessons.md`, `.claude/transcripts/`, `.claude/last-align.txt`, `.claude/dsm-ecosystem.md`, `.claude/session-baseline.txt`, `.claude/session-transcript.md`, `.claude/last-wrap-up.txt`.

`/dsm-go` assumes many of these exist (Steps 1, 1.5, 2, 2a.5, 5, 5.5, 5.9). Step 1 has a graceful fallback for missing MEMORY.md. Step 1.5 is silent-skip on missing reasoning-lessons. But Step 2a.5 (ecosystem registry) says the file is "created by `/dsm-align` in Step 1.8" — another dependency on the unshipped command.

**Recommendation:** Ship a skeleton `.claude/CLAUDE.md` template in the public repo (project-type-agnostic, with the 4 required sections from Module A §23 as headers), so first-run has something to read.

### 4. Git installed but invisible to bash on Windows

Windows 11 + Git for Windows 2.51 installed. `C:\Program Files\Git\cmd` is on Windows `PATH`. But the bash shell that Claude Code spawns (`/usr/bin/bash`) does not inherit it — `git` resolves as "command not found" until `export PATH="/c/Program Files/Git/cmd:/c/Program Files/Git/usr/bin:/c/Program Files/Git/bin:$PATH"` is prepended to every call.

**Silent failure mode:** `/dsm-go`'s Git Awareness pre-step runs `git rev-parse --is-inside-work-tree 2>/dev/null` and on failure (exit 127, command not found) caches `GIT_AVAILABLE=false` — **wrongly**, since the repo IS a git repo. Every downstream step then skips git operations (branch creation, baseline snapshots, commit history) despite git being fully usable.

**Recommendation:** Either (a) the Git Awareness pre-step should distinguish "not a git repo" (git exists, returns non-zero) from "git not found" (exit 127), and attempt PATH recovery in the latter case; or (b) ship a `.claude/settings.json` hook / env var for Windows cloners that patches PATH; or (c) document in README that Windows users must run Claude Code from Git Bash or a shell with git on PATH.

### 5. Pre-existing inbox entries confuse first-time cloners

`_inbox/` ships with 2 notification entries left over from DSM Central's
outbound communication. `/dsm-go` Step 2b correctly detects them and prompts
processing, which is the right behavior — but the entries themselves are
artifacts of Central's history and have no actionable meaning in a fresh clone.

**Entry 1: `2026-03-17_dsm-central_readme-updated-v1370.md`**

```
### [2026-03-17] DSM Central README updated (v1.3.70)

**Type:** Notification
**Priority:** Low
**Source:** DSM Central (Session 134, deferred from S133)

DSM Central README.md was updated with v1.3.70 release:
- Version bumped to v1.3.70
- Added roadmap system reference (plan/roadmap.md)
- Updated document descriptions

Check if Take AI Bite project description needs updating.
```

The "Check if Take AI Bite project description needs updating" line is the
only actionable guidance, but it is directed at a maintainer who can compare
against DSM Central's current README — a fresh cloner has no Central to
diff against.

**Entry 2: `2026-04-01_dsm-central_blog-idea-stubborn-agent.md`**

A 50-line blog-post brief about "Collaborating with a stubborn agent."
References BL-291 (PreToolUse hook implementation), BL-292 (universal typed
transcript delimiters), reasoning lessons S102/S140, and Session 161 transcript.
None of these source artifacts exist in the public clone — the cloner cannot
follow up on any of the references.

**Action taken in this session:** Both entries `git mv`'d to `_inbox/done/`
as Step 2b processing. Reported as informational-only with no follow-up.

**Why this is a real problem, not just clutter:**

`/dsm-go` Step 2b's processing rule is "evaluate impact, propose action
(implement, defer, or reject per DSM_3 Section 6.4.3), and ask the user how
to proceed." A diligent agent will read both entries, attempt to evaluate
impact, and then have to ask the user about Central-internal work that the
user (a fresh cloner) has zero context for. This is a confusing first
interaction with the methodology — the user thinks they have homework
they don't actually have.

**Recommendations (any one of these closes the issue):**

- (a) **Clear `_inbox/` before publishing** the public clone. Cleanest, but
  loses the example value.
- (b) **Pre-stage the entries in `_inbox/done/`** with a header note
  ("These are example notifications retained from DSM Central history.
  Cloners can ignore them. They live in `done/` so they don't trigger
  `/dsm-go` Step 2b.")
- (c) **Convert the entries into clearly-labeled examples** by renaming
  to `EXAMPLE_*` and adding a `**Status:** Example, no action required`
  field that `/dsm-go` Step 2b can recognize and skip.
- (d) **Add a `_inbox/README.md`** (now created in this session) that
  explicitly tells a fresh cloner: "If you cloned this repo and see entries
  here that reference Central sessions, BLs, or sync history you don't
  recognize, they are pre-shipped artifacts — move them to `done/` and
  proceed."

(d) is the lightest-touch option and was applied inline in this session.
(a) or (b) is the cleanest for v2 of the public clone.

### 6. Session number provenance is ambiguous after sync merges

`/dsm-go` Step 0a computes `N = max(ARCHIVE_COUNT, MEMORY_SESSION) + 1`. On this clone: archive=0, MEMORY=0 (no file), so N=1. But `git log` shows merge commits referencing sessions 189, 190 (synced from DSM Central). The first local session is therefore "session 1" even though commit history implies a much later lineage.

**Recommendation:** Either document that session numbering is *local* (resets on clone of a sync-recipient repo), or have `/dsm-align` scan commit messages for the highest referenced `session-N` as a third input to the max().

### 7. Missing `_inbox/README.md`

Step 2b says: "exclude `README.md` and `done/` from results". On fresh clone, `_inbox/` has no `README.md` to exclude. Minor, but the protocol assumes it exists.

### 8. `/dsm-go` Step 0.5 and `/dsm-align` Step 3 disagree on the canonical folder list

**Discovered by Alberto during the live session**, after Claude (me) followed `dsm-go.md` Step 0.5 literally and created an erroneous `dsm-docs/inbox/` directory.

`dsm-go.md` Step 0.5 says:

> Count how many of the 9 canonical `dsm-docs/` subdirectories exist:
> `blog`, `checkpoints`, `decisions`, `feedback-to-dsm`, `guides`, `handoffs`, `plans`, `research`, `inbox`

`dsm-align.md` Step 3 lists **8 folders** in its canonical table, no `inbox`:

| Folder |
|--------|
| `dsm-docs/blog/` |
| `dsm-docs/checkpoints/` |
| `dsm-docs/decisions/` |
| `dsm-docs/feedback-to-dsm/` |
| `dsm-docs/guides/` |
| `dsm-docs/handoffs/` |
| `dsm-docs/plans/` |
| `dsm-docs/research/` |

And `dsm-align.md` Step 2 explicitly states:

> The canonical location is always `_inbox/` at project root; no other path should be used.

So the inbox is a **repo-root** folder (`_inbox/`), not a `dsm-docs/` subfolder. `dsm-go.md` Step 0.5 has the wrong canonical list — it includes `inbox` as the 9th `dsm-docs/` folder by mistake. The "5 of 9" threshold in Step 0.5 is also wrong as a consequence (should be "5 of 8").

**Failure mode:** A diligent agent (this session) reads Step 0.5, sees `inbox` in the canonical list, doesn't cross-check against `dsm-align.md`, and creates `dsm-docs/inbox/` during scaffolding. The folder then exists alongside the real `_inbox/` at repo root, creating two inboxes. Neither `dsm-go` Step 2b nor `dsm-align` Step 2 looks at `dsm-docs/inbox/`, so any entries placed there would be silently ignored — a data-loss footgun.

**Recommendations:**
- (a) **Fix `dsm-go.md` Step 0.5**: change "9 canonical `dsm-docs/` subdirectories" to "8 canonical `dsm-docs/` subdirectories", remove `inbox` from the list, change "5 of 9" to "5 of 8", and split the `_inbox/` check from the `dsm-docs/` count (it's already a separate check in the same step but the framing conflates them).
- (b) Add an `/dsm-align` validation: warn if `dsm-docs/inbox/` exists ("Misplaced inbox folder; canonical location is `_inbox/` at repo root. Move entries to `_inbox/` and remove this folder.").
- (c) Add a one-line cross-check rule: any folder list that appears in more than one DSM skill file should be sourced from a single canonical reference (e.g., DSM_0.1's "Canonical Spoke Folder Names" section). Currently `dsm-go` Step 0.5 and `dsm-align` Step 3 each maintain their own list and have drifted.

### 9. No `.gitignore` ships in the public clone

The public repo has no `.gitignore` file. DSM convention treats several `.claude/` subpaths as local-only (session-transcript, session-baseline, transcripts/, last-align*, last-wrap-up, hooks/, settings.local.json — see `dsm-align.md` Step 12a's reference to "the existing `.claude/` rule" and `dsm-go.md` Step 5's note about Claude Code's `.git/info/exclude` rule). Without a shipped `.gitignore`:

- A first-time cloner running `/dsm-go` then `/dsm-wrap-up` will git-add session artifacts (`.claude/session-transcript.md` with the entire reasoning log of the session) into the commit.
- The first wrap-up commit will leak the session transcript content publicly.
- Subsequent sessions accumulate transcripts in `.claude/transcripts/`, all of which would also be committed.

This is a privacy / hygiene risk for cloners who fork the repo and push back upstream (or to their own remote).

**Recommendation:** Ship a `.gitignore` at repo root that excludes the session-local DSM artifacts. A minimal version (created in this session) is:

```
.claude/session-transcript.md
.claude/session-baseline.txt
.claude/transcripts/
.claude/last-align.txt
.claude/last-align-report.md
.claude/last-wrap-up.txt
.claude/hooks/
.claude/settings.local.json
```

`.claude/CLAUDE.md`, `.claude/dsm-ecosystem.md`, `.claude/reasoning-lessons.md`, `.claude/contributor-profile.md`, `.claude/commands/`, and `.claude/settings.json` should remain committed (project config that benefits from version control).

### 10. `/dsm-wrap-up` Step 10 assumes `gh` CLI is installed

`dsm-wrap-up.md` Step 10 ("Merge session branch to main via PR") invokes `gh pr create` and `gh pr merge --merge --delete-branch`. Step 10e has a fallback: "If `gh` is not available or the PR fails, warn: 'Branch protection is active. Cannot merge to main without a PR. The session branch `{session-branch}` has been pushed to remote. Merge manually via GitHub.' and stop."

The fallback works for **merge**, but Step 10b ("Create PR") has no fallback — if `gh` isn't installed, the cloner can't create a PR either via the skill. They have to use the GitHub web UI URL that `git push -u origin {branch}` prints to stderr.

**Empirical confirmation during this session:** `gh` is not installed on this Windows machine. The push succeeded and printed the standard GitHub URL `https://github.com/{user}/{repo}/pull/new/{branch}`. Falling back to the web UI worked, but the wrap-up skill silently exits at this step rather than capturing the URL or guiding the user.

This is the same pattern as finding #4 (Windows bash doesn't inherit Git PATH): skill files assume CLI tools resolve, but Windows installations frequently don't include them.

**Recommendations:**
- (a) **Capture the PR URL from `git push` output** — `git push -u origin {branch}` prints `Create a pull request for '{branch}' on GitHub by visiting: https://...`. The wrap-up could parse this and surface it explicitly: "PR URL: https://... — open in browser to create the PR."
- (b) **Make `gh` optional in Step 10b**, with a graceful fallback: "gh not installed. Branch pushed. Open this URL in a browser to create the PR: {url}"
- (c) **Document `gh` as a recommended (not required) dependency** in README. The DSM workflow degrades gracefully without it but with extra manual steps.

### 11. `/dsm-go` Step 1.8 "unconditional, no exceptions" does not fit standalone projects

**Surfaced in session 2 (2026-04-15) when `/dsm-go` re-ran on the clone.**

`/dsm-go` Step 1.8 is emphatic:

> **Always run /dsm-align (unconditional, no exceptions):** Invoke `/dsm-align` immediately. Do not check `.claude/last-align.txt`. Do not gate on version mismatch. Do not gate on marker presence. Do not ask the user. Do not present a y/n confirmation gate. Do not defer.

The rationale (BL-319 follow-up, S180 §22 hardening) is sound for hub-and-spoke ecosystems where `/dsm-align` is cheap and fixes drift silently. But `/dsm-align` itself is built around a spoke -> DSM Central topology:

- Step 2 (ecosystem registry lookup) expects `dsm-central` to point to an external repo with `_inbox/`, `CHANGELOG.md`, etc.
- Step 7 (version check) reads `{dsm-central}/CHANGELOG.md`.
- Step 11 (command drift check) assumes drift between this repo and a remote Central.
- Step 12 (hook install) pulls from `{dsm-central}/.claude/hooks/`.

For `take-ai-bite` — a **standalone** repo whose "central" *is* itself (`dsm-central = .` in the ecosystem registry) — none of these cross-repo operations are meaningful, and several would actively regress local state (e.g., the hand-curated `.claude/CLAUDE.md` alignment section explicitly marked `"inline scaffold, not via full /dsm-align"`).

In this session I skipped Step 1.8 with a logged deviation. The fact that a **reasoned deviation** was required on the second `/dsm-go` run of a brand-new clone is the finding: an "unconditional, no exceptions" rule that requires judgment-call exceptions on common project types (standalone samples, public demos, first-clone rigs) is not actually unconditional.

**Recommendations:**
- (a) **Add a `standalone` participation-pattern short-circuit to Step 1.8.** If `.claude/CLAUDE.md` declares `Participation pattern: Self-contained` (or the ecosystem registry has `dsm-central = .`), Step 1.8 should downgrade to "verify alignment marker exists; skip cross-repo sync steps."
- (b) **Split `/dsm-align` into sub-steps with opt-out flags** for standalone projects: (i) local scaffold check (always runs), (ii) CLAUDE.md alignment template (always runs if drift detected), (iii) ecosystem sync (runs only if external `dsm-central` exists).
- (c) **Document "standalone" as a first-class participation pattern in DSM_0.2** alongside hub/spoke/external-contribution. Module A §17 already mentions participation patterns; adding `standalone` with an explicit "Step 1.8 short-circuit" rule makes the behavior discoverable rather than a judgment call.

### 12. CLAUDE.md default `## 4. Branching` template bakes in merge-to-main assumption

**Surfaced in session 2 (2026-04-15) when the user declared the no-merge-to-main rule.**

The session-1 scaffold wrote this line in `.claude/CLAUDE.md`:

```
## 4. Branching

Standard DSM three-level branching applies (`main` -> `session-N/YYYY-MM-DD` -> `bl-*` / `sprint-*`).
```

That one-liner is defensible as a default — §20.2 and §20.3 of DSM_0.2 do describe a merge-to-main workflow. But "standard three-level branching applies" tacitly endorses **merge behavior** (§20.2: "Merge to Level 1: At session wrap-up, only if all Level 3 branches have been formally merged back"), not just the naming convention.

The user's actual rule for `take-ai-bite` is: **no branch is ever merged to `main`**. Every branch is committed, pushed, and opened as a review PR; the PR diff is the review artifact for DSM Central maintainers; `main` stays pinned to the upstream clone baseline. This required a project-specific override of §20.2/§20.3 via §17 precedence (done this session, commit TBD).

The gap is that the default CLAUDE.md scaffolding has no option for "review-only" or "no-merge" projects. A first-time cloner who wanted this workflow would have to:
1. Discover that §20.2/§20.3 force merge behavior.
2. Know that §17 protocol precedence lets them override.
3. Write the override themselves.

None of that is signposted; `/dsm-align`'s CLAUDE.md template system (§17.1) produces the same merge-endorsing line for every project type.

**Recommendations:**
- (a) **Add a fourth branching mode to the CLAUDE.md template system** (§17.1 Base template), alongside notebook / app / hybrid: **review-only** projects get a Section 4 body that declares "never merges to main; branches delivered as PRs."
- (b) **Tag `take-ai-bite` specifically as a review-only project** in whatever registry `/dsm-align` consults — so re-runs of `/dsm-align` don't overwrite the hand-curated Section 4 back to the merge-endorsing default.
- (c) **Add a DSM_0.2 §20 subsection** documenting "review-only branching" as a first-class pattern, with explicit rules: (i) branches are never merged locally, (ii) PRs are the review artifact, (iii) session wrap-up pushes and opens/updates PRs instead of running `git merge`, (iv) `main` tracks an external baseline.

### 13. VS Code stale buffer overwrites fresh `/dsm-go` Step 6 transcript reset

**Surfaced in session 2 (2026-04-15) when the transcript was clobbered mid-session.**

`/dsm-go` Step 6 overwrites `.claude/session-transcript.md` on disk with a fresh `Session N` header:

```bash
cat > .claude/session-transcript.md << EOF
# Session N Transcript
**Started:** $(date -Iseconds)
...
EOF
```

If VS Code has the file **open with a buffer from the previous session loaded** when Step 6 runs, the on-disk content is replaced correctly — but any subsequent IDE save (autosave, manual save, or a buffer flush triggered by focus change) writes the stale Session N-1 buffer back over the fresh header. Silent data loss; no warning from Claude Code, no warning from VS Code.

**What happened this session:**

1. 04:53: `/dsm-go` Step 6 ran, wrote Session 2 header to disk. File on disk: Session 2.
2. 04:53-05:03: Agent appended Session 2 Start User / Thinking / Output entries via Edit tool. File on disk: Session 2 + ~60 lines of S2 entries.
3. ~05:03: VS Code (with the S1 buffer still loaded in the editor pane) saved the buffer back, overwriting the file on disk.
4. 05:04: Agent tried to Read / Edit the transcript to add the Gate 2 output summary, found only S1 content (38 lines).
5. Recovery: rebuilt S2 content with a `[RETROACTIVE]` wrapper per DSM_0.2 §7.

The S1 content was safely archived to `.claude/transcripts/2026-04-15T04:26-ST.md` before Step 6 overwrote the file, so no data was permanently lost — but the S2 reasoning appended between 04:53 and 05:03 WAS lost and had to be reconstructed from memory.

**Why this matters:**

`/dsm-go` Step 6 is documented in DSM_0.2 §7 as the **canonical activation point** for the Session Transcript Protocol. If the IDE can silently undo Step 6, the protocol's foundational invariant ("the transcript reflects the current session's reasoning") is broken without any signal to the agent. The `validate-transcript-edit.sh` PreToolUse hook enforces shape (delimiters, anchors) but does not detect whole-file reversion.

**Recommendations:**
- (a) **Add a post-Step-6 checksum / header verification.** After writing the fresh header, compute its hash. Before every transcript append, re-read the first 5 lines and verify the header matches the Step-6 hash. If it doesn't, the agent knows the IDE clobbered the file and can recover (re-run Step 6, inject a `[RETROACTIVE]` block) rather than silently overwriting S1 content with S2 edits.
- (b) **Add a guard to the PreToolUse hook** (`validate-transcript-edit.sh`) that rejects Edit calls whose `old_string` anchor matches an older session's header (`# Session {N-1} Transcript`) when the current session is `N`. Forces explicit recovery.
- (c) **Document the IDE buffer risk** in DSM_0.2 §7 and in `/dsm-go` Step 6. Recommend that `/dsm-go` instruct the user, as part of Step 6, to close and reopen the transcript file in their editor so the editor re-reads from disk. A one-line note at the end of Step 6: "If you have `.claude/session-transcript.md` open in an editor, close and reopen it now."
- (d) **Optional: have `/dsm-go` Step 6 write to a new filename** (`session-transcript-{N}.md`) and symlink / rename rather than overwriting in place, so stale IDE buffers cannot stomp fresh content.

### 14. Windows CLI PATH-visibility is a cross-cutting pattern (#4 + #10 are instances)

**Surfaced in session 2 (2026-04-15) when the agent misdiagnosed `gh` as "not installed."**

Findings #4 (git) and #10 (gh) were written as independent issues in S1. S2 produced direct evidence they are instances of a single class:

- S2 agent ran `which gh` with only the Git PATH prepended, got "not in PATH", and reported "gh not installed" as fact.
- User corrected: "gh is available now."
- Re-probe with `/c/Program Files/GitHub CLI` also prepended: `gh` 2.89.0, authenticated. It was installed the whole time; it was PATH-invisible.

**The meta-observation is the finding.** A diligent agent (me) with S1 finding #4 already in hand still concluded "not installed" rather than "PATH-hidden" on the first probe. Any ordinary cloner will reproduce this misdiagnosis. The prior findings did not prevent it.

**Generalization.** Any Windows GUI-installer CLI tool installs to `C:\Program Files\{Tool}\...` and is reachable from `cmd.exe` / PowerShell but NOT from the bash shell Claude Code spawns. Affected tools observed or likely: `git`, `gh`, and by extension `python`, `node`, `docker`, `kubectl`, anything installed via a Windows installer that writes to `HKLM\...\PATH` instead of the user environment block bash inherits.

**This reframes #10.** #10's premise ("gh not installed") was partially wrong — on this machine, gh WAS installed. The recommendation (graceful fallback to the GitHub web URL printed by `git push`) is still correct as a defense against *genuine* absence and as a no-dependency path, but the *first-line diagnosis* in `/dsm-wrap-up` Step 10 should be "is it installed but PATH-hidden?" before "is it absent?".

**Recommendations (tiered):**

- (a) **Ship a `.claude/bash-path-prepend.sh` helper** that exports the common Windows tool paths (`/c/Program Files/Git/cmd`, `/c/Program Files/Git/usr/bin`, `/c/Program Files/Git/bin`, `/c/Program Files/GitHub CLI`). Cloners source it once; every Bash tool call thereafter sees the installed tools. Cheaper than editing every skill file.
- (b) **`/dsm-go` session-start PATH probe.** After the Git Awareness pre-step, probe for the CLIs DSM skills actually use (`git`, `gh`; extensible). For each, distinguish "absent" from "PATH-hidden" by checking `C:\Program Files\{Tool}\...` when `which` fails. Report the diagnosis and recommend prepend if any are PATH-hidden.
- (c) **Re-frame #4 and #10 recommendations** (in this doc) to put "check PATH visibility first" before "assume absence". No rewrite of those findings' bodies — a one-line cross-reference to #14 is enough.
- (d) **Agent-level lesson** in `.claude/reasoning-lessons.md`: when `which X` fails on Windows bash, also check `C:\Program Files\X\...` before concluding absence. Tag `[windows-path]`. Prevents DSM agents from reproducing the S2 misdiagnosis.

## Friction-ordered summary

| # | Severity | Category | Who feels it |
|---|---|---|---|
| 2 | Blocker | Missing shipped skill | Every cloner, session 1 |
| 1 | High | Scaffold | Every cloner, session 1 |
| 4 | High | Platform / Windows | Windows cloners |
| 3 | Medium | Scaffold | Every cloner, session 1 |
| 5 | Medium | Content hygiene | Every cloner, session 1 |
| 6 | Low | Protocol clarity | Sync-recipient clones |
| 7 | Low | Protocol nitpick | Every cloner, session 1 |
| 8 | High | Internal inconsistency / data-loss risk | Diligent agents following the protocol |
| 9 | High | Privacy / hygiene | Every cloner who pushes back |
| 10 | Medium | Platform / Windows | Windows cloners without gh CLI |
| 11 | High | Protocol scope / judgment-call trap | Standalone repos, review-only projects |
| 12 | Medium | Template gap | Review-only projects |
| 13 | High | Session-artifact silent data loss | Every cloner using VS Code / any editor |
| 14 | High | Cross-cut / Windows | Windows cloners and agents — misdiagnosis risk |

## Status

Live document — will be extended as the session continues through steps 2-10 and any wrap-up.

**Session 2 appendix (2026-04-15):** Findings 11-14 added. All four surfaced during the second `/dsm-go` run on the clone, confirming that even after session-1 scaffolding landed, the first-clone experience continues to generate friction data on re-runs. Finding #14 specifically came from the agent reproducing the PATH-visibility misdiagnosis from S1 finding #4 despite having that finding in context — evidence that the pattern is not eliminated by prior documentation alone.
