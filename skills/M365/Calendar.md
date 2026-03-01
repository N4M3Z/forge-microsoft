# Calendar

Calendar operations via Graph API (`m365 request`). The `@graph` shorthand expands to `https://graph.microsoft.com/v1.0`.

## List events

```bash
m365 request --url "@graph/me/calendarView?startDateTime=<start>&endDateTime=<end>" \
    --method get --output json
```

Both `startDateTime` and `endDateTime` are required (ISO 8601: `YYYY-MM-DDT00:00:00Z`). Uses `calendarView` which expands recurring events into individual instances.

Present as a chronological list with time, subject, and location.

## Get event detail

```bash
m365 request --url "@graph/me/events/<event-id>" \
    --method get --output json
```

## Create event

```bash
m365 request --method post --url "@graph/me/calendar/events" \
    --content-type "application/json" \
    --body '{"subject":"<subject>","start":{"dateTime":"<YYYY-MM-DDTHH:MM:SS>","timeZone":"<tz>"},"end":{"dateTime":"<YYYY-MM-DDTHH:MM:SS>","timeZone":"<tz>"}}'
```

Always include `timeZone` — omitting it defaults to UTC. Confirm with the user before creating.

## Update event

```bash
m365 request --method patch --url "@graph/me/events/<event-id>" \
    --content-type "application/json" \
    --body '{"subject":"<new-subject>"}'
```

Only include fields being changed. Do not update `body` on events with online meetings — it corrupts the Teams join blob.

## Cancel event

```bash
m365 request --method delete --url "@graph/me/events/<event-id>"
```

Returns 204 on success. If the event is a meeting, cancellation notifications are sent to attendees. Confirm with the user before cancelling.
