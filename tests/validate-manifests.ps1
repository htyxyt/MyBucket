param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$bucketDir = Join-Path $Root 'bucket'
$expectedApps = @(
    'markra',
    'clipboardx',
    'clipboardx-noruntime'
)

if (-not (Test-Path -LiteralPath $bucketDir -PathType Container)) {
    throw "Missing bucket directory: $bucketDir"
}

foreach ($app in $expectedApps) {
    $manifestPath = Join-Path $bucketDir "$app.json"
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw "Missing manifest: bucket/$app.json"
    }

    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    foreach ($field in @('version', 'description', 'homepage', 'license', 'architecture', 'checkver', 'autoupdate')) {
        if (-not $manifest.PSObject.Properties.Name.Contains($field)) {
            throw "bucket/$app.json is missing required field: $field"
        }
    }

    $x64 = $manifest.architecture.'64bit'
    if (-not $x64.url) {
        throw "bucket/$app.json is missing architecture.64bit.url"
    }
    if ($x64.hash -notmatch '^[a-fA-F0-9]{64}$') {
        throw "bucket/$app.json has an invalid SHA256 hash"
    }
    if (-not $manifest.shortcuts -or $manifest.shortcuts.Count -lt 1) {
        throw "bucket/$app.json must define at least one shortcut"
    }
}

Write-Host "Validated $($expectedApps.Count) Scoop manifests."
