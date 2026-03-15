# Claude Code Project Instructions

## Skills Available
- `/swift-build` — Build project, run tests, report errors
- `/smoke-test` — End-to-end verification checklist
- `/snap-action` — Add new snap actions following the pattern

## Workflow
1. After code changes, always build with `/swift-build`
2. Before committing, ensure tests pass
3. Use `/snap-action` when adding new window snap positions

## Project Regeneration
The `.xcodeproj` is gitignored. Always run `xcodegen generate` after cloning or modifying `project.yml`.
