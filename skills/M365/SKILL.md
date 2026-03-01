---
name: M365
version: 0.1.0
description: Microsoft 365 operations via m365 CLI — Outlook email, Teams, SharePoint. USE WHEN email, outlook, send email, teams, sharepoint, m365, microsoft.
---

# M365

Microsoft 365 operations via `m365` CLI.

## Arguments

- No args → show connection status
- `outlook` → email operations (list, read, move, compose)
- `outlook list` → list recent inbox messages
- `outlook read <id>` → read a specific message
- `outlook compose` → draft and send an email

## Instructions

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

## Outlook

### List messages

```bash
m365 outlook message list --folderName inbox --output json \
  --query "[].{id:id,subject:subject,from:from.emailAddress.name,received:receivedDateTime,read:isRead,flagged:flag.flagStatus}"
```

Present as a numbered list with status indicators.

### Read message

```bash
m365 outlook message get --id "<id>" --output json \
  --query "{subject:subject,body:body.content,from:from.emailAddress,to:toRecipients,received:receivedDateTime}"
```

Handle null body gracefully (attachment-only emails).

### Move message

```bash
m365 outlook message move --id "<id>" --sourceFolderName inbox --targetFolderName archive
```

### Flag / unflag

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>" \
  --method patch --body '{"flag":{"flagStatus":"notFlagged"}}' --content-type "application/json"
```

### Compose and send

Draft the email, confirm with the user, then send:

```bash
m365 outlook message send --subject "<subject>" --to "<email>" --bodyContents "<body>" --bodyContentType Text
```

### Attachments

List via Graph API (no built-in subcommand):

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>/attachments?\$select=id,name,isInline,size,contentType" --method get
```

Filter out `isInline: true` (signature images). Download non-inline:

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>/attachments/<att-id>" --method get --output json
```

Decode `contentBytes` (base64) and write to target directory.

## Constraints

- Never send email without explicit user confirmation
- Email content is AMBER — do not persist email bodies in the vault
- Follow m365 CLI gotchas in CONVENTIONS.md (lowercase `--method`, rate limiting, page size)
