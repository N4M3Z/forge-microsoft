# Install

## Requirements

| Dependency                                                                          | Required    | Install                                                                              |
|-------------------------------------------------------------------------------------|-------------|--------------------------------------------------------------------------------------|
| Node.js                                                                             | Yes         | `brew install node`                                                                  |
| CLI Microsoft 365                                                                   | Yes         | `npm install -g @pnp/cli-microsoft365`                                               |
| Azure Entra app                                                                     | Yes         | App registration with delegated permissions                                          |
| [safety-net](https://github.com/kenryu42/claude-code-safety-net)                    | Recommended | Blocks destructive commands — see [root INSTALL.md](../../INSTALL.md)                |
| shellcheck                                                                          | Recommended | `brew install shellcheck` — shell script linting                                     |

## Deploy

Already included in `defaults.yaml` as a forge-core submodule. No build step required.

```yaml
modules:
    - forge-microsoft    # Platform — M365 email, Todo, Calendar, Teams via m365 CLI
```

```bash
make install    # deploy skills to all providers
make verify     # check deployment
```

## Configuration

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

### Permissions (Azure Entra App)

| Permission              | Type      | Services         |
|-------------------------|-----------|------------------|
| Mail.ReadWrite          | Delegated | Outlook          |
| Tasks.ReadWrite         | Delegated | Todo             |
| Calendars.ReadWrite     | Delegated | Calendar         |
| Chat.Read               | Delegated | Teams (read)     |
| ChannelMessage.Read.All | Delegated | Teams (channels) |
| Team.ReadBasic.All      | Delegated | Teams (list)     |
| Channel.ReadBasic.All   | Delegated | Teams (list)     |
| ChatMessage.Send        | Delegated | Teams (send)     |

## Troubleshooting

| Problem                            | Fix                                                                          |
|------------------------------------|------------------------------------------------------------------------------|
| `m365 status` shows disconnected   | Re-authenticate: `m365 login --appId $M365_APP_ID --authType deviceCode`     |
| Todo commands fail with 403        | Grant `Tasks.ReadWrite` permission in Azure Entra                            |
| Calendar requests return 403       | Grant `Calendars.ReadWrite` permission in Azure Entra                        |
| Teams messages return 403          | Verify team membership and `Chat.Read` permission                            |
