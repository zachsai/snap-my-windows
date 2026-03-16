# Snap My Windows

A free, open-source macOS window management app (like Rectangle) built from scratch.

## Tech Stack
- **Language:** Swift
- **UI:** SwiftUI MenuBarExtra (macOS 13+)
- **Shortcuts:** [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) by sindresorhus
- **Window API:** Raw AXUIElement (Accessibility framework)
- **Project Gen:** xcodegen + SPM (`.xcodeproj` is gitignored, regenerated from `project.yml`)
- **Sandbox:** Enabled (App Store compatible — user grants accessibility in System Preferences)

## Build
```bash
xcodegen generate && xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build
```

## DerivedData Warning
Multiple `DerivedData/SnapMyWindows-<hash>/` directories may exist. The relaunch script (`scripts/relaunch.sh`) picks the one with the most recently modified binary. If code changes appear to have no effect after rebuild + relaunch, verify you're running the correct build:
```bash
ls -lt ~/Library/Developer/Xcode/DerivedData/SnapMyWindows-*/Build/Products/Debug/SnapMyWindows.app/Contents/MacOS/SnapMyWindows
```
Clean up stale directories if needed. This is a common Xcode gotcha when building from both CLI and Xcode GUI.

## Test
```bash
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test
```

## Architecture
```
Accessibility (AXUIElement) → Screen Detection → Snap Calculator (pure geometry) → Window Snapper (orchestrator)
```

### Key Files
- `SnapMyWindows/App/SnapMyWindowsApp.swift` — @main entry, MenuBarExtra
- `SnapMyWindows/Accessibility/WindowElement.swift` — AXUIElement wrapper (get/set window frame)
- `SnapMyWindows/Accessibility/AccessibilityChecker.swift` — Permission check + prompt
- `SnapMyWindows/WindowActions/SnapCalculator.swift` — Pure geometry (most testable)
- `SnapMyWindows/WindowActions/WindowSnapper.swift` — Orchestrator
- `SnapMyWindows/Screen/ScreenDetector.swift` — Multi-monitor + coordinate conversion
- `SnapMyWindows/Shortcuts/ShortcutNames.swift` — KeyboardShortcuts definitions
- `SnapMyWindows/Shortcuts/ShortcutRegistrar.swift` — Hotkey → action wiring
- `SnapMyWindows/UI/MenuBarView.swift` — Menu bar dropdown
- `SnapMyWindows/UI/SettingsView.swift` — Settings window with shortcut recorders + launch at login

## Key Constraints
- **App Sandbox enabled** — accessibility works via user-granted permission in System Preferences
- **AX coordinate system** — top-left origin (unlike NSScreen's bottom-left)
- **Coordinate conversion:** `axY = primaryScreen.frame.maxY - nsRect.maxY`
- **Window resize trick:** set size, then position, then size again (handles OS clamping)

## Default Shortcuts
| Action | Shortcut |
|--------|----------|
| Left Half | `Cmd+Opt+←` |
| Right Half | `Cmd+Opt+→` |
| Top Left | `Cmd+Opt+U` |
| Top Right | `Cmd+Opt+I` |
| Bottom Left | `Cmd+Opt+J` |
| Bottom Right | `Cmd+Opt+K` |
| Maximize | `Cmd+Opt+Return` |
| Center | `Cmd+Opt+C` |
| Left Third | `Cmd+Opt+D` |
| Center Third | `Cmd+Opt+F` |
| Right Third | `Cmd+Opt+G` |
| Left Two Thirds | `Cmd+Opt+E` |
| Right Two Thirds | `Cmd+Opt+T` |

## Release Build
```bash
./scripts/build-release.sh
```
Outputs `build/SnapMyWindows.app` and `build/SnapMyWindows.dmg`.

## GitHub Bot Auth
Before any `gh pr create` or `gh` API call that needs bot identity, set the token:
```bash
export GH_TOKEN=$(gh-bot-token)
```
Always add `--reviewer zachsai` to `gh pr create` so Zach gets notified.

Verify with:
```bash
gh api /user 2>/dev/null || echo "Using app token (correct)"
```
**Warning:** If the verification command shows a username, a personal token is leaking — stop and fix before proceeding.
