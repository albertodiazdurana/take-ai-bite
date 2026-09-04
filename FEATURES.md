# DSM Feature Timeline

A chronological record of capabilities added to the Deliberate Systematic
Methodology (DSM), the human-AI collaboration framework behind
[Take AI Bite](https://github.com/albertodiazdurana/dsm-take-ai-bite). Each
feature is numbered for easy reference (F-000 is the first, newest entries
appear at the top).

**Current count:** 176 features.

---

## September 2026

- **F-175 (2026-09-04) A standing rule retired in favour of a skill that does the same work on demand (v1.26.1, DSM_0.2 §17.1)** — Every project carried an instruction to convert a particular dash to a comma in anything a reader outside the project would see. It was correct, and it was never finished: a rule like that is enforced on every pass, by every author and every agent, forever, to reach a state a skill can now produce against a completed document in one go. The rule is removed rather than repaired. What prompted the review was a defect rather than a preference: an unrelated edit had already deleted the rule's body and left behind the three paragraphs that said which files it applied to, so the surviving text began "The rule governs..." with no rule above it, and the release told every project to adopt that state. Completing the deletion and retiring the rule turned out to be the same edit. The earlier entry describing the rule stays in this timeline, because a timeline records what was true at the time and is not a claim about what is current.

- **F-174 (2026-09-04) The reasoning log's before-acting entry is now called a plan (BL-545, DSM_0.2 §6)** — The block an agent writes before it acts was labelled "thinking", and that label sat in the instruction file loaded on every turn, in the reminder injected on every turn, and in every project's local configuration. Renaming it to "plan" says what the block is actually for, and removes the last copies of a vocabulary an earlier fix had already moved away from everywhere else. The reminder was changed first and on its own, because measurement put it ahead of the documentation: it is injected as its own short instruction every single turn, where the same word in the big always-loaded file appears once inside a large document. Nothing has to migrate. The checker that guards these entries matches the general shape of the label rather than a list of names, and only ever inspects the text being added, so old logs keep working, both names pass, and a project that never updates is not broken by the change. Verified in both directions, along with a check that the test could actually fail: the first attempt reported success on all three probes while never reaching the condition under test.

- **F-173 (2026-09-03) A completeness check that could never report complete (BL-534, `/dsm-go`, `/dsm-light-go`)** — Session start counts the project's standard folders and reports how many of them exist. It counted against nine where both the naming specification and the tool that creates the folders say eight, so a correctly set-up project reported eight out of nine at every boot and could never reach its own stated maximum. The gate never misfired; that is precisely why it lasted. A number that is wrong in a way that looks like a familiar quirk gets written off, and five separate projects plus the hub itself did write it off, one of them describing the missing folder as expected. It had also spread: a project was found carrying an empty placeholder file created purely to satisfy the phantom entry, which lifted its score to a false nine out of nine and hid the very incompleteness the check exists to find. The passing threshold is unchanged; only what it is measured against moves, which makes the check slightly stricter for any project that had grown the extra folder.

- **F-172 (2026-09-03) The instruction file loaded on every turn is 43% shorter (BL-543, DSM_0.2)** — The core instruction document is read in full on every turn of every session, and roughly two fifths of it was material consulted at most once: the origin story behind each rule, a protocol's enforcement narrative and worked examples, and the template text a single command copies verbatim. Those three kinds of content now live in four companion files the core points at, read when they are actually needed. The behavioural rules stayed where they are, including two that read like narrative but are actually instructions and were deliberately left behind rather than moved with the prose around them. The reduction came out of an experiment built to test a different theory, which the evidence went on to disprove; it is kept anyway, on the straightforward ground that a budget spent every turn is worth reclaiming whatever the experiment concluded.

- **F-171 (2026-09-03) Sessions that would not start on the newest models start again (BL-543)** — Sessions on the newest model family began refusing at boot, before any work could happen, on a project whose configuration had not changed in any way that looked relevant. The cause was one phrase in a block of always-loaded instructions that a model-side safeguard read as a request of a kind it declines. Two things about finding it are worth more than the fix. It was not a size problem, though it looked exactly like one: three rounds of trimming the loaded context, one of them below a size already measured as working, all still failed, and the failure only cleared when that single block was removed. And the wording was rewritten to say what it had always meant in the vocabulary the protocol itself already uses, rather than being tuned by trial and error against the safeguard. A standing practice came with it, and it outlasts the fix: a phrase that trips a safeguard must never be written down in a file that loads at session start, because the note-keeping machinery copies recorded phrases into exactly those files, which is how this one kept reappearing after each attempt to remove it.

## August 2026

- **F-170 (2026-08-25) Checking that a change left its document coherent, not just that the change worked (BL-531, DSM_0.2 §21.4)** — Every testing rule in the methodology is scoped to one backlog item: does this change do what it said, were its own conditions met, did its branch pass. All of them can pass while the document the change landed in is left contradicting itself, and nothing asked the wider question. A change now also sweeps for every phrase it removed or renamed and reads each surviving mention, on the understanding that most of them are legitimate , a historical note and a stale pointer look identical to a search, so a hit is a candidate and never a verdict. Three things a search cannot check are asked in prose instead: that references still point at something real, that any number the document states about itself is recomputed rather than carried forward, and that the edited file is actually carried by whatever distributes it. The check reports rather than blocking, and it stays silent on changes that renamed nothing, which is what keeps it from becoming the kind of warning people learn to click past. Origin: six items shipped in one session, someone asked whether they had interfered with each other, and the answer was no , but nothing had required anyone to look, and the audit that ran only because it was requested found a real defect.

- **F-169 (2026-08-25) A research run that reports success can still hand back an empty answer (BL-520, DSM_0.2 §19.3)** — A background research job completed five lines of enquiry across nineteen sources, checked seventy claims, ran a hundred and one assistants and spent roughly three million words of processing, then returned a summary reading "test" and a single finding reading "test claim". Every progress signal was real and every one of them said the work had gone fine. The genuine findings existed only in the individual assistants' own logs and were recovered by hand. Nothing had checked whether the answer that came back was proportionate to the work that produced it. That comparison now happens before the result is used, measured against the run's own reported effort rather than against any fixed minimum, so a small job that honestly returns a small answer is not flagged. When the result does look hollow, there is an ordered recovery path whose first two steps cost nothing, because the expensive work has already been done and paying for it twice is the reflex worth preventing.

- **F-168 (2026-08-25) A home for projects that arrive with the planning already done (BL-519, DSM_2.0.C Template 13)** — Planning templates covered sprints, phases, days and checkpoints, and stopped there. A project that turns up with a finished specification , a client's build document, a statement of work, a research protocol , had no canonical place to put the whole-project view, so the natural move was to re-describe the supplied plan as a second plan, leaving two descriptions of the same ladder to drift apart. There is now a project-level template that points at the source rather than copying it, with one table where a milestone becomes actual work. The filename is settled too: the conventions document said one spelling, the only real example in the wild used another, neither was binding, and a third project would have invented a third. The template changed during its own testing, because tracing the one real example found that it *supersedes* its source rather than deferring to it, which contradicted the draft's central rule and revealed a case the draft had missed.

- **F-167 (2026-08-25) The guard against writing outside the project now follows the command's own directory (BL-532, `validate-cross-repo-write.sh`)** — Writing to a file outside the current project needs your explicit confirmation. The check worked out where a write would land by resolving the path against the project folder, but a shell command can change directory first, and then the same relative path means somewhere else entirely. A command that stepped outside and wrote a file was judged to be writing inside, and passed without asking. It now resolves the path the way the command itself would. The way this was tested is worth knowing: proving it required a write outside the project, which is exactly the thing that needs permission, and the obvious safe location was one the guard deliberately ignores, so a pass there would have been indistinguishable from the bug. Because the check inspects the command before anything runs, a command aimed at a directory that does not exist fails immediately, writes nothing anywhere, and still gets fully evaluated. The test needed the offence described, not committed.

- **F-166 (2026-08-25) Feedback review stopped looking for filenames nobody writes any more (BL-533, `/dsm-review-feedback`)** — The command that gathers a project's feedback searched for an older filename shape, while every active project had moved to a dated per-session one. It reliably found nothing and reported that as an empty result rather than as a mismatch. It now reads both shapes, and six documents that had drifted into disagreeing about which shape is current were reconciled, including a ruling on when an older name is genuinely legacy and when it is a documented and still-valid form. Two claims in the original report turned out to be wrong and are recorded rather than quietly dropped. The search that established the scope was also wrong the first time: it had been narrowed to the folder where these files usually live, and re-running it without that restriction found nearly twice as many places , including the instruction template a person copies to invoke the very command being repaired.

- **F-165 (2026-08-25) A safety net that had never once caught anything (BL-535, `/dsm-wrap-up`)** — Wrap-up checks for a leftover open pull request that would collide with the one it is about to create. The check asked for branches named with a prefix, but the underlying option matches a branch name exactly, so it matched nothing and the net had never fired in the entire life of the step. The failure hid in the most durable way available: six consecutive sessions believed the check was catching two deliberately retained pull requests and worked around it on that basis, and every uneventful session reinforced the belief. Nothing had ever collided. The check now filters correctly and distinguishes three outcomes instead of silently reporting none, and it was verified against a case created on purpose to trigger it , a check that can only ever say "nothing found" proves nothing about whether it can find something.

- **F-164 (2026-08-21) Two sprint-closure checklist items you could never honestly tick (BL-521, DSM_2.0.C Template 8)** — Sprint closure is gated on a nine-item checklist, and two items named files nothing ever created, failing in opposite directions. One carried an escape clause true forever of a project that will never record smoke tests, so it could be ticked truthfully without the file existing and the check could never fire. The other named a blog publication tracker that no scaffolding step produced, so it could not be ticked truthfully at all. Both leave a closure record whose ticks do not mean what they appear to. The waiver is now scoped to the kind of project it applies to, matching how the neighbouring item already worked, and the tracker is created on scaffolding with a note that an empty table means nothing has been published, which is different from the file being absent. The audit this prompted found a third: the phase checklist pointed at a feedback file the alignment command itself asks projects to migrate away from.
- **F-163 (2026-08-21) Approving six agents can no longer run eleven (BL-524, DSM_0.2 §8.9.2)** — The cost gate asks for consent before a task fans out into many parallel model calls, and it priced that consent on the number of agents launched directly. Nothing stopped one of those agents from launching a fan-out of its own, and a six-agent approval was observed running eleven. Agents spawned inside an approved fan-out now have no authority to delegate further unless the approval said so, and where it does, the disclosed number is the ceiling on the total rather than the first level. The gate's trigger also excluded the very mitigation the gate recommends: it asked whether the calls draw on the same budget as your main thread, while advising you to move them to a cheaper one that has its own. What makes a fan-out risky is many calls competing for one exhaustible budget, and running out of the cheap one stops the work exactly as hard.
- **F-162 (2026-08-21) Guides that tell you when they do not apply to you (BL-522, `dsm-docs/guides/`)** — Some hard-won lessons are a landmine under one specific setup and pure noise everywhere else, and there was nowhere to put them: written as general advice they get applied where they do not belong, left unwritten they get rediscovered the expensive way. Guides now have an index, and a guide may open by naming the conditions that must all hold, with an explicit instruction to stop reading if they do not. Each condition has to be checkable without reading the guide, since a condition you can only evaluate by reading the thing defeats the point of gating it. The first one covers a credential that is read once when the editor starts, silently forwards its own placeholder text as your API key when unset, and reports the server healthy because the health check never authenticates.
- **F-161 (2026-08-21) A missed notification is no longer missed forever (BL-530, `/dsm-go`)** — Notifying the blog project of new features was computed from what changed in the current session, so an entry the session failed to send stopped being a candidate the moment the session ended. Three ordinary endings skip that send. Session start now compares the feature list against what the recipient has actually received and reports the gap, which is the only moment that can catch the *previous* session's omission. Two details came from running it rather than reasoning about it: a feature counts as delivered only when quoted in full, because matching bare numbers read the sentence "past entries (F-001 to F-086) are populated lazily" as eighty-six deliveries; and the starting point is derived from the recipient's own history rather than fixed, because the real record was patchy rather than simply behind; three entries were missing beneath six that had arrived.
- **F-160 (2026-08-21) The transcript now notices when a timestamp is wrong (BL-517, DSM_0.2 §7)** — Four checks guarded how reasoning-log entries are appended and none of them read the time the entry claims. Three sessions logged timestamps off by as much as thirteen hours, one recording a decision as authorised forty minutes after the action it authorised had already happened, and every check passed. The clock is now compared against the stamp and a drift is flagged. It warns rather than refusing the write, deliberately: the other checks guard against damaging the file, while a wrong timestamp only mislabels an entry, and blocking the write would stall the very logging the check exists to protect. Retroactive entries get no exemption, because they are required to carry the current time in the first place.
- **F-159 (2026-08-20) Slash commands reach every project, not just the one that ships them (BL-518, `sync-commands.sh`)** — Five commands were being installed to a folder only the hub could see, so every other project quietly loaded a copy that nothing had written in four months. The visible cost was not staleness in the abstract: the backlog command those projects loaded was missing both the risk section and the test-results section the methodology requires, so items filed through it broke the very rules meant to make them auditable, while the agent believed it had followed the skill. The drift checker reported everything healthy the whole time, truthfully, because it compared each command against the folder it was sent to rather than the folder a project reads from. All commands now install to one place, the checker reports leftover copies at the retired path, and the mirror manifest carries the five it was missing so a mirror clone cannot reproduce the same gap.
- **F-158 (2026-08-20) A pull request can no longer be opened from a branch that is missing your latest commit (BL-516, DSM_0.2 §20.4)** — A pull request is built from the branch as it exists on the server, so a commit made after the last push is absent from the request, absent from the merge, and destroyed when the merge deletes the branch holding the only copy. Every step reports success. The rule now requires confirming there is nothing unpushed before a request is opened or merged, and halting with the missing commits named rather than pushing them silently, since an unpushed commit at that moment usually means the branch is not in the state its author thinks. The rule also records why the obvious remedy is the wrong one: git already refuses to delete a branch holding work that is not merged, and the request-merging tool bypasses that refusal, so the check has to happen before the tool runs and can never rely on it declining.
- **F-157 (2026-08-20) The boot no longer claims to have read a file it only partly read (BL-491, `/dsm-go`, DSM_0.2.A §8.1)** — The reasoning-lessons mirror read at every session start was governed by two size caps that could not work: one advertised a limit the file exceeded roughly thirteen times without anything noticing, the other was arithmetically impossible to exceed and so reported healthy no matter how large the file grew. There is now a single bound, derived from two independent measurements that agree within 1.7%, and a breach reports the measured size against it instead of passing in silence. The behavioural half matters more than the number: when the file no longer fits one read, the session says so and states what it read instead, where before a partial read and a complete one produced identical reports.
- **F-156 (2026-08-20) A command that fails is no longer able to report success (BL-515, DSM_0.2 §19.2)** — Piping a command into something like `tail` or `wc` and then testing the result checks the wrong command, because a pipeline reports on its last step rather than the one you care about. A failing push could print "pushed" and a failed search could look like a clean result. The rule now names both directions this fails in, gives three verified ways to check the command you actually ran, and rules out the shortcut that caused it.
- **F-155 (2026-08-19) Session analysis picks a subject that has not been analysed yet (BL-509, `/dsm-staa`)** — Subject selection now asks how many candidate transcripts are still unanalysed and acts on the answer: none halts and changes nothing, one becomes the default, two asks which. The previous behaviour picked the latest archived transcript and warned when that was probably the wrong one, and the warning was overridden on six consecutive runs, because the window it flagged turned out to be the normal shape of the workflow rather than an edge case. A default taken zero times out of six is the wrong default. The halt also reports the values that produced it, so a refusal to run can be diagnosed in one read instead of arriving as a bare "nothing to analyse". Origin: a run in which both candidate subjects had already been analysed, where following the step literally would have appended duplicate lessons and overwritten the record of the last real pass with a record of a null one.
- **F-154 (2026-08-19) The punctuation rule follows the reader rather than the repository (BL-513, DSM_0.2 §17.1)** — Writing conventions now govern any file that reaches a reader outside the project, by any channel, with publication to a public repository named as the most common instance rather than as the definition. A document sent as an attachment has an outside reader and is governed exactly as a published page is. The revision also says when not to apply the rule mechanically, which nothing in the corpus had said before. An em dash joining two independent clauses wants a period or a semicolon, because a comma there produces a splice. And an em dash separating a numeric range must never become a comma: in a decimal-comma locale the range silently turns into a decimal, and the result still reads as plausible prose. Origin: a rule whose stated test was readership had been implemented as repository visibility, so a private project's CVs and cover letters, the documents that most need the convention, were the ones it exempted.
- **F-153 (2026-08-19) Handoffs are read before they are filed away (BL-511, `/dsm-go`)** — A handoff left by the previous session is now read in full at session start, its pending items surfaced in the boot report and labelled by source alongside the checkpoint's, and only then archived. Where the two sources disagree about what comes next, the disagreement is shown rather than quietly resolved in favour of one. The report also distinguishes a handoff that was read from one that was merely filed, which used to produce identical lines. Origin: the step opened by asserting that any handoff predating the session had already been consumed, which stated an assumption as fact and made the archiving look successful every time. Handoffs are written only when pending work is complex enough to need them, so the sessions that most needed the context were the ones losing it.
- **F-152 (2026-08-13) The punctuation rule now says which files it governs (BL-505, DSM_0.2 §17.1)** — Writing conventions now apply where they are read: the em-dash-to-comma rule governs files that reach a public repository, and files that live only inside a private repo are exempt, as are gitignored files anywhere. For a project with a public mirror the governed set is whatever the mirror-sync manifest carries; for a project that is itself public it is every tracked file. The test is readership rather than whether a file is agent-consumed, because published methodology is read by agents too and that test exempts nothing. Exempt is not forbidden either, so a private file can still be tidied without the rule demanding it. Origin: a rule written for published prose had been quietly governing session transcripts and reasoning-lessons files, where nobody reads the punctuation and the cost is paid on every append.
- **F-151 (2026-08-12) Spoke hook installation stopped dropping two thirds of its work (BL-503, `/dsm-align`)** — Spoke hook installation now matches on the tool surface *and* the script, so the next alignment run on any spoke fills in registrations that earlier runs dropped. One script is deliberately registered against three different tool surfaces; the old check looked at the script name alone, so the first registration landed and the other two looked like duplicates and were discarded, including shell-command coverage added a week earlier that had therefore never reached a single spoke. The step reported success either way, so nothing distinguished a complete install from a third of one. Origin: found by a spoke while carrying out a previous release's instructions, not by looking for defects.
- **F-150 (2026-08-12) A research file's "confirmed" label can no longer outrun what was actually checked (BL-501, DSM_0.2 §10.1)** — A verification pass now records *which* sources it covered rather than only how many, and a status label may claim no more than that scope supports. "10 of 13 confirmed" does not say which 13, so a wrong citation sitting inside a "confirmed" list of 25 is unauditable in either direction. The rule arrives with a distinction worth more than the rule: a **log** records what a pass found and is never rewritten, an **index** asserts current status and is a defect when false. That single sentence answers "am I allowed to edit this artifact?", a question DSM had been resolving case by case. Origin: a research file labelled 25 sources confirmed over a pass that had covered 13, and the wrong pointer buried in the over-claim survived a pass built to catch exactly that.
- **F-149 (2026-08-05) Concurrent-session liveness verdict instead of an impression (BL-487, DSM_0.2.A §26)** — When a session start finds another session's lockfile, it now probes whether that session's process is actually running and reports `LIVE`, `STALE`, or `UNKNOWN`, rather than leaving the agent to guess from how long ago the transcript was written. `UNKNOWN` is a real answer, not a failure: a lock that cannot be probed is not an absent one, and the age signal stays a hint, never a verdict. The probe informs the choice and never makes it, the halt still stops and asks in all three states, and a `STALE` reading does not pre-select "force". Origin: a session that halted on a live sibling's lock, read it as stale, and continued, producing interleaved transcripts and five duplicated reasoning entries.
- **F-148 (2026-08-05) Cross-repo write guard covers shell file operations (BL-484, DSM_0.2.C)** — The rule against writing outside the repo without confirmation was stated tool-agnostically but enforced on two tools only, so every `cp`, `mv`, `>`, `>>`, `tee` and `rsync` reached any path with nothing in the way. Shell commands now reach the guard too. It warns rather than blocks, on purpose: a shell command's write targets have to be inferred from the text, and a gate that blocks on a guess fires on ordinary work and teaches you to dismiss it, which is worse than no gate because a dismissed gate still looks like protection. The documentation now states what the check does and does not see, so it reads as a floor rather than a guarantee. Origin: a spoke lost 181 reasoning-lesson entries to a single redirect and got them back from git by luck of timing.
- **F-147 (2026-08-05) Published snippets are run before they ship (BL-485, DSM_0.2 §19.1)** — A command published inside a skill file is a claim about two things it never states: what its input looks like and what environment it runs in. Neither is checked when it is written, so the rule now requires running it against the real file, in the real harness, before the change merges, and capturing the output as evidence. It asks a second question beyond "did it work": would a wrong result have looked any different from a right one. The trigger covers prose specifications as well as fenced code, because one of the two defects that motivated the rule lived entirely in a sentence and never sat inside a code block. The rule's own acceptance test caught that gap: it walks both original defects through the draft and fails if either slips past. Origin: two such defects were live at once, both reported by spoke projects rather than by the hub that wrote them, and both reproduced at the boot of the session that fixed them.

## July 2026

- **F-146 (2026-07-28) Causal-forward session handoffs (BL-475, DSM_6.0 §1.13 Delegating face)** — A checkpoint's pending list now states, per item, what the continuation requires and why, what it depends on, what order the dependencies force, and what breaks if it is skipped, so the next session acts on the ordering instead of rebuilding the reasoning from task names, or re-opening a decision the previous session already settled. Applied to the three skills that author pending lists (`/dsm-wrap-up`, `/dsm-quick-wrap-up`, `/dsm-checkpoint`); the consuming side needed no change, because the *why* travels inside the format. The rule bounds its own verbosity: an item is longer by exactly the causal links the receiver would otherwise rebuild, and an item with no dependency is stated plainly rather than padded with invented rationale. Origin: the meter-to-cash spoke wrote its S6 handoff this way and its S7 session acted on the ordering without reconstructing it.
- **F-145 (2026-07-28) Downstream Impact Map for cross-BL coupling (BL-474, DSM_6.0 §1.13 Registering face)** — A backlog item that settles something later items will build on (a schema, a vocabulary, a shared surface) can now record that coupling on itself, at the moment it settles it and while the interface is still cheap to change, instead of leaving each downstream author to discover it later and record only their own partial view. The section is optional and guarded by a consumption question, so leaf items omit it rather than filling an empty table. When a consuming item is eventually built, the map is checked against what actually happened, and the useful output is the mismatch: consumed but never mapped, mapped but never consumed, or consumed differently than forecast. Origin: the meter-to-cash spoke's first module BL carried a six-row map. The mechanism's first map inside DSM itself was wrong in both rows, and the reconcile step is what caught it.
- **F-144 (2026-07-28) Informed-consent gate before high-token-cost fan-out actions (BL-476, DSM_0.2 §8.9.2)** — Before an action that turns one invocation into many independent model calls against a shared usage window, the agent must say what it will cost: the shape of the fan-out, an order-of-magnitude token estimate, the model tier, the risk that exhausting the window forces a hard stop mid-run, and cheaper alternatives offered as real options rather than a footnote. The gate cannot be bypassed by auto mode or cleared by a general "proceed", and it deliberately does not fire on ordinary expensive-looking work, because a gate that fires on everything is one the user learns to click through. Origin: a session that spent roughly 3.0M tokens across two research passes, exhausted the window, and returned a partial deliverable after the second pass died mid-run.
- **F-143 (2026-07-28) A bite is the smallest increment the reviewer can verify (BL-478, DSM_6.0 §1.1)** — The unit of collaborative work is now defined by what the reviewer can actually check, one testable function, one notebook cell producing one output, one short passage, rather than by what is convenient to produce. Test-first became a standing rule instead of a per-item preference, and the build order was corrected across the methodology and the template spokes receive. The framing that treated an IDE permission window as the collaboration gate is gone: approving a write is not approving the concept, including when writes are auto-approved. Origin: a spoke session where the weak wording turned out to live in the spoke-facing template rather than the protocol everyone assumed it came from.
- **F-142 (2026-07-12) Forward the Why collaboration principle (BL-473, DSM_6.0 §1.13)** — When knowledge or a decision flows forward to a later BL, session, or step, the causal link is now encoded at its source, so the receiver inherits the reasoning ("resume at X because Y depends on it") instead of reverse-engineering intent after the fact. The principle names three faces of the same move: Registering (cross-BL coupling recorded on the interface-settling BL), Delegating (a checkpoint's pending list written causal-forward), and Planning (steps derived from their dependencies rather than a flat task list). It takes the §1.13 slot from "Introduce Once, Then Deepen"; that writing discipline moved to DSM_0.2 §8.10 and was renamed "Present Once, Then Deepen" ("introduce + deepen" can connote inserting content not in the source). Origin: the meter-to-cash spoke ran two of the faces live (Downstream Impact Map, Causal Handoff) and named the parent once it saw they were the same move.

## June 2026

- **F-141 (2026-06-18) Subchapter/paragraph bite + file-first editable delivery for chunked drafting (BL-465, DSM_0.2 §8.10 Gate 3)** — Structured-prose deliverables (plans, proposals, reports, research files, blog posts) are now drafted one subchapter at a time, or one paragraph when the subchapter is long, and each bite is written to an editable draft file rather than pasted into the conversation, so the user edits the draft in place between bites instead of relaying changes back through chat. Explicitly modeled on the Notebook Collaboration Protocol (one cell at a time, user returns review before the next). Incremental per-bite file writes are the delivery; generating the whole document in one write stays prohibited, and Gate 4 remains the cross-section consistency pass. Origin: Data Science Portfolio S106, validated live on a 4-part blog series.
- **F-140 (2026-06-15) STAA reminder logic with crash-recovery off-by-one fix (BL-442, `/dsm-go` Step 5.7 + `/dsm-staa`)** — The session-start reminder to run STAA (Session Transcript Analysis Agent) on the previous session now cross-references `.claude/last-staa.txt` before firing: it suppresses the reminder when STAA has already analyzed that session or a later one (`analyzed_session >= N`, where N is the recommending session). Previously the reminder fired off the archived transcript's "STAA recommended: yes" text alone, so a session that had already been analyzed still produced a stale prompt (portfolio S84). A missing `last-staa.txt` degrades to "remind" (the conservative direction, never silently skip). Origin: portfolio S84 false-positive, generalized into the cross-reference rule.
- **F-139 (2026-06-15) Open-PR CI status surfaced at boot and wrap-up (BL-441, `/dsm-go` Step 2a.7 + `/dsm-wrap-up`)** — When the current branch has an open GitHub PR, the boot report now surfaces that PR's CI status so a session never resumes on top of silently-failing checks. Failing checks are enumerated by name, an all-green PR collapses to a one-line summary, and pending checks stay silent (a mid-workflow resume is not a failure). It is one `gh` call at boot, skipped silently when there is no `gh`, no GitHub remote, or no open PR for the branch, and never blocks the boot on a `gh` error. Origin: IronCalc S14, where PR #865's `lint-all` check was red for 20 days (a `cargo fmt --check` failure) while `/dsm-go` reported "awaiting re-review" from MEMORY; the user had to ask "check PR #865" to surface it.
- **F-138 (2026-06-15) Read-Before-Draft for OSS contributions (BL-437, DSM_0.2.D §9)** — Before drafting a PR or issue body for an external maintained repository, the agent reads the target's contribution surface first: CONTRIBUTING.md (and nested guides), `.github/pull_request_template.md`, the PR-gate workflow files, and one or two recent merged PRs of similar shape. It then drafts against the resulting readiness checklist (title format, body structure, release-note requirement, required CI, CoC/CLA, test-evidence) rather than an internal default, surfacing that checklist in the Pre-Generation Brief Gate 0. Pre-draft hygiene that pairs with Voice-Attribution Review (post-draft, pre-send) on the same outbound channel. Origin: external-contribution sessions where PR bodies were drafted against an internal template instead of the target project's stated conventions.
- **F-137 (2026-06-15) Voice-Attribution Review for byline content (BL-439, DSM_0.2.C §2.3)** — Content posted under the user's byline (PR/issue comments, commit messages, inbox notifications) is the user's words, so approving the *send* is not the same as approving the *content*. Network-mediated sends (`gh pr comment`, `gh issue comment`, `gh api`) have no diff window the way a file write does, so the agent surfaces the full body in conversation, gets explicit approval of the body, and only then runs the call. A bundling rule keeps a voice-attributed send as its own content gate, never folded into an action sequence (a "commit + push + post comment" request splits the comment into its own approval). Distinct from Cross-Repo Write Safety, which governs the path a write lands on; this governs whose words go out. Origin: the recurring pattern where send-approval was read as content-approval on outbound byline channels.
- **F-136 (2026-06-09) Soft Injection / Frame Capture safety protocol (BL-436, DSM_0.2.C §3.1 + DSM_6.0 §1.14)** — Cooperative external content (a polite comment on a public issue thread, a suggestion in a tool result, a third-party message on a shared thread) can drift the agent at the decision-framing layer without the user authorizing engagement, and no suspicion filter catches it because nothing about it looks hostile. DSM_0.2.C §3 already gated syntactic injection (shell commands, suspicious patterns); the new §3.1 "Soft Injection and Frame Capture" adds a classify-surface-wait-plan 4-step gate for the framing layer, plus a default-on-ambiguous-response rule (a generic "ok"/"proceed" does not clear the gate; the agent re-surfaces with specific framing in case the affirmative was meant for an adjacent action). The classify step separates passive observation (reading external content, always allowed) from engagement framing (adopting its options or letting it set the agenda, gated), so legitimate reads are not slowed. The foundational principle is the new DSM_6.0 §1.14 "Observe Before Engaging": external content is observation by default; engagement requires explicit user authorization, because politeness is not authorization and being on-topic is not an invitation. Spokes inherit the surface through a §17.1 base-template safety-pointer line surfaced by `/dsm-align`. Origin: heating-systems-conversational-ai S13, where polite volunteer comments on a public OSS issue thread shifted the agent into "A/B/C engagement options" without the user authorizing engagement; the spoke flagged it as structurally identical to prompt injection.
- **F-135 (2026-06-01) Present Once, Then Deepen writing discipline (BL-454; reclassified to DSM_0.2 §8.10 in BL-473)** — Structured prose with a summary-then-body shape (project plans, proposals, reports, CVs, public-facing copy, research files) now has a named information-architecture discipline: present each concept, metric, or claim once and let the body deepen it, rather than restating it verbatim between summary and body. Two facets come with it: lead with the descriptive phrase before the acronym in introductions ("a Deliberate Systematic Methodology" before "DSM"), and when a deliverable needs both a no-repetition refactor and a humanizer pass, run the repetition refactor first and the humanizer second (the reverse wastes humanizer effort on prose about to be cut, and repetition is not an AI tell the humanizer catches). Reclassified in BL-473 from a DSM_6.0 §1.13 principle to a DSM_0.2 §8.10 writing discipline (it governs a document's internal structure, not the collaboration itself, so it is a protocol, not a §6.0 principle); DSM_0.2 §8.10 Gate 4 is its home, applying it as the cross-section repetition check plus the ordering rule, so prose produced through the chunked-drafting protocol surfaces it. Scope is the summary+body shape, not document length; short-form text, tables, code, and checklists are out of scope. Origin: pattern stabilized across CV summaries, public-facing copy, and hiring deliverables in the portfolio spoke (S85/S86/S87), promoted when it cleared the "multiple deliverable types" bar S86 set.
- **F-134 (2026-06-01) User-Reframes-Proposal Handling sub-rule (BL-453, DSM_0.2 §8.0.1)** — Gate 0 (Collaborative Definition) gains a named operational sub-rule for one recurring move: when the user responds to a proposal by reframing it (re-decomposing, re-shaping the structure) rather than answering yes/no, the agent re-decomposes instead of defending the original framing. Two sub-rules: loose framing ("formalize this", "address these") triggers "what threads do you see?" before any decomposition is proposed; a reframe that doubles as "this also explains why the original problem existed" is a diagnostic that the first framing missed a structural coupling. Four distinct sibling patterns (user-factual-question, pointer-as-implicit-correction, "why does this matter?" drop-signal, deliverable-portability scope-expansion) are cross-referenced, not absorbed. §8.0 already stated the principle ("the conversation IS the collaboration") but agents defended their framing across six recurrences (S180/S183/S200/S201/S203/S204) over four-plus months, so §8.0.1 names the behavior the principle implies. Origin: pattern promotion from `.claude/reasoning-lessons.md`, filed S214, implemented S215.

---

## May 2026

- **F-133 (2026-05-31) Smoke tests as a named DSM artifact (BL-452, DSM_4.0.A §7 + DSM_4.0 §4.1 + DSM_2.0.C)** — The per-item smoke-test practice (a small, fast check run after each file is built, with the command and result written down) now has a canonical home in DSM. DSM_4.0.A §7 names the artifact, gives it a canonical spoke location (`dsm-docs/guides/smoke-tests.md`, created lazily and appended to as the build progresses), specifies the structure (per-file sections, command/Expected/Result, optional dated log), and distinguishes it from `/verify` and unit tests. It is framed as the industry-standard smoke-test practice (McConnell *Code Complete*; Microsoft daily-build) given a repo home, not a DSM coinage. A pointer sits in DSM_4.0 §4.1 and a soft N/A-able check in the Sprint Boundary Checklist. Origin: traveline-ds-project-skeleton S1, where ~80 lines of validation commands the user ran lived only in transcript context with no place to persist.
- **F-132 (2026-05-31) Collision-safe dated inbox-done filenames (BL-451, DSM_0.2 §17.1 + CLAUDE.md)** — Processed inbox entries now move to `_inbox/done/YYYY-MM-DD_{source}.md` (dated) instead of the bare `_inbox/done/{source}.md`. The bare-name `done/` files are append-only rolling archives; a plain `mv` onto an existing bare name silently overwrites the whole archive. The date prefix makes same-source collisions impossible by construction, so the natural `mv` is safe by default instead of relying on the agent to remember to append. Forward-only: existing bare-name archives are untouched. Origin: S211 self-detected incident where `mv` clobbered a 347-line rolling archive (−323 lines, recovered pre-commit); the exact collision recurred live during S212 boot, validating the fix.
- **F-131 (2026-05-31) /dsm-wrap-up Step 0.5 pre-confirms known cross-repo targets (BL-450, `scripts/commands/dsm-wrap-up.md` + variants)** — Wrap-up writes to several known cross-repo destinations every run (auto-memory MEMORY.md, the `_inbox/` of DSM Central / portfolio / blog-poster / contributions-docs). A new Step 0.5 pre-populates the cross-repo-write confirmation file with these registry-resolved targets before the writing steps, so the BL-391 safety hook no longer interrupts the autonomous flow with a per-target confirmation. Not a gate weakening: targets are precise directory prefixes (not repo roots), the gate still fires for anything outside the known list, and `/dsm-go` Step 0f clears the file at session start. Minimal auto-memory-only variant added to `/dsm-quick-wrap-up` and `/dsm-light-wrap-up`. Origin: blog-poster S22 + DSM Central S210, where the auto-memory write tripped the gate every wrap-up.
- **F-130 (2026-05-31) Transcript replace_all guard (BL-449, DSM_0.2 §7 + `validate-transcript-edit.sh`)** — The session-transcript hook gains a Check 0 that blocks any Edit using `replace_all: true` on `.claude/session-transcript.md`. The transcript's append-only rule assumes a unique last-line anchor; `replace_all` duplicates the new content at every match and explodes the file (one spoke reached 95 MB / 1.5M lines). The block fires before the anchor/append/delimiter checks and names the safe recovery path (a `[RETROACTIVE]` Bash-heredoc append). The prohibition is also documented in §7 anti-patterns and the §17.1 spoke template so spokes inherit it. Origin: two independent spoke incidents (IronCalc S17, blog-poster S22).
- **F-129 (2026-05-31) Cross-repo writes are write-only (BL-448, DSM_0.2.C §2)** — A session writing to a path outside its own repository must limit itself to creating or appending the file; it must NOT run any git operation in the target repo. The target repo owns its git history and commits its own incoming files during its own session. This prevents a foreign session from authoring commits on the target's active branch, bundling the target's staged-but-uncommitted work into a foreign commit, or racing the target's in-flight work in a way the Concurrent-Session Detection Protocol cannot catch (the foreign session bypasses the target's session lock). The rule carries its rationale, not just the prohibition. Origin: S211, where a concurrent session committed on DSM Central's active session branch and swept up Central's staged checkpoint move.
- **F-128 (2026-05-05) Chunked Drafting Protocol for prose deliverables (BL-430, DSM_0.2 §8.10)** — The four-gate Pre-Generation Brief Protocol gains an explicit prose-deliverable shape: Gate 1 confirms purpose / audience / outcome / length / scope, Gate 2 proposes a TOC with per-section length budgets, Gate 3 drafts ONE section at a time with per-section user review and approval before the next, Gate 4 reviews the assembled document for cross-section consistency. Closes the gap §8 left for prose, where the agent's default reading of "produce the artifact at Gate 3" was collapsing to "produce the whole document at Gate 3," yielding 2000-3500 word full-file Write operations that defeated per-section review and the Take a Bite philosophy. Trigger is document type, not length. §17.1 alignment template gains a Pre-Generation Brief Protocol reinforcement bullet so spokes inherit the rule via `/dsm-align`. Origin: haystack-magic S8 R3 hiring challenge produced two structured documents (~2565 + ~3519 words) by full-file Write; the first carried a load-bearing factual error (misattributed deepset 5-Step Guide labels) that escaped into the SUBMITTED deliverable because per-section review never happened.
- **F-127 (2026-05-05) Concurrent-Session Detection Protocol (BL-431, DSM_0.2.A §26)** — A session lockfile at `.claude/session.lock` prevents silent concurrent-session data hazards (interleaved transcripts, conflicting baselines, race conditions on staged changes, MEMORY drift). `/dsm-go` Step 0.7 hard-halts when the lockfile is present, with three resolution options: wrap up the existing session, force-concurrent (crashed-session recovery only), or manual `rm`. The lockfile WRITE happens at end of Step 6 so the `transcript_anchor` field reflects the post-reset state. All three primary wrap-ups (full / light / quick) clear the lockfile in their final step. `/dsm-parallel-session-go` is exempted because parallel sessions are concurrent siblings by design via the commit booking system. Origin: heating-systems-conversational-ai S10.L2 (2026-04-29) where two parallel Claude Code conversations operated the same branch with no awareness, surfacing only when `git status` showed entries the active agent had not authored.
- **F-126 (2026-05-05) Non-Suppressible Prompts Convention (BL-432, DSM_0.2 §8.9.1)** — A prompt classification that auto mode must honor regardless of explicit suspension. §8.9 already established that auto mode does NOT collapse Gate 1 pauses or §19/§21.3 testing requirements; §8.9.1 closes the gap for procedural safety prompts living inside skill files (not inside Gate 1/2/3 cycles). Initial scope: `/dsm-go` Step 0.7 (concurrent-session halt), Step 2a.6 (default-branch verification), Step 5.9 (light-wrap-up continuation, the original motivating site). Skill files carry a `**Non-suppressible (per DSM_0.2 §8.9.1):**` marker line above the prompt. Origin: heating-systems S10.L2 where auto mode silently bypassed Step 5.9's continuation prompt; the agent recognized the prompt's existence in its thinking block, then unilaterally pressed past it. The user was never given the choice §5.9 mandates.
- **F-125 (2026-05-05) Skill Scope Is Authoritative principle (BL-435, DSM_0.2 §8.6.1)** — Sibling sub-section under §8.6 generalizing the lesson BL-434 fixed at the specific Command sync wording level. §8.6 prevents memory-based claims about skill behavior; §8.6.1 prevents augmentation, where the agent invokes a skill correctly, then runs adjacent off-scope checks and folds findings into the skill's report. Core: "Silence from the skill on a concern is the skill's answer." Three handling options for adjacent checks: out-of-band audit with its own distinct label, file a BL to extend the skill's scope, or skip the check. Distinguishes composition (using one skill's output as another's input, allowed) from augmentation (folding off-skill findings into a skill's report, forbidden). Origin: heating-systems S10 where /dsm-align Step 11 was correctly skipped on a spoke and the agent then ran an out-of-scope `diff -q` and folded `Drifted: 2` into /dsm-align's report.
- **F-124 (2026-05-05) /dsm-staa Step 8 regenerate compact reasoning-lessons mirror (BL-433, `scripts/commands/dsm-staa.md`)** — `/dsm-staa` now regenerates `.claude/reasoning-lessons-compact.md` after Step 6 append + Step 7 prune complete. Closes the staleness window between `/dsm-staa` runs and the next `/dsm-wrap-up` (potentially 24+ hours), during which `/dsm-go` Step 1.5 reads a stale boot-time canonical context. The transform implements the same rule `/dsm-wrap-up` Step 0 describes in prose; behaviorally identical output verified by byte-diff against the current compact mirror. The auto-generated comment in the mirror header references both regenerators ("/dsm-wrap-up Step 0 or /dsm-staa Step 8") so provenance is honest. Origin: haystack-magic S7 STAA continuation where /dsm-staa appended 6 [STAA] entries and pruned 2 [auto] entries, leaving the mirror 13 minutes stale and missing 6 lessons.
- **F-123 (2026-05-05) /dsm-align Step 12 conditional `Command sync` spec (BL-434, `scripts/commands/dsm-align.md`)** — Replaces enumerated values with a conditional default for the `Command sync` line in /dsm-align Step 12 report template. Spoke runs (Step 11 skipped) emit `Command sync: N/A (not DSM Central)` verbatim; DSM Central runs (Step 11 ran) emit populated `OK: N | Drifted: N | Missing: N` counts. Closes the "blank field invites invention" failure mode where the agent ran an out-of-scope `diff -q` on user-scope command files and populated the field with fabricated `Drifted: 2`, costing ~115 transcript lines of correction. Origin: heating-systems-conversational-ai S10 (2026-04-23). Sibling fix to F-125 / §8.6.1 which generalizes the lesson.

## April 2026

- **F-122 (2026-04-29) Compact reasoning-lessons mirror for agent-facing session-start priming (BL-427, DSM_0.2.A §8.1)** — A derived `.claude/reasoning-lessons-compact.md` file is regenerated at every `/dsm-wrap-up` Step 0 from the live `.claude/reasoning-lessons.md`, and `/dsm-go` Step 1.5 reads the compact mirror in full instead of peeking at the first 10 lines of the live file. Restores §8 design intent ("the lessons feed the agent's priming at session start") that had been reduced to a category-name peek because the live file grew too large for the context budget. Trim-only format drops the live file's first ~20 guideline lines and the inline `[auto] S{N} [{scope}]:` provenance prefix from each lesson; preserves category headings + lesson body text verbatim. Empirical measurement: ~5% savings on a 113-entry / 51 KB file (lower than the projected 25-30%; entry-verbose files do not gain much from trim-only). Compression beyond trim-only is BL-427 Step 5, deferred behind a controlled-experiment requirement that explicitly forbids using productive sessions as A/B subjects.
- **F-121 (2026-04-29) Research folder index maintenance skills (BL-425, `/dsm-research-add` + `/dsm-research-done`)** — Two new skills bring `dsm-docs/research/` to parity with `dsm-docs/plans/` for index maintenance. `/dsm-research-add` creates a research file with a header stub, validates filename convention and linked-BL existence, and inserts a row into the appropriate sub-table of `dsm-docs/research/README.md` (5 categories: BL-tied / informs-BL / ready-for-promotion / tool-assessment / untracked-carryover). `/dsm-research-done` annotates `Status: Done` + `Date Completed:`, runs `git mv` followed by an explicit `git add` on the destination to handle the BL-370 rename-staging pitfall, and removes the row from the active index. CLAUDE.md gains a "Research Index Maintenance" sub-section flagging drift between folder and README as a §22 protocol violation signal. Closes an asymmetry that had existed since the research folder was created: plans/README was actively maintained by `/dsm-backlog` and `/dsm-backlog-done`, while research/README had been a passive convention document never read for "what's active here." S205 surfaced the gap during a 30-file research triage.
- **F-120 (2026-04-24) Checkpoint Authoring Identifiers Rule (BL-420, DSM_0.2.A §10.2.1)** — Checkpoint entries must use resolvable identifiers (section references, protocol/concept names, session/file references) and must not cite bare BL numbers as identifiers. Forward-only rule with a narrow two-condition exception for checkpoints about in-flight BL implementations. Closes the dead-pointer recurrence path at checkpoint-authoring time: since `/dsm-go` Step 3.5 reads checkpoints across sessions and that reader is often a spoke agent without access to `dsm-docs/plans/`, checkpoint BL numbers previously left the next agent with unresolvable pointers precisely where agents most need working pointers. `/dsm-checkpoint` Step 2.5 surfaces the rule at checkpoint-draft time.
- **F-119 (2026-04-24) BL Lookup Index (BL-419, `dsm-docs/plans/done/INDEX.md`)** — New mirrored governance artifact: a BL-number-indexed lookup of every implemented BL, columns BL# / Title / Version / Date / Resolver (§ or concept). Complements CHANGELOG (chronological) and FEATURES (capabilities) on a third axis, by BL number. Mirrored to TAB so downstream readers of CHANGELOG/FEATURES can resolve BL numbers in one hop. `/dsm-backlog-done` gains Step 8 to keep the INDEX current when BLs move to `done/`. 332 rows at release.
- **F-118 (2026-04-24) Mirrored methodology BL-reference scrub (BL-418)** — One-time cleanup removing ~170 BL-NNN anchors from mirrored methodology (DSM_0-7, `scripts/commands/`, `FEATURES.md` prose, `dsm-docs/guides/`) and replacing them with resolvable identifiers (section references, protocol/concept names, session/file references). Closes the spoke-side dead-pointer problem where mirrored methodology carried filing codes that spoke and mirror readers could not resolve (the plan files themselves live only in Central). Pure reference cleanup, no behavioral change; reads cleaner in spoke context. FEATURES F-entry anchors preserved (Option A) for the F→BL trail, resolvable in one hop via BL-419 Index.
- **F-117 (2026-04-23) Checkpoint step in /dsm-wrap-up (BL-414)** — Full and quick wrap-ups now create a session checkpoint in `dsm-docs/checkpoints/` as part of the parallel block. The checkpoint owns "pending next session" items; MEMORY.md drops that list to free space for global context and strategic vision. Closes a gap open since S177 (2026-04-08) where sessions transitioning from light to full wrap-up stopped producing checkpoints silently. `/dsm-go` Step 3.5 reads the checkpoint at next session start, restoring the continuity signal the gap had erased.
- **F-116 (2026-04-22) /dsm-go context efficiency on version-match sessions (BL-413)** — Three changes reduce `/dsm-go` session-start context consumption by an estimated 40-55% on version-match sessions: unconditional hook chmod at Step 0e (independent of `/dsm-align`), conditional `/dsm-align` at Step 1.8 (skipped when last-align version matches CHANGELOG latest), and inbox lazy-load at Step 2b (filenames only, content deferred to user request). Sonnet DSM sessions become economically sustainable; Opus sessions free context for user work.
- **F-115 (2026-04-20) Gate 1 parallel offload analysis with per-task approval (BL-409, DSM_0.2 §8.8 + DSM_6.0 §1.12)** — New Gate 1 sub-section requiring explicit per-task user approval before any parallel subagent spins. Asymmetric trigger (section present only when offload candidates exist), fail-closed default (silence = REJECTED), subscription-aware (flags cost on non-Max plans), explicit ordering with §8.7 and §8.2.1. DSM_6.0 §1.12 "Don't be a Hero, Delegate the Effort" is the foundational principle. Shifts offload from ad-hoc agent delegation to user-approved orchestration.
- **F-114 (2026-04-20) DSM_7.0 AI Platform Collaboration Guide (BL-345 rollout)** — New top-level DSM document centralizing platform-specific collaboration knowledge, so DSM_0-6 can stay platform-agnostic. Five-phase rollout landed end-to-end: Phase 1 scaffold (BL-345), Phase 2 template research (BL-398), Phase 3 TAB/DSM-exclusive patterns audit (BL-399), Phase 4 §2.1 Claude Code filled instance (BL-400, 11 subsections: Overview, Install/Auth, Core Concepts, Capability Surface, DSM Context, Config, Integration, Security, Troubleshooting, Reference, Production Readiness), Phase 5 §3 template + 9 cross-references (BL-401). DSM_7.0 is the first operational instance of the "Read the User's Manual" principle; future `§2.N` platforms (Ollama, GPT, Copilot) follow the §3.12 "How to Instantiate This Template" 8-step procedure. 759 lines, v0.3.
- **F-113 (2026-04-19) Gate 1 token-minimizing config recommendation (BL-402)** — DSM_0.2 §8.7 adds a per-artifact config recommendation layer inside Gate 1, so mechanical edits and architectural decisions don't both run at the same session baseline. Asymmetric trigger (recommendation appears only when artifact demand clearly diverges from baseline, never as "no change" ritualistic compliance), subscription-aware for Sonnet subagent offload cost, and ordered before §8.2.1 counter-evidence because computational decision precedes content decision. Origin: S195 user question "which config for the parallel sessions?" had no Gate-1-visible protocol to answer from.
- **F-112 (2026-04-13) Read the User's Manual foundational principle (DSM_6.0 §1.11, BL-344)** — New foundational principle making external-tool understanding a prerequisite to collaboration design, not an optional afterthought. Grounds in PMP Procurement (acquire from outside before building with it), relates to §1.3 Earn Your Assertions + §1.5 Know Your Context + §1.9 Think Ahead, and routes through DSM_0.2 §8.6 Skill Self-Reference Protocol for the skill-file-scoped instance. DSM_7.0 §2.1 Claude Code is its first full operational instance. Origin: BL-342 platform-assessment research surfaced the mental-model gap between experiential understanding and docs-grounded understanding.
- **F-111 (2026-04-19) PR-merge-to-main permission parity (BL-387)** — DSM_0.2.C §2 now names `gh pr merge {N} --merge|--squash|--rebase` against a main-base PR as equivalent in publication outcome to `git push origin main`, closing the asymmetry where push required confirmation and PR-merge did not. Confirmation may be batched within a larger work-block approval but must be specific to the merge action. DSM_0.2.C §2.2 adds an opt-in `.claude/settings.json` permission pattern (`Bash(gh pr merge:*)` deny) for security-sensitive projects, with honest When-To-Adopt / When-NOT-To-Adopt criteria. Couples with BL-386 Check B to form a target-verify → action-authorize chain for destructive merges.
- **F-110 (2026-04-19) Default-branch verification at session start and PR create (BL-386)** — `/dsm-go` Step 2a.6 resolves the GitHub-configured default branch via `gh repo view` and hard-halts on mismatch with the local main line (overridable by a `**Main branch:**` declaration in CLAUDE.md). DSM_0.2.C §2.1 documents the companion PR-create discipline: always pass `--base` explicitly on `gh pr create` and verify the resolved base with `gh pr view {N} --json baseRefName` before merging. Frames the rule as Earn Your Assertions extended to command defaults. Origin: dsm-jupyter-book S4 lost ~45 minutes to an HTTP 404 cascade because the repo's default branch was a stale session branch.
- **F-109 (2026-04-19) Pre-Generation Brief Gate 2 counter-evidence surfacing (BL-385)** — DSM_0.2 §8.2.1 now requires agents to surface the strongest counter-evidence to their own recommendation before requesting Gate 2 approval, with a concrete format spec, an anti-pattern guard ("No counter-evidence found" must list sources checked), and §22 as the consequence of skipping. Shifts the burden of critical evaluation from user vigilance to protocol. Origin: heating-systems S5, where two ranking errors needed user pushback to surface counter-evidence that was visible at brief time. S194 demonstrated voluntary application in 4 Gate 1 briefs before codification.
- **F-108 (2026-04-19) `/dsm-backlog` sprint-plan template injection (BL-380)** — `/dsm-backlog` now detects sprint-plan intent (title regex `^Sprint\s+\d+\b` or `--sprint` flag) and injects the 5-section DSM_2.0.C §1 Template 8 scaffold (Research Assessment, Deliverables, Phases, Phase Boundary Checklist, Sprint Boundary Checklist) plus header-block fields. `--no-template` suppresses injection for unconventional sprint titles. Preventive companion to BL-378's detective `/dsm-align` Step 3a audit: the pair covers sprint-plan structure at both creation and closure.
- **F-107 (2026-04-16) Mirror clones ship commands tracked (BL-373 F2)** — Closes the cross-platform bootstrap gap where fresh clones on Windows PowerShell couldn't invoke `/dsm-go` because `sync-commands.sh --deploy` required bash + correct HOME resolution. Mirrors now carry the 13 user-level DSM commands in `.claude/commands/` as tracked files; Claude Code reads project-level commands automatically on first clone with zero bash dependency. Enhanced `scripts/sync-take-ai-bite.sh` with a `source >> target` mapping syntax so Central's `scripts/commands/<cmd>.md` (source of truth) ships to mirror's `.claude/commands/<cmd>.md` (runtime location). Central unchanged — runtime deploy copies stay gitignored, regenerated by `sync-commands.sh --deploy`. Fresh TAB clone on any OS + Claude Code + `/dsm-go` now works end-to-end without a pre-deploy step.
- **F-106 (2026-04-16) Git-mv rename-staging warning hook (BL-370)** — New PreToolUse:Bash hook (`.claude/hooks/validate-rename-staging.sh`) catches the recurring pattern where Edit/sed content changes before `git mv` get silently dropped from the commit because `git mv` does not auto-restage prior content deltas. Three sightings (S184 BL-349, S190 IronCalc inbox move, S191 checkpoint annotation) triggered the BL. Filters to `git commit` calls; blocks with clear bypass instructions when a staged rename has unstaged content at the new path; silent otherwise. Companion to the per-turn transcript hooks (BL-319/324) and installed via the same `/dsm-align` Step 10b mechanism.
- **F-105 (2026-04-16) Cloned-Mirror Kick-off Protocol** — Fresh clones of public DSM mirrors (TAB and any downstream fork) now become functional on first `/dsm-go` with zero user prompts and zero manual scaffolding. `/dsm-go` Step 0.8 detects cloned-mirror state (ecosystem registry absent or lacks self-as-central row) and invokes the 14-step Kick-off from DSM_0.2.A §25: auto-derives `{REPO_ROOT}`, `{project_name}`, `{ISO_DATE}` from `pwd`/`basename`/`date`; copies 5 shipped `.claude/*.template` files (CLAUDE.md, settings.json, dsm-ecosystem.md, reasoning-lessons.md, skills-registry.md) to runtime paths with placeholder substitution; self-registers as `dsm-central` so the clone is its own ecosystem hub; deploys slash commands; chmod's hooks; writes a marker so subsequent sessions skip. Design explicitly refuses personal-content collection (no prompt for author/GitHub/LinkedIn) by symmetry with the existing "no personal-content copy" anti-requirement. Closes PR #36 first-clone findings #1 (incomplete scaffold), #2 (commands not registered), #3 (no `.claude/` ships), #9 (no `.gitignore` ships). T7 verified end-to-end on Windows Claude Code v2.1.39 clone.
- **F-104 (2026-04-13) "We Need to Talk" foundational principle (DSM_6.0 §1.10)** — New principle establishing that the conversation defining work IS the collaboration, not a preamble to it. Gate 0 (DSM_0.2 §8.0) is the operational implementation. The principle names why collaborative definition matters: presenting a pre-formed plan for approval reduces the human from collaborator to approver. Origin: S182 Gate 0 improvisation recognized as the missing entry point to all collaboration.
- **F-103 (2026-04-13) Infrastructure File Collaboration Protocol (DSM_0.2.B §8)** — New protocol for collaboratively modifying skill files, hook scripts, settings.json, and command files. Addresses the Gate 2 auto-approve bypass gap where high-blast-radius infrastructure files were modified without individual diff review. Companion guide defines SKILL.md template with 12 frontmatter fields, line budgets, and commands-to-skills migration path. Origin: S182 incident where 7 auto-approved Edit calls modified dsm-go.md and dsm-align.md without user review.
- **F-102 (2026-04-12) DSM_0.2 §7 authorized exception for `/dsm-staa`** — §7 now names `/dsm-staa` as the sole authorized exception to the unconditional Session Transcript Protocol activation, with a precise meta-recursion rationale and an explicit clarification that the archived subject file and the live reasoning log are two different files on disk (so writes to the live log cannot corrupt the archived subject). The `dsm-staa.md` skill file gains a "Two files, do not confuse them" block that distinguishes the archived subject at `.claude/transcripts/{timestamp}-ST.md` from the live reasoning log at `.claude/session-transcript.md`. Origin: S185 STAA session on S184 where the agent landed on the correct behavior (no transcript write) from a wrong rationale (file corruption), a near-miss that would eventually become a miss. Hook/skill collision in STAA sessions deferred to BL-343.
- **F-101 (2026-04-11) DSM_0.2 §22 stop condition on the current output** — §22 Protocol Violation Triage Response now states explicitly that when a violation is detected, the current output-in-progress is itself a stop condition. The agent must name the violation, halt without completing the output, propose corrective action, and wait for user confirmation before resuming. An anti-pattern clause closes the loophole where a violation could be acknowledged as a footnote while the same output keeps rolling. Cross-referenced to DSM_6.0 Earn Your Assertions. Origin: blog-poster S19 incident, where a mid-paragraph acknowledgment did not actually stop the output and the user had to escalate.
- **F-100 (2026-04-11) `/dsm-align` External Contribution governance scaffold** — `/dsm-align` now detects External Contribution projects and scaffolds their governance folder at `{contributions-docs}/{project-name}/` instead of creating spoke folders in the upstream repo. Detection is two-tier: reads both the Project type and Participation pattern fields in the CLAUDE.md alignment section, or falls back to filesystem signals (upstream project markers + absence of `dsm-docs/`) with a user confirmation gate. Cross-repo writes to the governance folder are gated by an explicit confirmation on first scaffold. Closes the gap where external repos either had no governance scaffolding or risked the BL-114 failure mode (accidental `dsm-docs/` creation in an upstream repo). Idempotent: subsequent runs pass through without re-prompting.
- **F-099 (2026-04-10) Minimal troubleshooting boot with /dsm-safe-go** — Zero-dependency, read-only session entry point for diagnosing problems when the normal boot chain is broken. Transcript append is best-effort. No side effects. The escape hatch that makes infrastructure changes safer to ship.
- **F-098 (2026-04-10) Gate 0 Collaborative Definition Protocol** — New gate in the Pre-Generation Brief that governs the collaborative dialog before any artifact is conceived. Three steps (confirm threads, analyze dependencies, package into units), each requiring explicit confirmation. Ensures the human shapes the work structure, not just approves it.
- **F-097 (2026-04-09) Unconditional /dsm-align on every /dsm-go** — `/dsm-go` Step 1.8 now invokes `/dsm-align` on every session start, no marker checks, no version gates, no confirmation. Replaces brittle conditional logic that allowed alignment drift to persist between sessions. Eliminates four distinct failure modes hit during DSM Central S180 (hook scripts at index mode 644, stale marker files, Claude Code window cache, scaffold drift). `/dsm-light-go` remains the explicit lightweight escape hatch for context-pressure continuation sessions.
- **F-096 (2026-04-09) Per-turn transcript hook delivery to spokes** — `/dsm-align` now installs the per-turn transcript hook and the append-only edit validator into each spoke's `.claude/hooks/` and wires them into `.claude/settings.json`. Before this, DSM_0.2 §7 had the rules on paper and nothing enforcing them. Two sessions on the same day paid the cost: portfolio S69 ran six turns without a single transcript append, and blog-poster S17 produced one entry in the whole session.
- **F-095 (2026-04-07) Process narration in transcript thinking blocks** — Thinking blocks now narrate reasoning as it unfolds (loops, doubts, reversals, considered-and-rejected paths) instead of presenting clean post-hoc summaries. The user can now see inefficiency patterns in the agent's reasoning that were previously hidden by curated summaries, enabling reasoning-efficiency analysis.
- **F-094 (2026-04-07) Per-turn transcript append enforcement** — Every turn now triggers a `UserPromptSubmit` hook reminder that forces the agent to append a thinking block to the session transcript before doing any work. Closes the failure mode where the agent silently skipped reasoning logs across multiple consecutive turns despite static doc rules requiring them.
  - **Functional from:** v1.4.13 (after S180 BL-319 follow-up). The hook scripts were stored in the git index at mode `100644`. `core.fileMode = false` on WSL hid the divergence, so every fresh clone of any DSM project got non-executable hooks and the per-turn reminder hook silently failed end-to-end. Resolved via `git update-index --chmod=+x`, `/dsm-align` hub fast-path step 10b inclusion, and step 10b sub-step b re-applying `chmod +x` on every run including byte-identical destinations. See v1.4.13 CHANGELOG entry for the full root-cause chain.
- **F-093 (2026-04-07) Python virtual environment protocol** — Projects with Python code now require `.venv` creation and activation before any `pip install`. Closes a gap where agents could pollute system Python with project dependencies, hiding version conflicts and breaking reproducibility across machines.
- **F-092 (2026-04-07) Runtime register context for register-sensitive skills** — Skills that depend on audience and formality assumptions now receive an explicit runtime context block (audience, formality, domain, constraints) before invocation. Closes a gap where the skill rewrote an academic deliverable into informal register because nothing told it the target reader.
- **F-091 (2026-04-07) Planning pipeline gate in alignment template** — Spoke agents now see an explicit reinforcement that only `dsm-docs/plans/` items are actionable; material in `_reference/`, `docs/`, README, or sprint plan drafts is input to the planning pipeline, not a substitute for it. Closes a gap where agents conflated "understanding scope" with "adopting the plan."
- **F-090 (2026-04-06) Sprint Retrospective Intelligence at sprint boundaries** — At sprint boundaries the agent synthesizes operational data across 6 dimensions (themes, principles, evolution, collaboration, learning, maturity), turning mechanical counts into strategic analysis that informs the next sprint.
- **F-089 (2026-04-06) Cross-repo write safety in alignment template** — Spoke agents now see an explicit reinforcement that cross-repo writes require user confirmation, closing a gap where the rule existed in Module C but was invisible to spoke agents through the template.
- **F-088 (2026-04-06) Wrap-up type marker for session-start guidance** — Each wrap-up variant records its type (full/light/quick). The next session detects mismatches and suggests the appropriate startup command, preventing wasted overhead or skipped checks.
- **F-087 (2026-04-06) Factual accuracy in Code Output Standards** — The alignment template now instructs agents to state uncertainty rather than guess or fabricate, operationalizing DSM_6.0's Earn Your Assertions principle across all spoke projects.
- **F-086 (2026-04-05) Sprint plan cross-reference before completion** — Before suggesting wrap-up, the agent re-reads the sprint plan and checks each deliverable against actual evidence. No more "sprint complete" when experiment gates are unmet or SHOULD items are still open.
- **F-085 (2026-04-05) Figure validation in notebook collaboration** — Cells that generate plots now save figures to disk so the agent can read the image back. The agent actually sees what it drew before moving on.

## March 2026

- **F-084 (2026-03-20) Incomplete wrap-up recovery** — When a session ends
  unexpectedly, the next session detects the gap and offers to reconstruct
  the missing summary and reasoning lessons from the archived transcript,
  plus suggests any remaining actions.

- **F-083 (2026-03-19) Two-Pass Reading Strategy** — Long structured files
  are read in two passes: first a structural scan to build a skeleton, then
  targeted reads of relevant sections. Reduces context waste on large documents.

- **F-082 (2026-03-19) Web Research Capture Protocol** — When web research
  feeds into a deliverable, raw findings are saved with source URLs before
  synthesis, ensuring every claim is traceable.

- **F-081 (2026-03-16) Session configuration recommendation** — Each session
  receives a tailored model/effort/thinking configuration based on the planned
  work scope and the user's subscription limits.

- **F-080 (2026-03-16) Strategic roadmap with GitHub Projects** — A three-layer
  planning system: strategic roadmap document, GitHub Projects board for
  operational tracking, and individual backlog files as source of truth.

- **F-079 (2026-03-16) Phase-gated work** — Backlog items are assigned to
  strategic phases with dependencies. Phase progression is based on completing
  high-priority items before moving to the next phase.

- **F-078 (2026-03-16) Backlog Naming Rule** — Every backlog item title must
  be self-explanatory. If scanning the list requires opening files to understand
  what items do, the titles are renamed.

- **F-077 (2026-03-16) Consolidation branch retention** — Remote branches for
  backlog consolidations are kept until all referenced items are resolved,
  preventing premature cleanup.

- **F-076 (2026-03-15) Backlog Scope Rule** — Each backlog item must address
  a single, independently completable topic. Multi-topic items are split before
  implementation.

- **F-075 (2026-03-15) Mirror repo sync** — Methodology files are automatically
  copied to public distribution repos after changes, keeping them current
  without manual intervention.

- **F-074 (2026-03-15) Branch testing requirement** — Feature branches must be
  tested before merging. No exceptions. Each backlog item includes a specific
  test plan checked off before merge.

- **F-073 (2026-03-15) DSM modularization** — The custom instructions are split
  into a core file plus four on-demand modules, reducing context consumption
  by 78% for tasks that only need specific protocols.

- **F-072 (2026-03-14) Feature branch workflow** — Backlog implementations use
  dedicated branches with naming conventions, test-before-merge policy, and
  automatic cleanup after merge.

- **F-071 (2026-03-14) Situational Assessment (Step 0)** — A pre-methodology
  assessment for new projects: project type, constraints, team composition,
  and prior art review before applying any framework.

- **F-070 (2026-03-14) Scale-Aware Planning** — A research gate that adjusts
  methodology scope based on project scale, preventing over-engineering small
  projects or under-planning large ones.

- **F-069 (2026-03-14) Notebook Cell Output Validation** — Before generating
  the next notebook cell, the actual output of the previous cell is verified,
  preventing cascading errors from assumed results.

- **F-068 (2026-03-14) Session Delivery Budget** — Work volume is estimated
  at session start to prevent overcommitment. Mid-session checks flag when
  planned work exceeds remaining capacity.

- **F-067 (2026-03-13) Stress Testing** — Controlled experiments comparing
  methodology-guided vs unguided AI collaboration, measuring the actual impact
  of structured protocols on output quality.

- **F-066 (2026-03-12) Critical Thinking principle** — The agent must challenge
  assertions, verify claims, and distinguish evidence from assumption rather
  than accepting inputs at face value.

- **F-065 (2026-03-12) DSM acronym disambiguation** — Public-facing content
  uses "Take-AI-Bite's DSM" to avoid confusion with other frameworks sharing
  the DSM abbreviation.

- **F-064 (2026-03-11) 7-Element Experiment Framework** — Structured template
  for capability experiments: question, hypothesis, method, measurement,
  result, interpretation, next steps.

- **F-063 (2026-03-10) External DSM Descriptions** — Canonical short, medium,
  and full descriptions for use in public-facing contexts, ensuring consistent
  messaging across platforms.

- **F-062 (2026-03-10) Communication Channel Framework** — Taxonomy of
  communication channels (blog, portfolio, inbox, social) with audience mapping
  and content guidelines for each.

- **F-061 (2026-03-10) Participation patterns** — Three project patterns
  (Standard Spoke, External Contribution, Private Project) with different
  isolation rules for communication, feedback, and cross-repo writes.

- **F-060 (2026-03-09) Alignment command** — A validation command that checks
  configuration references, ecosystem pointers, and directory structure
  compliance across the project.

- **F-059 (2026-03-07) Public brand (Take AI Bite)** — A public-facing identity
  separate from the internal governance name, allowing the methodology to
  communicate value without exposing implementation details.

- **F-058 (2026-03-05) Communication Channel Framework** — Taxonomy of
  communication channels with audience mapping for structured outreach.

- **F-057 (2026-03-05) Research Re-Validation Gate** — Expiry check on research
  findings before implementation: if research is older than a threshold, it
  must be re-validated before being used as a basis for decisions.

- **F-056 (2026-03-04) Inbox done/ lifecycle** — Processed inbox entries are
  moved (not deleted or marked in place), preserving the full communication
  history while keeping the active inbox clean.

- **F-055 (2026-03-02) Per-session feedback files** — Each session generates
  separate feedback files for methodology observations and backlog proposals,
  with a done/ lifecycle for processed entries.

- **F-054 (2026-03-02) Spoke-to-hub feedback push** — At session end, feedback
  files are automatically pushed to the central repository's inbox, closing
  the learning loop between projects.

- **F-053 (2026-03-02) Lightweight session mode** — Minimal context loading
  for continuation sessions where the task is already known. Preserves the
  transcript across sessions for unbroken reasoning chains.

- **F-052 (2026-03-02) Session baseline snapshot** — Git state is saved at
  session start so that wrap-up can identify exactly which changes belong to
  the current session.

- **F-051 (2026-03-01) Spoke initialization checklist** — Standard scaffold
  for new projects: directory structure, configuration files, and gitignore
  patterns created from a template.

- **F-050 (2026-02-27) Session Transcript reasoning extraction** — Reasoning
  patterns are extracted from session transcripts via dedicated analysis,
  turning one session's insights into reusable guidance for future sessions.

- **F-049 (2026-02-27) Blog seeds** — Draft blog entries with date-prefixed
  naming are collected during regular work, building a content pipeline without
  dedicated writing sessions.

- **F-048 (2026-02-25) Pre-Generation Brief (three gates)** — Before creating
  any artifact: concept approval (explain what and why), implementation
  approval (review the diff), run approval (when executing). Each gate is
  an explicit stop requiring user confirmation.

- **F-047 (2026-02-25) Composition Challenge Protocol** — When producing a
  collection of multiple discrete items, special handling ensures each item
  gets individual attention rather than being batch-generated.

- **F-046 (2026-02-25) Edit Explanation Stop** — Multiple distinct edits to a
  single file require individual explanations, preventing opaque bulk changes.

- **F-045 (2026-02-19) Reasoning Lessons** — Promoted reasoning patterns from
  transcript analysis become formal protocol guidance, accumulating
  institutional knowledge across sessions.

- **F-044 (2026-02-19) Phase 0.5: Research and Grounding** — A formal research
  phase before implementation for novel domains: survey existing work, identify
  gaps, validate approach before writing code.

- **F-043 (2026-02-19) Technical Progress Reporting** — Structured reporting
  at sprint boundaries captures engineering work in a format suitable for
  stakeholder communication.

- **F-042 (2026-02-18) Secret Exposure Prevention** — Files matching sensitive
  patterns (.env, *.key, credentials.*) are automatically refused when staging
  for commits, requiring explicit user override.

- **F-041 (2026-02-18) Untrusted Input Protocol** — Sanitization rules for
  processing inbox entries, tool outputs, and web results, preventing prompt
  injection or data corruption from external sources.

- **F-040 (2026-02-18) Query Sanitization** — Rules for constructing web search
  queries and API requests to prevent information leakage or injection.

- **F-039 (2026-02-18) README Change Notification** — When any project's README
  changes, an automated inbox notification is sent to the portfolio and central
  repository for tracking.

- **F-038 (2026-02-17) Ecosystem Path Registry** — Cross-repo paths are declared
  in a local configuration file with logical names, validated at session start.
  Eliminates hardcoded filesystem paths from methodology documents.

- **F-037 (2026-02-15) Context Budget Protocol** — The context window is treated
  as a finite resource with explicit management: warnings at 40% remaining,
  options presented before reading large files.

- **F-036 (2026-02-14) Take a Bite delivery principle** — Deliver only what the
  reviewer can engage with and respond to with substance. The core test for
  whether an artifact is the right size.

- **F-035 (2026-02-14) Earn Your Assertions** — Every factual claim must be
  independently verified before presenting. No hedging as a substitute for
  checking.

- **F-034 (2026-02-14) External source feedback** — Observations from external
  tools, research, or incidents automatically generate backlog items, capturing
  improvement opportunities from outside the methodology.

- **F-033 (2026-02-11) Transcript as reasoning channel** — The session transcript
  file is the primary output for agent reasoning. Conversation text carries
  only results, summaries, and questions, never reasoning.

- **F-032 (2026-02-10) Capability experiments** — Numbered experiments with
  hypothesis, method, result, and decision. Reproducibility is mandatory:
  each experiment has an executable script.

- **F-031 (2026-02-08) Destructive Command Protocol** — A named list of commands
  that are never auto-approved (force push, hard reset, recursive delete).
  Each requires explicit user request and explanation.

- **F-030 (2026-02-08) Research documents** — Dedicated research directory with
  date-prefixed files and a done/ lifecycle for consumed research. Raw findings
  are preserved alongside synthesized deliverables.

- **F-029 (2026-02-08) Session start protocol** — Multi-step initialization at
  every session: project type detection, inbox check, version comparison,
  ecosystem validation, transcript setup, and baseline snapshot.

- **F-028 (2026-02-07) Session wrap-up checklist** — Structured end-of-session:
  memory update, backup, contributor profile check, commit, push, and handoff
  document if complex work is pending.

- **F-027 (2026-02-07) MEMORY.md** — Persistent file-based memory across
  conversations, indexed with typed files (user, feedback, project, reference).
  Survives context window resets and session boundaries.

- **F-026 (2026-02-07) External Contribution Pattern** — Governance artifacts
  for external projects are stored separately from the upstream repo. The
  external repo receives only code contributions, never methodology files.

- **F-025 (2026-02-07) .git/info/exclude** — Agent configuration files are
  excluded from commits without polluting the project's .gitignore, using
  git's local exclude mechanism.

- **F-024 (2026-02-06) Hub-spoke architecture** — A central governance
  repository with spoke projects that inherit protocols via configuration
  references. Changes propagate automatically to all projects.

- **F-023 (2026-02-06) Project type detection** — At session start, the project
  type is automatically identified (Notebook, Application, Hybrid,
  Documentation, External Contribution) and the appropriate methodology track
  is activated.

- **F-022 (2026-02-06) CLAUDE.md** — Project-specific instructions loaded at
  every session, with reference chaining for inherited protocols. Each project
  can override or extend the base methodology.

- **F-021 (2026-02-06) Gitignored working folders** — The .claude/ directory
  is gitignored in all projects: session transcripts, baselines, and ecosystem
  paths are never committed to the repository.

- **F-020 (2026-02-06) Backlog classification** — Backlog items are classified
  as developments (external projects) or improvements (internal enhancements),
  keeping project definitions separate from methodology changes.

- **F-019 (2026-02-06) Checkpoints** — Milestone snapshots with detailed
  internal context: rationale, session state, next steps. Different from the
  changelog (what changed) — checkpoints capture what was happening.

- **F-018 (2026-02-06) Inbox system** — Inbox directories for hub-spoke
  notification routing. Entries arrive, get processed, and move to done/.
  The inbox is a transit point, not a storage system.

- **F-017 (2026-02-06) Commit message conventions** — Descriptive messages
  referencing backlog item numbers, committed immediately after each
  implementation. No batching multiple items into one commit.

- **F-016 (2026-02-06) Governance isolation** — A dedicated storage repository
  separates governance artifacts from upstream repos. External repos receive
  only code contributions, never methodology files.

- **F-015 (2026-02-04) Epoch structure** — Multi-sprint grouping for larger
  project arcs, providing a higher-level planning horizon above individual
  sprints.

- **F-014 (2026-02-01) Design decisions** — Numbered decision records
  documenting architectural choices with rationale, alternatives considered,
  and consequences accepted.

- **F-013 (2026-02-01) Graph Explorer feedback volume** — A single spoke
  project generated 42 backlog proposals and 53 methodology observations,
  demonstrating the feedback system's capacity at scale.

## February 2026 (continued above)

## January 2026

- **F-012 (2026-01-30) Inter-project feedback** — Spoke projects generate
  backlog proposals and methodology observations for the central repository,
  creating a systematic learning loop across the ecosystem.

- **F-011 (2026-01-26) Backlog system** — Numbered backlog items with markdown
  files as source of truth and a done/ lifecycle. Three-layer tracking:
  strategic roadmap, operational board, and individual files.

- **F-010 (2026-01-22) Semantic versioning** — Content releases follow
  semantic versioning (vX.Y.Z) with consistency tags for post-release cleanup.

- **F-009 (2026-01-22) Version Update Workflow** — A 9-step process from
  change to release: update methodology, changelog, readme, commit, tag,
  push, and sync to mirror repos.

- **F-008 (2026-01-22) CHANGELOG** — A public record of what changed in each
  version, following the Keep a Changelog format with categorized sections.

- **F-007 (2026-01-22) Git tags** — Release tags for content versions and
  checkpoint tags for post-release cleanup, marking recovery points in the
  project history.

- **F-006 (2026-01-08) App Development Protocol** — Step-by-step guided
  development for application code: explain why before each action, create
  files via tools, user approves via the permission window before proceeding.

## December 2025

- **F-005 (2025-12-23) Inclusive language** — Prohibited patterns for
  violence-implying, gendered, political, religious, and superiority-implying
  language. Proper diacritical marks required for non-English text.

- **F-004 (2025-12-23) Handoffs** — Session-end resumption documents consumed
  by the next session start, ensuring complex pending work is not lost between
  sessions.

- **F-003 (2025-12-14) Sprint cadence** — Time-boxed work periods with boundary
  checklists and feedback windows, providing rhythm and review points for
  ongoing work.

- **F-002 (2025-12-14) Code Output Standards** — Print actual values (shapes,
  metrics, counts), not generic confirmations. Let results speak for themselves.

- **F-001 (2025-12-14) File naming standards** — Date-prefixed research, blog,
  and checkpoint files with documented naming conventions for consistency
  across all projects.

## November 2025

- **F-000 (2025-11-13) Notebook Collaboration Protocol** — One cell at a time;
  wait for actual output before generating the next cell. Each cell adapts
  based on real results, not assumptions.

---

*This timeline is maintained as features are added. For the internal
development record with implementation details, see the
[Feature Inventory](dsm-docs/research/2026-03-16_dsm-feature-inventory.md).*
