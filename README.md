# Snap My Windows

A free, open-source macOS window management app — like Rectangle, built from scratch.

Snap windows to halves, quarters, or center with customizable keyboard shortcuts. No dock icon, just a clean menu bar app.

## Features

- **8 snap actions** — left/right half, four quarters, maximize, center
- **Global keyboard shortcuts** — works in any app
- **Multi-monitor support** — detects the correct screen automatically
- **Customizable shortcuts** — remap via Settings
- **Launch at login** — optional
- **Menu bar only** — no dock icon clutter
- **No sandbox** — direct Accessibility API access for reliable window management

## Default Shortcuts

| Action | Shortcut |
|---|---|
| Left Half | `Cmd + Opt + ←` |
| Right Half | `Cmd + Opt + →` |
| Top Left | `Cmd + Opt + U` |
| Top Right | `Cmd + Opt + I` |
| Bottom Left | `Cmd + Opt + J` |
| Bottom Right | `Cmd + Opt + K` |
| Maximize | `Cmd + Opt + Return` |
| Center | `Cmd + Opt + C` |

## Requirements

- macOS 13.0 (Ventura) or later
- Accessibility permission (prompted on first launch)

## Building from Source

### Prerequisites

- [Xcode](https://developer.apple.com/xcode/) 15.0+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) — `brew install xcodegen`

### Build

```bash
xcodegen generate
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build
```

### Test

```bash
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows test
```

### Run

After building, open the app from DerivedData or run from Xcode.

## Architecture

```
Accessibility (AXUIElement) → Screen Detection → Snap Calculator (pure geometry) → Window Snapper (orchestrator)
```

- **WindowElement** — AXUIElement wrapper for get/set window frame
- **ScreenDetector** — Multi-monitor detection + AX/NS coordinate conversion
- **SnapCalculator** — Pure geometry, fully unit tested
- **WindowSnapper** — Orchestrates the snap flow
- **ShortcutRegistrar** — Wires keyboard shortcuts to actions via [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts)

## Tech Stack

- Swift + SwiftUI (MenuBarExtra)
- [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) by sindresorhus
- Raw AXUIElement (Accessibility framework)
- XcodeGen + SPM

## License

MIT
