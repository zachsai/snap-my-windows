# Snap My Windows

A free, open-source macOS window management app (like Rectangle) built from scratch.

## Tech Stack
- **Language:** Swift
- **UI:** SwiftUI MenuBarExtra (macOS 13+)
- **Shortcuts:** [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) by sindresorhus
- **Window API:** Raw AXUIElement (Accessibility framework)
- **Project Gen:** xcodegen + SPM (`.xcodeproj` is gitignored, regenerated from `project.yml`)
- **Sandbox:** Disabled (required for accessibility APIs)

## Build
```bash
xcodegen generate && xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build
```

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

## Key Constraints
- **No sandbox** — accessibility APIs require it
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
