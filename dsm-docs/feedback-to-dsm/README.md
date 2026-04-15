# DSM Feedback

Per-session feedback files with a lifecycle. Each session creates its own
file(s); processed files move to `done/`.

## File Types

| File pattern | Content | Lifecycle |
|-------------|---------|-----------|
| `YYYY-MM-DD_sN_backlogs.md` | Backlog proposals for DSM | Per-session -> done/ |
| `YYYY-MM-DD_sN_methodology.md` | Methodology effectiveness scores | Per-session -> done/ |
| `technical.md` | Technical progress reports | Append-only + Pushed marker |

## Lifecycle

1. **Create:** Agent writes feedback during session
2. **Notify:** At wrap-up, inbox notification to DSM Central references the file
3. **Process:** DSM Central reads and acts on the feedback
4. **Done:** Processed file moves to `done/`

Only create a file when there is feedback to record. No empty files.
Reference: DSM_0.2 DSM Feedback Tracking.
