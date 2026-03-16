# Contributing to Snap My Windows

Thanks for your interest in contributing!

## Development Setup

### Prerequisites

```bash
# Xcode 15.0+ (from App Store or developer.apple.com)
xcode-select --install

# XcodeGen — generates the .xcodeproj from project.yml
brew install xcodegen
```

### Build & Run

```bash
git clone https://github.com/zachsai/snap-my-windows.git
cd snap-my-windows
xcodegen generate
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindows build
```

### Run Tests

```bash
xcodebuild -project SnapMyWindows.xcodeproj -scheme SnapMyWindowsTests test
```

## Claude Code Integration

This project includes [Claude Code](https://claude.ai/claude-code) configuration for AI-assisted development.

### Skills (Slash Commands)

| Command | Description |
|---|---|
| `/swift-build` | Build the project, run tests, report errors |
| `/smoke-test` | End-to-end verification checklist |
| `/snap-action` | Add a new snap action following the established pattern |

### MCP Servers

| Server | Purpose |
|---|---|
| **apple-docs-mcp** | Search Apple developer docs, WWDC videos, framework symbols |
| **context7** | Retrieve up-to-date library docs and code examples |

### Workflow

1. After cloning, run `xcodegen generate` to create the `.xcodeproj`
2. After code changes, run `/swift-build` to build and test
3. Use `/snap-action` when adding new window snap positions
4. Before committing, ensure all tests pass
