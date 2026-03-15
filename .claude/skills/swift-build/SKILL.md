# swift-build

Build the Xcode project, run tests, and report errors.

## When to Use
After any code change, before committing. Use this skill to verify the project builds and tests pass.

## Instructions

1. Check if `project.yml` has been modified since last `xcodegen generate` (compare timestamps with `.xcodeproj`). If so, run `xcodegen generate` first.
2. Build the project:
   ```bash
   xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build 2>&1
   ```
3. Parse the output:
   - Look for `BUILD SUCCEEDED` or `BUILD FAILED`
   - If failed, extract error messages and file:line references
   - Report a concise summary

4. If tests are requested, also run:
   ```bash
   xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test 2>&1
   ```

## Output Format
- On success: "Build succeeded" (one line)
- On failure: List each error with file path and line number, then suggest fixes
