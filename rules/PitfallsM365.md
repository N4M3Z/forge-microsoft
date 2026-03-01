Confirmed runtime limitations of the `m365` CLI. Follow exactly — ignoring them causes silent failures.

| Gotcha                                        | Impact                                                         | Fix                                                              |
|-----------------------------------------------|----------------------------------------------------------------|------------------------------------------------------------------|
| `--method` requires **lowercase**             | `GET`/`PATCH` rejected with "not a valid value"                | Always use `get`, `patch`, `post`, `delete`                      |
| Rate limiting on bulk reads                   | `--output json --query` returns empty `[]` silently            | Add 1-2s sleep between calls; batch >20 items in groups of 10    |
| No `m365 outlook message attachment` command  | Cannot list/download attachments via built-in commands          | Use `m365 request` against Graph API directly                    |
| `message get` with null body                  | Attachment-only emails have `body.content: null`               | Handle null/empty body gracefully                                |
| `message list` page size                      | Default returns max ~50 emails per call                        | Use `--top N` or paginate for large inboxes                      |
| `--dueDateTime` ignores time                  | Todo tasks store date-only, time portion discarded             | Use `YYYY-MM-DD` format, not full ISO timestamp                  |
| `calendarView` requires both bounds           | Missing `startDateTime` or `endDateTime` returns 400           | Always provide both in ISO 8601 format                           |
| Updating meeting body corrupts join blob      | PATCH on `body` of online meeting events breaks Teams link     | Skip body updates on events with `onlineMeeting`                 |
| `--userEmails` auto-creates chat              | `teams chat message send --userEmails` creates new chat        | Warn user before first use with new recipients                   |
| Team membership required for channel messages | Non-members get 403 on `teams message list`                    | Verify with `teams team list --joined` first                     |
