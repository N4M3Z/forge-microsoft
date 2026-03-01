# Capture Tabs

Snapshot all open Microsoft Edge tabs — titles and active-tab URLs — into a dated markdown archive.

## Steps

1. Run the capture script:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File "${FORGE_MODULE_ROOT:-Modules/forge-microsoft}/skills/EdgeBrowser/edge-tabs.ps1" -Export
   ```

2. Save the output to the archive directory:
   - Path: `Resources/Archives/Edge Tab Snapshot YYYY-MM-DD.md` (resolve via user root)
   - Prepend a header: `## Edge Tabs — YYYY-MM-DD HH:mm`
   - If a snapshot for today already exists, overwrite it

3. Run `-Count` mode and show the user a summary:
   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File "${FORGE_MODULE_ROOT:-Modules/forge-microsoft}/skills/EdgeBrowser/edge-tabs.ps1" -Count
   ```

4. Report what was captured and where it was saved.

## Notes

- Requires Microsoft Edge to be running (UI Automation accesses live windows)
- The `Chrome_WidgetWin_1` class matches all Chromium browsers — filtering by `msedge` process name ensures only Edge windows are captured
- Background tabs only get titles (no URLs) — this is a UI Automation limitation
- Active tabs get markdown links `[Title](URL)`, background tabs get plain text titles
- Output format matches Safari: `- [Title](URL)` for tabs with URLs, `- Title` for tabs without
