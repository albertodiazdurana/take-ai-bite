# Feature Trail Index

Reconstruction map from `FEATURES.md` entries to their design rationale,
origin, and supporting artifacts. Maintained forward as new features ship;
past entries populated lazily when blog posts cover them.

**Purpose:** Give blog writers (human or agent) a one-stop index of every
source needed to tell the story of a feature: why it exists, what triggered
it, what meta-pattern it embodies.

**Maintenance:** Each new F-entry in `FEATURES.md` MUST append a row here
(see CLAUDE.md FEATURES.md check protocol).

---

## How to use this index for a blog post

For each F-entry covered in the post:

1. Read this row to get BL number, inbox source, and meta-pattern reference
2. Read the BL file (`dsm-docs/plans/done/BACKLOG-NNN_*.md`) for Problem Statement, Proposed Solution, and Test Plan
3. If "Inbox source" is non-empty, read the inbox entry in `_inbox/done/` for the real-world trigger and (if linked) the full feedback file in `dsm-docs/feedback-to-dsm/`
4. If "Meta-pattern" is non-empty, read the corresponding entry in `.claude/reasoning-lessons.md` for the framing thread
5. Cross-reference `CHANGELOG.md` for the version section, which often groups related BLs under a common theme

The combination gives you: the *gap* (Problem), the *trigger* (Inbox or session), the *fix* (Solution), the *narrative thread* (Meta-pattern), and the *shipping context* (CHANGELOG version section).

---

## Index

### v1.6.0 (2026-04-19)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-111 | 2026-04-19 | PR-merge-to-main permission parity | BL-387 | S194 inbox triage of `_inbox/dsm-jupyter-book.md` S4 feedback, methodology Observation 1. Permission system gated on COMMAND not OUTCOME: `git push origin main` required confirmation but `gh pr merge --merge` to main-base PR did not, despite identical publication outcome. | `_inbox/done/dsm-jupyter-book.md` (S4 feedback methodology Obs 1) | Earn Your Assertions applied to destructive-merge authorization. Couples with BL-386 (target verify) to form target-verify → action-authorize chain; individual BLs are independent but stronger together. |
| F-110 | 2026-04-19 | Default-branch verification at session start and PR create | BL-386 | S194 inbox triage of `_inbox/dsm-jupyter-book.md` S4 feedback (~45-min debug loop on HTTP 404 cascade). Two independent gaps allowed failure to compound: no session-start cross-check between local/remote default, no post-create base verification on `gh pr create`. | `_inbox/done/dsm-jupyter-book.md` (S4 feedback) | Earn Your Assertions extended to command defaults: "resolve the relevant default before running a destructive command that depends on it." Preventive (Check A) + detective (Check B) coverage for the same failure class. |
| F-109 | 2026-04-19 | Gate 2 counter-evidence surfacing | BL-385 | S193 inbox triage thread T12 (`_inbox/done/heating-systems-conversational-ai.md` methodology lesson 3). S5 incident: two ranking errors needed user pushback to surface counter-evidence visible at brief time. Confidence-shaped briefs hide weakness signals until challenged. | `_inbox/done/heating-systems-conversational-ai.md` (S5 methodology lesson 3) | User-as-enforcement-layer (S171 ↔ S190 STAA) applied: when agent self-detection of weakness is unreliable, build surfacing into the protocol rather than leave it to user vigilance. S194 voluntary application (4 briefs) preceded codification, making the rule zero-churn. |
| F-108 | 2026-04-19 | `/dsm-backlog` sprint-plan template injection | BL-380 | S193 inbox triage thread T3 (`_inbox/done/dsm-jupyter-book.md` block 2). Creation-time gap: sprint-plan BLs created via `/dsm-backlog` lacked DSM_2.0.C §1 Template 8 sections, omission invisible until sprint closure when BL-378 detective audit fires. | `_inbox/done/dsm-jupyter-book.md` (block 2 sprint-plan template concern) | Preventive + detective pattern: BL-380 injects at creation, BL-378 validates at closure. Same template-coverage target from opposite ends. Mirror of BL-370/BL-319 pattern (static rule + enforcement hook pair). |

