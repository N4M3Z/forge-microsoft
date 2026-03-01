# forge-microsoft — Verification

> **For AI agents**: Verify module structure, skill deployment, and m365 CLI connection.

## Structure check

```bash
test -f Modules/forge-microsoft/module.yaml && echo "module.yaml present"
test -f Modules/forge-microsoft/hooks/hooks.json && echo "hooks.json present"
test -f Modules/forge-microsoft/CONVENTIONS.md && echo "CONVENTIONS.md present"
```

## Skill deployment

```bash
make verify
```

## Dependencies

```bash
command -v m365 && echo "m365 CLI available" || echo "MISSING: npm install -g @pnp/cli-microsoft365"
m365 status    # check connection (requires prior login)
```

## Expected results

- Module directory exists with `module.yaml`, `hooks/hooks.json`, `CONVENTIONS.md`
- Skills deployed to provider directories (`make verify` passes)
- `m365` CLI installed and authenticated
