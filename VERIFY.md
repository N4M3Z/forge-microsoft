# Verify

## Health check

```bash
m365 status
test -f Modules/forge-microsoft/module.yaml    && echo "module.yaml present"
test -f Modules/forge-microsoft/hooks/hooks.json && echo "hooks.json present"
test -d Modules/forge-microsoft/rules              && echo "rules/ present"
```

## Structure validation

```bash
make verify    # check skills deployed across all providers
```

## Functionality tests

```bash
m365 todo list list --output json 2>&1 | head -1 && echo "Todo: OK"       || echo "Todo: MISSING Tasks.ReadWrite"
m365 teams team list --joined --output json 2>&1 | head -1 && echo "Teams: OK" || echo "Teams: MISSING Team.ReadBasic.All"
m365 request --url "@graph/me/calendarView?startDateTime=$(date -u +%Y-%m-%dT00:00:00Z)&endDateTime=$(date -u +%Y-%m-%dT23:59:59Z)" --method get 2>&1 | head -1 && echo "Calendar: OK" || echo "Calendar: MISSING Calendars.ReadWrite"
```

## Success criteria

- Module directory exists with `module.yaml`, `hooks/hooks.json`, `CONVENTIONS.md`
- Skills deployed to provider directories (`make verify` passes)
- `m365` CLI installed and authenticated
- Todo, Calendar, and Teams permissions granted in Azure Entra
