# MyBucket Design

## Goal

Create a personal Scoop bucket at `git@github.com:htyxyt/MyBucket.git` for GitHub-hosted Windows applications that are not covered by the user's current buckets.

## Scope

The initial bucket contains three manifests:

- `markra`: Markra Windows x64 portable zip.
- `clipboardx`: ClipboardX full Windows x64 self-contained zip.
- `clipboardx-noruntime`: ClipboardX full Windows x64 no-runtime zip.

ClipboardX child component packages such as Clipboard and FileJump are intentionally excluded.

## Repository Shape

- `bucket/*.json` contains Scoop manifests.
- `tests/validate-manifests.ps1` validates required fields, x64 URL/hash presence, and shortcuts.
- `README.md` documents how to add the bucket, install apps, and run maintenance commands.

## Update Strategy

Each manifest uses GitHub release metadata through `checkver` and has an `autoupdate` URL pattern. Initial SHA256 hashes are calculated from the current latest release assets on 2026-06-26.

## Verification

Verification should include:

- Local JSON/field validation with `tests/validate-manifests.ps1`.
- Scoop manifest checks with `scoop checkver`.
- A local bucket install test for at least one manifest when feasible.
