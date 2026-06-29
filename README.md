# MyBucket

Personal Scoop bucket for apps that are not available in the default buckets I use.

## Add This Bucket

```powershell
scoop bucket add mybucket https://github.com/htyxyt/MyBucket
```

## Apps

```powershell
scoop install mybucket/markra
scoop install mybucket/clipboardx
scoop install mybucket/clipboardx-noruntime
scoop install mybucket/codexplusplus
scoop install mybucket/pastemd
scoop install mybucket/cc-switch
```

- `markra`: Markra Windows x64 portable build.
- `clipboardx`: ClipboardX Windows x64 self-contained build.
- `clipboardx-noruntime`: ClipboardX Windows x64 no-runtime build.
- `codexplusplus`: Codex++ Windows x64 portable build.
- `pastemd`: PasteMD Windows x64 Inno Setup build with Pandoc.
- `cc-switch`: CC Switch Windows x64 portable build.

## Maintenance

Check for upstream updates:

```powershell
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\markra.json
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\clipboardx.json
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\clipboardx-noruntime.json
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\codexplusplus.json
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\pastemd.json
& "$env:USERPROFILE\scoop\apps\scoop\current\bin\checkver.ps1" .\bucket\cc-switch.json
```

Validate local manifests:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\validate-manifests.ps1
```