### v1.4.17 (2026-04-12)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-107 | 2026-04-16 | Mirror clones ship commands tracked | BL-373 F2 | BL-372 T7 surfaced that fresh TAB clones on Windows PowerShell couldn't invoke `/dsm-go` because sync-commands.sh requires bash + HOME resolution that WSL-from-PowerShell handles unpredictably. User flagged cross-platform hostility; BL-373 filed; F2 is the structural fix that eliminates bash dependency at first-clone by shipping the 13 user-level commands tracked in `.claude/commands/`. | — | Same pattern as BL-372 F5 hub fast-path fix: the real bug was in the mechanism, not in the protocol. Tight feedback loop: behavioral test found the friction, design iteration rewrote the mechanism to eliminate it. The `source >> target` mapping syntax generalizes beyond this one case (future mirrors with different layout can use the same pattern). |
| F-106 | 2026-04-16 | Git-mv rename-staging warning hook | BL-370 | Three sightings of the same failure in 2026-04: S184 BL-349 (BL file rename + Edit content lost), S190 IronCalc inbox move (same), S191 `/dsm-light-go` checkpoint annotation (same). MEMORY had the rule; static-rule recall insufficient across sessions. Hook is the third independent enforcement layer after the per-turn transcript hook pair (BL-319/324). | MEMORY.md Common Pitfalls "git mv does NOT restage prior Edit-tool content changes" | Static rules + hook enforcement: the same failure hit three times. The enforcement mechanism follows the BL-319/324 pattern (PreToolUse hook filtered to specific tool calls). Thematic parallel to F-094 (per-turn transcript append enforcement) — both turn "agent should do X" into "hook catches when agent doesn't". |
| F-105 | 2026-04-16 | Cloned-Mirror Kick-off Protocol | BL-372 | S191 user-driven WSL clone test of TAB failed on 17 friction findings (PR #36). Root cause audit showed sync list missed ~30 load-bearing files; TAB shipped no `.claude/` infrastructure; no first-clone protocol existed. User refined initial over-prompting design ({author}/{github}/{linkedin}) to zero-prompt auto-derive. T7 behavioral test on Windows Claude Code v2.1.39 revealed F5 hub fast-path / Step 3 integration gap, patched inline. | TAB PR #36 first-clone-test findings | Fourth-wall breakage: the methodology was self-hosted on Central and had never been tested from the outside. The Kick-off protocol is the answer to "what does a DSM mirror need to self-bootstrap?" — and auto-derived placeholders is the answer to "how much personal data should Kick-off collect?" (none). Symmetric anti-requirements: §25.3 "no personal-content copy" + "no personal-content collection". |
| F-104 | 2026-04-13 | "We Need to Talk" foundational principle (DSM_6.0 §1.10) | BL-346 | S182 user observation: Gate 0 improvised step-by-step dialog model was the missing entry point to all collaboration. The principle names why: presenting a pre-formed plan reduces human from collaborator to approver. | — | Take a Bite governs delivery size; We Need to Talk governs entry quality. Parallel architecture: principle (DSM_6.0) → operational protocol (DSM_0.2 §8.0). |
| F-103 | 2026-04-13 | Infrastructure File Collaboration Protocol (DSM_0.2.B §8) | BL-343 | S182 incident: 7 auto-approved Edit calls to dsm-go.md and dsm-align.md. BL-342 research revealed SKILL.md frontmatter (12 fields), 24+ hook events, allowed-tools governance gap. | — | Extends the "one cell at a time" / "one file at a time" collaboration model to infrastructure files. Same root-cause family as F-094 (enforcement gap), but the gap here is in the collaboration protocol, not the enforcement mechanism. |
| F-102 | 2026-04-12 | DSM_0.2 §7 authorized exception for `/dsm-staa` | BL-351 | S185 STAA session on S184 where the STAA agent quoted its own thinking: "appending analysis notes to S184 would corrupt the transcript being examined". Correct behavior (no transcript write) from a wrong rationale (file corruption) that is physically impossible, archived subject and live reasoning log are two different files. User surfaced the thinking block from the STAA conversation to DSM Central S185 for triage. | — (live session observation in a separate Claude Code STAA conversation, no inbox entry) | Near-miss rationalization as a defect. The STAA agent's behavior was correct, but the rationale was wrong, and correct-behavior-wrong-rationale is a latent failure mode that will eventually surface in an adjacent situation where the wrong rationale produces wrong behavior. Fix is prose tightening at two levels: DSM_0.2 §7 gains an explicit authorized-exception paragraph (not implicit via the skill file), and the skill file gains a "Two files, do not confuse them" block that names the subject-vs-live-log distinction. Also a demonstration of the Fix + Root-cause + Prevent structure from §22: fix the §7 gap AND the skill prose, root-cause is that BL-331 unconditional-activation language never audited existing skill exceptions, prevent by making the exception explicit and bounded ("no other skill may suppress without a §7 amendment"). |

### v1.4.16 (2026-04-11)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-101 | 2026-04-11 | DSM_0.2 §22 stop condition on the current output | BL-350 | blog-poster S19 incident where the agent acknowledged a CLAUDE.md violation mid-paragraph and continued presenting unread-source-based BL-010 angle rankings; the user had to escalate ("this is unacceptable") to halt the output | blog-poster S19 inbox entry processed in S183 (moved to `_inbox/done/`) | Rule freshness matters more than rule existence. §22 existed for multiple sessions, but its stop-condition language was implemented one turn after I violated it with a `git commit --amend` in the same session. The "before continuing other work" phrasing was soft enough that even an agent aware of the rule could finish the current output first. The fix is not "write the rule more emphatically" in a new document; it is tightening the specific clause that permitted the bypass. Operational expression of DSM_6.0 Earn Your Assertions: claims resting on unread sources are not earned, and acknowledging the gap does not retroactively repair the claim. |

### v1.4.15 (2026-04-11)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-100 | 2026-04-11 | `/dsm-align` External Contribution governance scaffold | BL-348 (plus BL-347 rename prerequisite, and mid-session tier-1 fix after IronCalc audit revealed layered-interpretation gap) | S183 user observation during IronCalc session start that the governance folder at `~/dsm-collaboration-storage/IronCalc` (now `dsm-external-contribution-storage`) was never audited or fixed by `/dsm-align`, because EC had no code path | — (live session observation, no inbox entry); audit inbox written TO IronCalc at `~/dsm-external-contribution-storage/IronCalc/_inbox/2026-04-11_dsm-central-s183_audit-recommendations.md` | Same root-cause family as F-096 (delivery mechanism gap): the infrastructure lacked a code path for a project type that the methodology already named. EC was described in DSM_3 §6.6 for months without `/dsm-align` knowing what to do with one. The fix is not new methodology; it is making the tooling match the methodology. Also a demonstration of the "fix the code, not the data" heuristic: IronCalc's layered layout (Project type: Application + Participation pattern: External Contribution) was legitimate; the buggy single-field detector was the problem. User intervention ("isn't this already defined in CLAUDE.md lines 6-7?") redirected an Option C convention fix into Option B code fix. |

### v1.4.12 (2026-04-09)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-096 | 2026-04-09 | Per-turn transcript hook delivery to spokes | BL-319 (split from BL-318 Layer 2 per §21 scope rule) | Portfolio S69 (6-turn append gap) + blog-poster S17 (1-entry session), both showing the BL-318 hook was local-only and never delivered to spokes | _inbox/dsm-data-science-portfolio.md (S69 evidence) + dsm-blog-poster S17 wrap-up lesson | Documentation without a delivery mechanism is shelfware. The BL-318 hook was effective where installed, invisible where not. The delivery channel (ecosystem-pointer copy during /dsm-align) reuses the existing alignment flow instead of creating a parallel sync, reinforcing the "extend existing channels" heuristic from the Option C > Option B pattern. Same root cause family as F-091/F-092/F-093/F-094: protocol text lands, enforcement mechanism does not. |

### v1.4.9 (2026-04-07)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-095 | 2026-04-07 | Process narration in transcript thinking blocks | BL-318 Layer 2 (mid-conversation scope expansion) | S172 user observation that the collapsed extended-thinking view contains inefficiency loops the curated transcript hides | — (live conversational observation, no inbox entry) | The observable artifact must expose the inefficiency signal, not filter it out. Inverse of "clean summaries"; parallel to "make failure visible, not success visible". The curated thinking block was optimizing for reading speed at the cost of destroying the debugging signal the user needed. |
| F-094 | 2026-04-07 | Per-turn transcript append enforcement | BL-318 (Layer 1 + Layer 2) | S171 protocol violation (7 consecutive turns without transcript appends despite §7 + /dsm-go step 6) | — (self-observed during S171 wrap-up) | Rule existence ≠ rule enforcement. Same thread as F-091/F-092/F-093: DSM_0.2 §7 existed and was read, but had no surface forcing compliance. Require-mechanism (UserPromptSubmit hook) must exist alongside validate-mechanism (PreToolUse shape check). Hooks are the behavioral surface for per-turn protocols, paralleling §17.1 templates as the behavioral surface for spoke-level protocols. |

### v1.4.8 (2026-04-07)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-093 | 2026-04-07 | Python virtual environment protocol | BL-284 | Inbox feedback (german-adversarial-prompting S7) | — (incident report in BL Origin field) | Hygiene the agent should have done by default but didn't because no protocol made it explicit. Same class as F-091/F-092: rule existed in collective Python practice, but DSM had no surface enforcing it. |

### v1.4.7 (2026-04-07)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-092 | 2026-04-07 | Runtime register context for register-sensitive skills | BL-287 | Inbox feedback (german-adversarial-prompting S8) | — (incident report in BL Origin field) | Skills are agents-within-agents: they need the same context the host agent has, and "context" includes register/audience, not just content. Install-time governance (§23.1-23.3) is necessary but not sufficient for register-sensitive skills. |

### v1.4.6 (2026-04-07)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-091 | 2026-04-07 | Planning pipeline gate in alignment template | BL-316 | Inbox feedback (utility_conversational_ai S1 MO-1) | `_inbox/done/2026-04-06_utility-conversational-ai-mo1.md` | Same S170 thread as F-089/F-087: "protocol existence ≠ visibility, the §17.1 template is the behavioral surface." Continues v1.4.5 storyline. |

### v1.4.5 (2026-04-06)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-090 | 2026-04-06 | Sprint Retrospective Intelligence | BL-310 (Phase 4) | Multi-phase principle operationalization | — | DSM_6.0 §1.9 Think Ahead operationalized at sprint boundaries |
| F-089 | 2026-04-06 | Cross-repo write safety in alignment template | BL-315 | Inbox feedback (ADSAIPP S8) | `_inbox/done/` ADSAIPP feedback (S170) | S170 lesson: "protocol existence ≠ protocol visibility. The §17.1 template is the behavioral surface for spoke agents" |

### v1.4.4 (2026-04-06)

| F | Date | Title | BL | Origin | Inbox source | Meta-pattern |
|---|------|-------|----|--------|--------------|--------------|
| F-088 | 2026-04-06 | Wrap-up type marker for session-start guidance | BL-314 | Session lifecycle gap (S168 incomplete handoff) | — | Lightweight vs full session symmetry: state must travel both directions |
| F-087 | 2026-04-06 | Factual accuracy in Code Output Standards | BL-310 (earlier phase) | Multi-phase principle operationalization | — | DSM_6.0 §1.3 Earn Your Assertions operationalized in spoke template |

---

## Narrative threads (cross-feature stories)

Some features tell a richer story together. These threads pre-stage common blog angles.

### Thread: "Protocol existence is not protocol visibility" (v1.4.4-1.4.5)

**Features:** F-087, F-089
**BLs:** BL-310 (early phases), BL-315
**Story:** Spoke agents kept violating rules that already existed in DSM_0.2 modules and DSM_6.0 principles. The pattern wasn't "the rules are missing"; it was "the rules aren't where the agent reads." Both features add reinforcement to the §17.1 alignment template, which is the actual behavioral surface a spoke agent sees at session start. Same insight, two surfaces (Earn Your Assertions → Code Output Standards line; Destructive Action Protocol → Cross-Repo Write Safety section).
**Reasoning lesson:** S170 [auto] entry (read .claude/reasoning-lessons.md, search for "behavioral surface")
**Why this matters for users:** This is how DSM evolves, not by writing more rules but by moving existing rules to where agents can act on them. A blog post on v1.4.5 can use this thread to explain why "more documentation" is not the answer to "agents not following docs."

### Thread: "Session lifecycle symmetry" (v1.4.4)

**Features:** F-088
**BLs:** BL-314
**Story:** Light wrap-up exists for short continuation sessions, but the next session-start command had no way to detect that the previous session was light. Result: agents either ran heavy `/dsm-go` over a light context (overhead) or skipped checks they needed (gaps). The fix is a `.claude/last-wrap-up.txt` marker that every wrap-up writes and every session-start reads, so the two ends of the lifecycle agree on what happened.
**Why this matters for users:** Session boundaries are a recurring source of friction. This is the kind of plumbing that becomes invisible once it works.

### Thread: "Sprint boundary intelligence, not just sprint boundary mechanics" (v1.4.5)

**Features:** F-090
**BLs:** BL-310 Phase 4
**Story:** Sprint boundaries already had checklists (close X, push Y, update Z). Phase 4 of BL-310 added retrospective *analysis* across 6 dimensions, turning the boundary from a packing-up moment into a thinking moment. The pattern: mechanical compliance is necessary but not sufficient; the principle (Think Ahead) is what makes the boundary useful.
**Why this matters for users:** It's the difference between a daily standup that recites a checklist and one that surfaces the right next move.

---

### Thread: "Glue /dsm-align to /dsm-go: alignment as session-start invariant" (v1.4.13)

**Features:** F-097
**BLs:** BL-319 S180 follow-up
**Story:** /dsm-go Step 1.8 was conditional, only auto-running /dsm-align on missing marker, critical result, or version mismatch. Brittle. S180 hit four distinct failure modes that all collapsed if /dsm-align ran every session: hook scripts at git index mode 100644 (the deeper F-094 functional gap), stale markers, Claude Code window cache, scaffold drift. The user proposed gluing the two skills together, no exceptions. The cost is bounded (10-30s per session start), the safety value is large (every session starts aligned, every spoke self-heals).
**Why this matters for users:** Less reliance on "remember to run /dsm-align after pulling Central updates", more trust in "the session is always aligned because /dsm-go made it so".

---

## v1.4.14 thread (2026-04-10, S182)

| F# | Date | Title | BL | Origin | Inbox | Meta-pattern |
|----|------|-------|----|--------|-------|-------------|
| F-098 | 2026-04-10 | Gate 0 Collaborative Definition Protocol | BL-341 | S182 user observation: step-by-step BL definition was improvised, not codified | — | Emergent collaboration patterns formalized into protocol |
| F-099 | 2026-04-10 | Minimal troubleshooting boot with /dsm-safe-go | BL-340 | S182 pre-BL-338 safety requirement | — | Escape hatch before infrastructure changes |

**Why this matters for users:** Gate 0 ensures the human shapes the work structure at every step, not just approves a finished plan. /dsm-safe-go provides a way back in when the normal boot chain is broken.

---

*This file is the index. The full reasoning lives in the linked sources.*
