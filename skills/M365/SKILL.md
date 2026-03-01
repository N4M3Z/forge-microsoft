---
name: M365
version: 0.1.0
description: Microsoft 365 operations via m365 CLI — Outlook email, Teams, SharePoint. USE WHEN email, outlook, send email, teams, sharepoint, m365, microsoft.
---

# M365

Microsoft 365 operations via `m365` CLI.

## Services

| Service | File | Description |
|---------|------|-------------|
| Outlook | `Outlook.md` | Email operations — list, read, move, compose, attachments |

## Setup

### Read conventions

```bash
MODULE="Modules/forge-microsoft"
[ -d "$MODULE" ] || MODULE="."
cat $MODULE/CONVENTIONS.md
```

### Check connection

```bash
m365 status
```

If not connected, re-authenticate per CONVENTIONS.md auth flow.

## Constraints

- Never send email without explicit user confirmation
- Email content is AMBER — do not persist email bodies in the vault
- Follow m365 CLI gotchas in CONVENTIONS.md (lowercase `--method`, rate limiting, page size)

When the user asks for an M365 operation, read the matching service file and follow its instructions.
