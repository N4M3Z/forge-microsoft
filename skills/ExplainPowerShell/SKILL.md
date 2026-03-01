---
name: ExplainPowerShell
description: Analyzes and explains the function of a PowerShell script. USE WHEN explaining a PowerShell script, what a script does, or analyzing PS code.
version: 0.1.1
---

# ExplainPowerShell

A skill for in-depth analysis and explanation of PowerShell scripts, focusing on clarity, security, and code efficiency.

## Instructions

When analyzing a PowerShell script, follow these steps:

1. **Overall Purpose**: Briefly (1-2 sentences) explain the main goal of the script.
2. **Block-by-Block Breakdown**: Divide the script into logical parts (functions, loops, command blocks) and explain what each part does.
3. **Key Parameters and Variables**: Identify important variables and input parameters that affect the script's behavior.
4. **Security and Risks**: Highlight potentially dangerous operations (data deletion, permission changes, network communication) or missing error handling.
5. **Recommendations for Improvement**: Suggest how the code could be made more efficient (e.g., better filtering, using modern cmdlets) or better structured.

## Output Format

The explanation should be structured as follows (headings in Czech as per user preference):

- **Souhrn**: What the script does.
- **Jak to funguje**: Detailed logic breakdown.
- **Bezpečnostní poznámky**: What to watch out for.
- **Tipy**: Possible improvements.

## Constraints

- Focus exclusively on PowerShell (Core and Desktop versions).
- If the script contains unclear or potentially dangerous parts, always explicitly highlight them.
- **Always communicate in Czech (the user's language)**, even if the code or these instructions are in English.
- If the script is too long, focus on its main logic and do not list every minor detail that is not critical for its function.
