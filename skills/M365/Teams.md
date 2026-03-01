# Teams

Teams channels and chat via `m365` CLI.

## List joined teams

```bash
m365 teams team list --joined --output json \
    --query "[].{id:id,name:displayName,description:description}"
```

## List channels

```bash
m365 teams channel list --teamName "<team-name>" --output json \
    --query "[].{id:id,name:displayName,type:membershipType}"
```

## List channel messages

```bash
m365 teams message list --teamId "<team-id>" --channelId "<channel-id>" --output json
```

Must be a member of the team. Use `--since YYYY-MM-DDTHH:MM:SSZ` to filter recent messages.

## Send channel message

```bash
m365 teams message send --teamId "<team-id>" --channelId "<channel-id>" \
    --message "<message>"
```

Confirm with the user before sending.

## List chats

```bash
m365 teams chat list --output json
```

Optional: `--type oneOnOne|group|meeting` to filter by chat type.

## List chat messages

```bash
m365 teams chat message list --chatId "<chat-id>" --output json
```

## Send chat message

```bash
m365 teams chat message send --chatId "<chat-id>" --message "<message>"
```

Also supports `--userEmails "<email>"` (auto-creates a new chat if none exists) and `--chatName "<name>"`. Confirm with the user before sending.
