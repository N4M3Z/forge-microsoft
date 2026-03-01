# Todo

Microsoft To Do task management via `m365` CLI.

## List task lists

```bash
m365 todo list list --output json \
    --query "[].{id:id,name:displayName}"
```

## List tasks

```bash
m365 todo task list --listName "<list-name>" --output json \
    --query "[].{id:id,title:title,status:status,importance:importance,due:dueDateTime.dateTime}"
```

Present as a numbered list with status and importance indicators.

## Create task

```bash
m365 todo task add --title "<title>" --listName "<list-name>"
```

Optional flags: `--importance low|normal|high`, `--dueDateTime YYYY-MM-DD`, `--bodyContent "<notes>"`, `--status notStarted|inProgress|completed|waitingOnOthers|deferred`.

Due date ignores the time portion — only the date matters.

## Get task detail

```bash
m365 todo task get --id "<task-id>" --listName "<list-name>" --output json
```

## Update task

```bash
m365 todo task set --id "<task-id>" --listName "<list-name>"
```

Supports: `--title`, `--status`, `--importance`, `--dueDateTime`, `--bodyContent`.

## Remove task

```bash
m365 todo task remove --id "<task-id>" --listName "<list-name>" --force
```

Confirm with the user before removing.
