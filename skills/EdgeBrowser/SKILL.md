---
name: EdgeBrowser
version: 0.1.3
description: Capture all open Microsoft Edge tabs (titles and active URLs) and append them to a markdown file. USE WHEN listing browser tabs, capturing research links, or creating a backlog from open tabs.
---

# EdgeBrowser

Capture all open Microsoft Edge tabs (titles and active URLs) from the current Windows session and append them to a specified markdown file.

## Instructions

1. **Target File**: Identify the destination markdown file based on the user's request (e.g., a backlog, journal, or research note).
2. **Capture & Write**: Run the following PowerShell command to perform the capture and append the results to the target file.

### PowerShell Implementation (All Tabs)

```powershell
powershell.exe -NoProfile -Command "
Add-Type -AssemblyName UIAutomationClient;
$root = [System.Windows.Automation.AutomationElement]::RootElement;
$condition = New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ClassNameProperty, 'Chrome_WidgetWin_1');
$wins = [System.Windows.Automation.AutomationElement]::RootElement.FindAll([System.Windows.Automation.TreeScope]::Children, $condition);
$markdown = @();
$markdown += '## Edge Tabs Capture - ' + (Get-Date -Format 'dd:MM:yyyy HH:mm');
foreach ($win in $wins) {
    if ($win.Current.Name -match 'Microsoft​ Edge') {
        # Získání URL aktivní karty z adresního řádku
        $url = '';
        $barCondition = New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ControlTypeProperty, [System.Windows.Automation.ControlType]::Edit);
        $bar = $win.FindFirst([System.Windows.Automation.TreeScope]::Descendants, $barCondition);
        if ($bar) {
            try { $url = $bar.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).Current.Value; } catch {}
        }

        # Najít všechny karty (TabItems) v okně
        $tabCondition = New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ControlTypeProperty, [System.Windows.Automation.ControlType]::TabItem);
        $tabs = $win.FindAll([System.Windows.Automation.TreeScope]::Descendants, $tabCondition);
        
        if ($tabs.Count -gt 0) {
            foreach ($tab in $tabs) {
                $tabName = $tab.Current.Name;
                # Zkusíme zjistit, zda je karta vybraná (aktivní)
                $isSelected = $false;
                try {
                    $selectionPattern = $tab.GetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern);
                    $isSelected = $selectionPattern.Current.IsSelected;
                } catch {}

                if ($isSelected -and $url -match '^https?://') {
                    $markdown += '- [ACTIVE] [{0}]({1})' -f $tabName, $url;
                } else {
                    $markdown += '- {0}' -f $tabName;
                }
            }
        } else {
            # Fallback pro případ, že se karty nepodaří najít jednotlivě
            $markdown += '- {0} ({1})' -f ($win.Current.Name -replace ' - Microsoft​ Edge', ''), $url;
        }
        $markdown += '';
    }
}
$markdown += '---';
$markdown | Out-File -FilePath 'TARGET_FILE_PATH' -Append -Encoding utf8;
"
```

## Constraints

- **Windows Only**: Requires PowerShell and UI Automation.
- **Background Tab URLs**: URLs of background tabs are NOT accessible via UI Automation. Only the titles of background tabs are captured. The URL is only captured for the currently active tab in each window.
- **Edge Running**: Microsoft Edge must be open.
- **Privacy**: Does not capture Incognito/InPrivate tabs.
