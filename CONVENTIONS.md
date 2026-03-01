# Microsoft 365 Conventions

Shared reference for all m365 skills. Read this file at the start of every skill invocation.

## m365 CLI Authentication

Environment variables (configured in `.env`, gitignored):

```bash
M365_APP_ID=<your-azure-app-id>
M365_TENANT_ID=<your-tenant-id>
M365_EMAIL=<your-email>
```

Check connection and re-authenticate if needed:

```bash
m365 status
m365 login --appId $M365_APP_ID --authType deviceCode
```

## m365 CLI Gotchas

Confirmed runtime limitations. Follow exactly — ignoring them causes silent failures.

| Gotcha | Impact | Fix |
|--------|--------|-----|
| `--method` requires **lowercase** | `GET`/`PATCH` rejected with "not a valid value" | Always use `get`, `patch`, `post`, `delete` |
| Rate limiting on bulk reads | `--output json --query` returns empty `[]` silently | Add 1-2s sleep between API calls; for >20 emails, batch in groups of 10 |
| No `m365 outlook message attachment` subcommand | Cannot list/download attachments via built-in commands | Use `m365 request` against Graph API directly |
| `message get` with null body | Attachment-only emails have `body.content: null` | Handle null/empty body gracefully |
| `message list` page size | Default returns max ~50 emails per call | For large inboxes, use `--top N` or paginate |

## Effort Tags

| Tag | Duration | Hours |
|-----|----------|-------|
| `#log/effort/short` | ~30 minutes | 0.5h |
| `#log/effort/mid` | ~1 hour | 1h |
| `#log/effort/long` | ~90 minutes | 1.5h |
| `#log/effort/extended` | 2+ hours | 2h |

## Entry Format

```
- [#] #log/effort/<level> #log/highlight [[Project]] — concise description
```

One-liner per effort block. Sub-bullets belong in the project work log, not the daily journal.

## Highlight Detection

Read `Goals.md` via `safe-read`. If entry entities (projects, people, topics) match an active goal, add `#log/highlight`.

## AMBER File Handling

- **Read**: Use `safe-read` via Bash (configured in `defaults.yaml` under `commands.safe_read`, overridable in `config.yaml`)
- **Write**: Use the Write tool, never Edit (Obsidian Linter reformats frontmatter between reads, causing staleness errors)
- **Never** output verbatim AMBER content to the user

## Wikilinks

Link liberally: people, projects, organizations, topics, locations.
Use name as-given for people (Contacts are RED — cannot look up full names).

## Task Statuses

| Marker | Meaning | When to use |
|--------|---------|-------------|
| `[ ]` | Open | Not started |
| `[x]` | Done | Completed, with `[completion:: YYYY-MM-DD]` |
| `[-]` | Cancelled | Skipped or no longer relevant, with `[cancelled:: YYYY-MM-DD]` |
| `[/]` | In progress | Started but not finished today — carries forward |
| `[#]` | Info / tag-only | Non-task item (effort entries, habit groups) |
| `[!]` | Flagged | Needs attention — overdue, blocked, or urgent |

## Backlog Format

Obsidian Tasks: `- [ ] Description [priority:: level] [due:: YYYY-MM-DD]`
Group under `## High`, `## Medium`, `## Low` headings.

## Invariants

| Rule | Reason |
|------|--------|
| Never write journal without user confirmation | Prevents silent data corruption |
| Use `safe-read` for all AMBER files | TLP compliance |
| Use Write tool, not Edit, for journal files | Obsidian Linter compatibility |
| Wikilink people, projects, orgs, locations | Obsidian graph connectivity |
| One-liner per effort block in daily log | Detail goes in project work log |
