---
name: EdgeBrowser
description: Microsoft Edge tab capture — snapshot open tabs to a dated markdown archive (Windows). USE WHEN edge tabs, capture tabs, snapshot tabs, save tabs, browser tabs, list tabs.
user_invocable: true
---

# EdgeBrowser

Microsoft Edge tab capture for Windows. Exports all open tabs (titles and active-tab URLs) via PowerShell and UI Automation.

## Operations

| Operation | File | Description |
|-----------|------|-------------|
| Capture Tabs | `CaptureTabs.md` | Snapshot all Edge tabs into a dated archive |

## Tools

- `bin/edge-tabs.ps1` — tab export script (UI Automation, outputs markdown to stdout)

## Constraints

- **Windows only** — requires PowerShell and .NET UI Automation
- Edge must be running — the script exits with an error if no Edge windows are found
- Background tab URLs are not accessible via UI Automation — only titles are captured for inactive tabs; the active tab in each window gets both title and URL
- Does not capture InPrivate tabs

## Privacy

Tab URLs may contain authentication tokens, session IDs, and personally identifiable information. The output file receives no automatic TLP classification. Review captured URLs before sharing or committing to version control.

## Limitations

- UI Automation's `Chrome_WidgetWin_1` window class is shared by all Chromium browsers — the implementation filters by `msedge` process name to avoid capturing Chrome, Teams, or other Chromium windows
- Tab ordering may not match the visual order in Edge

When the user asks for an Edge tab operation, read the matching operation file and follow its instructions.
