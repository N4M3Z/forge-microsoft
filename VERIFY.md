# forge-microsoft — Verification

> **For AI agents**: This module is a scaffold. Verification is minimal.

## Structure check

```bash
test -f Modules/forge-microsoft/module.yaml && echo "module.yaml present"
test -f Modules/forge-microsoft/hooks/hooks.json && echo "hooks.json present"
```

## Dependencies (when active)

```bash
command -v m365 && echo "m365 CLI available" || echo "MISSING: npm install -g @pnp/cli-microsoft365"
m365 status    # check connection (requires prior login)
```

## Expected results

- Module directory exists with `module.yaml` and `hooks/hooks.json`
- No active hooks (hooks.json is empty)
- `m365` CLI installed and authenticated (when ready to use)
