# forge-microsoft — Installation

> **For AI agents**: This module is a scaffold — Microsoft 365 integration is in early development.

## As part of forge-core (submodule)

Already included in `defaults.yaml`. No build step required.

```yaml
modules:
  - forge-microsoft    # Platform — M365 email, Teams, SharePoint via m365 CLI
```

## Planned capabilities

| Service | Status |
|---------|--------|
| Outlook (email) | Scaffolded |
| Teams (chat) | Not implemented |
| SharePoint (files) | Not implemented |
| OneDrive (storage) | Not implemented |
| Planner (tasks) | Not implemented |

## Dependencies

| Dependency | Required | Install |
|-----------|----------|---------|
| Node.js | Yes | `brew install node` |
| CLI Microsoft 365 | Yes | `npm install -g @pnp/cli-microsoft365` |
| Azure Entra app | Yes | App registration with delegated permissions |
| [safety-net](https://github.com/kenryu42/claude-code-safety-net) | Recommended | Blocks destructive commands — see [root INSTALL.md](../../INSTALL.md#recommended-security-tools) |
| shellcheck | Recommended | `brew install shellcheck` — shell script linting |

### Authentication

```bash
m365 login --appId $M365_APP_ID --authType deviceCode
m365 status    # verify connection
```

Set credentials in `.env` (gitignored):

```bash
M365_APP_ID=<your-azure-app-id>
M365_TENANT_ID=<your-tenant-id>
M365_EMAIL=<your-email>
```

## Verify

See [VERIFY.md](VERIFY.md) for the post-installation checklist.
