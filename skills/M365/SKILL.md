---
name: M365
version: 0.1.0
description: Microsoft 365 operations via m365 CLI — Outlook email, Todo tasks, Calendar events, Teams chat. USE WHEN email, outlook, send email, todo, tasks, calendar, events, meeting, teams, chat, channel, m365, microsoft.
---

# M365

Microsoft 365 operations via `m365` CLI.

## Usage

| Service  | File          | Description                                              |
|----------|---------------|----------------------------------------------------------|
| Outlook  | `Outlook.md`  | Email operations — list, read, move, compose, attachments |
| Todo     | `Todo.md`     | Task management — lists, tasks, CRUD operations           |
| Calendar | `Calendar.md` | Calendar events — list, create, update, cancel via Graph  |
| Teams    | `Teams.md`    | Channels and chat — list, read, send messages             |

## Setup

### Check connection

```bash
m365 status
```

If not connected, re-authenticate per `rules/AuthM365.md`.

## Constraints

- Never send email or Teams messages without explicit user confirmation
- Never create or cancel calendar events without explicit user confirmation
- Email and calendar content is AMBER — do not persist bodies in the vault
- Follow m365 CLI pitfalls in `rules/PitfallsM365.md` (lowercase `--method`, rate limiting, page size)

When the user asks for an M365 operation, read the matching service file and follow its instructions.
