# edge-tabs.ps1 — capture all open Microsoft Edge tabs via UI Automation.
# Outputs markdown to stdout. Exit 1 if Edge is not running.
# Windows only — requires .NET UI Automation (System.Windows.Automation).

param(
    [switch]$Count,
    [switch]$Export
)

if (-not $IsWindows) {
    [Console]::Error.WriteLine('edge-tabs.ps1 requires Windows (.NET UI Automation is not available on this platform).')
    exit 1
}

$ErrorActionPreference = 'Stop'

if (-not $Count -and -not $Export) {
    $Export = $true
}

Add-Type -AssemblyName UIAutomationClient

$root = [System.Windows.Automation.AutomationElement]::RootElement
$condition = New-Object System.Windows.Automation.PropertyCondition(
    [System.Windows.Automation.AutomationElement]::ClassNameProperty,
    'Chrome_WidgetWin_1'
)
$wins = $root.FindAll(
    [System.Windows.Automation.TreeScope]::Children,
    $condition
)

if ($wins.Count -eq 0) {
    Write-Error 'No Chromium windows found. Is Microsoft Edge running?'
    exit 1
}

$totalTabs = 0
$windowCount = 0

foreach ($win in $wins) {
    $proc = Get-Process -Id $win.Current.ProcessId -ErrorAction SilentlyContinue
    if ($proc.ProcessName -ne 'msedge') { continue }
    $windowCount++

    # Active tab URL from address bar
    $barCondition = New-Object System.Windows.Automation.PropertyCondition(
        [System.Windows.Automation.AutomationElement]::ControlTypeProperty,
        [System.Windows.Automation.ControlType]::Edit
    )
    $bar = $win.FindFirst(
        [System.Windows.Automation.TreeScope]::Descendants,
        $barCondition
    )
    $url = ''
    if ($bar) {
        try {
            $url = $bar.GetCurrentPattern(
                [System.Windows.Automation.ValuePattern]::Pattern
            ).Current.Value
        } catch { $url = '' }
    }

    # All tabs in this window
    $tabCondition = New-Object System.Windows.Automation.PropertyCondition(
        [System.Windows.Automation.AutomationElement]::ControlTypeProperty,
        [System.Windows.Automation.ControlType]::TabItem
    )
    $tabs = $win.FindAll(
        [System.Windows.Automation.TreeScope]::Descendants,
        $tabCondition
    )

    if ($tabs.Count -gt 0) {
        $totalTabs += $tabs.Count
        if ($Export) {
            foreach ($tab in $tabs) {
                $name = $tab.Current.Name
                $selected = $false
                try {
                    $pattern = $tab.GetCurrentPattern(
                        [System.Windows.Automation.SelectionItemPattern]::Pattern
                    )
                    $selected = $pattern.Current.IsSelected
                } catch { $selected = $false }

                if ($selected -and $url -match '^https?://') {
                    Write-Output ('- [{0}]({1})' -f $name, $url)
                } else {
                    Write-Output ('- {0}' -f $name)
                }
            }
        }
    } else {
        # Fallback: single tab from window title
        $totalTabs++
        if ($Export) {
            $title = $win.Current.Name -replace ' - Microsoft Edge$', ''
            if ($url -match '^https?://') {
                Write-Output ('- [{0}]({1})' -f $title, $url)
            } else {
                Write-Output ('- {0}' -f $title)
            }
        }
    }
}

if ($windowCount -eq 0) {
    Write-Error 'No Edge windows found. Is Microsoft Edge running?'
    exit 1
}

if ($Count) {
    Write-Output "Edge: $totalTabs tabs across $windowCount windows"
}
