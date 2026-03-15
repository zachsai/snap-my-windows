---
name: commit-work
description: "Commit workflow for the Snap My Windows project. Use when the user says 'commit', 'commit work', 'save my changes', or wants to commit code changes. Handles branch creation, build verification, testing, and conventional commits for this Swift/macOS xcodegen project."
---

# Commit Work

Workflow for committing changes to the Snap My Windows project. Ensures every commit passes build and tests.

## Workflow

### 1. Check branch

```bash
git branch --show-current
```

- If on `main`, ask the user for a branch name and create it:
  ```bash
  git checkout -b <branch-name>
  ```
- If already on a feature branch, continue.

### 2. Review changes

```bash
git status
git diff
git diff --staged
```

Summarize what changed for the user.

### 3. Build

Regenerate the project and build:

```bash
xcodegen generate && xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows -configuration Debug build 2>&1 | tail -20
```

Stop and report if build fails.

### 4. Test

```bash
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test 2>&1 | tail -20
```

Stop and report if tests fail.

### 5. Stage and commit

- Stage relevant files by name (avoid `git add -A`)
- Do not stage `.xcodeproj`, `.env`, or credential files
- Write a conventional commit message (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`, `test:`)
- Use a HEREDOC for the commit message
- Append `Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>`

### 6. Confirm

Show `git log -1` and `git status` to confirm success.

## Rules

- Never amend commits unless explicitly asked
- Never push unless explicitly asked
- Never skip hooks (no `--no-verify`)
- Never commit secrets or generated files (`.xcodeproj`, `DerivedData/`)
