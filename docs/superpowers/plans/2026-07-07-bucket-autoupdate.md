# Bucket Autoupdate Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add GitHub Actions automation that updates Scoop manifest versions and hashes when upstream releases change.

**Architecture:** A scheduled Windows workflow installs Scoop, runs Scoop's `checkver.ps1 -u` over every manifest in `bucket/`, validates manifests, and commits changed files back to `main`. A small PowerShell validation script checks the workflow has the required trigger, write permission, update command, validation command, and push step.

**Tech Stack:** GitHub Actions, PowerShell, Scoop checkver, Git.

---

### Task 1: Workflow Validation Test

**Files:**
- Create: `tests/validate-workflows.ps1`

- [x] **Step 1: Write failing test**

Create a PowerShell script that requires `.github/workflows/autoupdate.yml` and checks for `schedule:`, `workflow_dispatch:`, `contents: write`, `checkver.ps1`, `-u`, `validate-manifests.ps1`, `git commit`, and `git push`.

- [x] **Step 2: Run test before workflow exists**

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\validate-workflows.ps1
```

Expected: failure with `Missing workflow: .github/workflows/autoupdate.yml`.

### Task 2: Autoupdate Workflow

**Files:**
- Create: `.github/workflows/autoupdate.yml`

- [x] **Step 1: Add triggers and permissions**

Use `workflow_dispatch` for manual runs, `schedule` for daily runs, and `permissions.contents: write` so `GITHUB_TOKEN` can push commits.

- [x] **Step 2: Install Scoop and run checkver**

Use a Windows runner, install Scoop, and run `checkver.ps1 -u` for every `bucket/*.json` manifest.

- [x] **Step 3: Validate and commit**

Run `tests/validate-manifests.ps1`, then commit and push only when `git status --porcelain` reports changes.

### Task 3: Documentation and Verification

**Files:**
- Modify: `README.md`
- Create: `docs/superpowers/plans/2026-07-07-bucket-autoupdate.md`

- [x] **Step 1: Document automation**

Explain the daily/manual workflow and the local `scoop update` flow.

- [ ] **Step 2: Verify locally**

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\validate-manifests.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\validate-workflows.ps1
```

Expected: both scripts pass.

- [ ] **Step 3: Commit and push**

Commit the workflow, tests, README, and plan; push to `origin/main`.
