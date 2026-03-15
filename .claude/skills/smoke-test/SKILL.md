# smoke-test

Verify the core stack works end-to-end.

## When to Use
After Phase B completion and any major changes. Use to verify the app is functional.

## Instructions

Run through this checklist and report pass/fail for each:

### Build Check
1. Run `xcodegen generate` if needed
2. Run `xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build`
3. Report: BUILD PASS or BUILD FAIL

### Unit Tests
4. Run `xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test`
5. Report: TESTS PASS or TESTS FAIL (with failure details)

### Manual Verification Checklist
Report these as items for the user to manually verify:
- [ ] App builds without errors
- [ ] Menu bar icon appears (no dock icon)
- [ ] Accessibility permission prompt shows on first launch
- [ ] After granting permission, snap shortcuts work
- [ ] Works with Finder, Safari, Terminal

## Output Format
```
Smoke Test Results:
  Build:      PASS/FAIL
  Unit Tests: PASS/FAIL

Manual checks needed:
  - [ ] Menu bar icon appears
  - [ ] Accessibility prompt works
  - [ ] Snap shortcuts functional
```
