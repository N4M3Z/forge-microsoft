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
