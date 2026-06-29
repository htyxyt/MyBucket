# Add More Apps Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add CodexPlusPlus, PasteMD, and CC Switch to the personal Scoop bucket.

**Architecture:** Follow the existing bucket structure: each app gets one manifest under `bucket/`, README documents install and update-check commands, and `tests/validate-manifests.ps1` validates the manifest set. Portable zip releases are preferred; PasteMD uses Scoop's `innosetup` support because its Windows release is an Inno Setup installer.

**Tech Stack:** Scoop manifest JSON, PowerShell validation, GitHub Releases, Git.

---

### Task 1: Extend Manifest Validation

**Files:**
- Modify: `tests/validate-manifests.ps1`

- [x] **Step 1: Add expected apps**

Add `codexplusplus`, `pastemd`, and `cc-switch` to `$expectedApps`.

- [x] **Step 2: Run validation before manifests exist**

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\validate-manifests.ps1
```

Expected: failure with `Missing manifest: bucket/codexplusplus.json`.

### Task 2: Create App Manifests

**Files:**
- Create: `bucket/codexplusplus.json`
- Create: `bucket/pastemd.json`
- Create: `bucket/cc-switch.json`

- [x] **Step 1: Inspect releases**

Use GitHub release APIs to identify Windows assets:

- CodexPlusPlus: `CodexPlusPlus-1.2.23-windows-x64.zip`
- PasteMD: `PasteMD_pandoc-Setup_v0.1.7.1.exe`
- CC Switch: `CC-Switch-v3.16.4-Windows-Portable.zip`

- [x] **Step 2: Calculate hashes**

Download each selected asset and calculate SHA256 with `Get-FileHash`.

- [x] **Step 3: Write manifests**

Create Scoop manifests with `checkver` and `autoupdate`. Use `innosetup: true` for PasteMD.

- [x] **Step 4: Keep CodexPlusPlus on Windows releases**

Set CodexPlusPlus `checkver` to scan release asset URLs and match only `windows-x64.zip`, because `v1.2.24` was published with only macOS assets.

### Task 3: Documentation and Verification

**Files:**
- Modify: `README.md`
- Create: `docs/superpowers/plans/2026-06-29-add-more-apps.md`

- [x] **Step 1: Update README**

Add install commands, app descriptions, and checkver commands for the new apps.

- [ ] **Step 2: Run validation and Scoop checks**

Run local validation, `checkver.ps1` for each new manifest, and `scoop download` for each new manifest.

- [ ] **Step 3: Commit and push**

Commit the new manifests and docs, then push `main` to `origin`.
