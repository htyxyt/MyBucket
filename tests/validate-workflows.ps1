param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$workflowPath = Join-Path $Root '.github/workflows/autoupdate.yml'
if (-not (Test-Path -LiteralPath $workflowPath -PathType Leaf)) {
    throw "Missing workflow: .github/workflows/autoupdate.yml"
}

$workflow = Get-Content -LiteralPath $workflowPath -Raw
$requiredPatterns = @(
    'schedule:',
    'workflow_dispatch:',
    'contents: write',
    'checkver.ps1',
    '-u',
    'validate-manifests.ps1',
    'git commit',
    'git push'
)

foreach ($pattern in $requiredPatterns) {
    if ($workflow -notmatch [regex]::Escape($pattern)) {
        throw "Workflow is missing required content: $pattern"
    }
}

Write-Host 'Validated autoupdate workflow.'
