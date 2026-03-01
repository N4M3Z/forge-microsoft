# Outlook

Email operations via `m365` CLI.

## List messages

```bash
m365 outlook message list --folderName inbox --output json \
  --query "[].{id:id,subject:subject,from:from.emailAddress.name,received:receivedDateTime,read:isRead,flagged:flag.flagStatus}"
```

Present as a numbered list with status indicators.

## Read message

```bash
m365 outlook message get --id "<id>" --output json \
  --query "{subject:subject,body:body.content,from:from.emailAddress,to:toRecipients,received:receivedDateTime}"
```

Handle null body gracefully (attachment-only emails).

## Move message

```bash
m365 outlook message move --id "<id>" --sourceFolderName inbox --targetFolderName archive
```

## Flag / unflag

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>" \
  --method patch --body '{"flag":{"flagStatus":"notFlagged"}}' --content-type "application/json"
```

## Compose and send

Draft the email, confirm with the user, then send:

```bash
m365 outlook message send --subject "<subject>" --to "<email>" --bodyContents "<body>" --bodyContentType Text
```

## Attachments

List via Graph API (no built-in subcommand):

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>/attachments?\$select=id,name,isInline,size,contentType" --method get
```

Filter out `isInline: true` (signature images). Download non-inline:

```bash
m365 request --url "https://graph.microsoft.com/v1.0/me/messages/<id>/attachments/<att-id>" --method get --output json
```

Decode `contentBytes` (base64) and write to target directory.
