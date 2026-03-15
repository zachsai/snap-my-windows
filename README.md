# Snap My Windows

A free, open-source macOS window management app — like Rectangle, built from scratch.

Snap windows to halves, thirds, quarters, or center with customizable keyboard shortcuts. No dock icon, just a clean menu bar app.

## Features

- **13 snap actions** — halves, thirds, two-thirds, quarters, maximize, center
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
| Left Third | `Cmd + Opt + D` |
| Center Third | `Cmd + Opt + F` |
| Right Third | `Cmd + Opt + G` |
| Left Two Thirds | `Cmd + Opt + E` |
| Right Two Thirds | `Cmd + Opt + T` |

## Requirements

- macOS 13.0 (Ventura) or later
- Accessibility permission (prompted on first launch)

## Setup & Build

### Prerequisites

Install these if you don't have them:

```bash
# Xcode (from App Store or developer.apple.com) — 15.0+
xcode-select --install

# XcodeGen — generates the .xcodeproj from project.yml
brew install xcodegen
```

### Clone & Build

```bash
git clone https://github.com/zachsai/snap-my-windows.git
cd snap-my-windows

# Generate Xcode project (required — .xcodeproj is gitignored)
xcodegen generate

# Build
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build
```

### Run

```bash
# Open the built app directly
open ~/Library/Developer/Xcode/DerivedData/SnapMyWindows-*/Build/Products/Debug/SnapMyWindows.app
```

On first launch:
1. The menu bar icon appears (rectangle split icon) — no Dock icon
2. Click "Grant Accessibility Access..." in the menu bar dropdown
3. System Settings opens to **Privacy & Security > Accessibility**
4. Toggle **SnapMyWindows** ON
5. The app detects the permission automatically (no restart needed)

> **Note:** After each rebuild, macOS may ask for Accessibility permission again — this is normal for ad-hoc signed development builds.

### Release Build

```bash
./scripts/build-release.sh
```

Outputs `build/SnapMyWindows.app` and `build/SnapMyWindows.dmg`.

### Test

```bash
xcodegen generate  # if not already generated
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test
```

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

## Developing with Claude Code

This project includes [Claude Code](https://claude.ai/claude-code) configuration for AI-assisted development. When you open the repo root with Claude Code, the following is available automatically:

### Skills (Slash Commands)

| Command | Description |
|---|---|
| `/swift-build` | Build the project, run tests, report errors |
| `/smoke-test` | End-to-end verification checklist |
| `/snap-action` | Add a new snap action following the established pattern |
| `/skill-creator` | Create new Claude Code skills |

These are defined in `.claude/skills/` and loaded automatically.

### MCP Servers

The project benefits from these MCP servers (configure in your Claude Code settings or `~/.claude.json`):

| Server | Purpose |
|---|---|
| **apple-docs-mcp** | Search Apple developer docs, WWDC videos, framework symbols. Useful for AXUIElement, NSScreen, SwiftUI APIs. |
| **context7** | Retrieve up-to-date library docs and code examples (e.g., KeyboardShortcuts). |

To add MCP servers, use `/mcp` in Claude Code or edit `~/.claude.json`.

### Project Permissions

`.claude/settings.json` pre-configures auto-allow for safe commands: `xcodegen`, `xcodebuild`, `git`, `open`, `ls`, `which`, `brew`.

### Development Workflow

1. After cloning, run `xcodegen generate` to create the `.xcodeproj`
2. After code changes, run `/swift-build` to build and test
3. Use `/snap-action` when adding new window snap positions
4. Before committing, ensure all tests pass
5. Use `/smoke-test` for end-to-end verification

## License

MIT
