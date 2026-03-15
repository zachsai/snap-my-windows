# snap-action

Add a new snap action following the established pattern.

## When to Use
When adding new snap actions (e.g., left-third, right-two-thirds, first-third, etc.)

## Instructions

To add a new snap action, follow these steps in order:

### 1. Add case to `SnapAction` enum
**File:** `SnapMyWindows/WindowActions/SnapAction.swift`
- Add new case to the enum (e.g., `case leftThird`)
- Add `displayName` to the switch

### 2. Add geometry to `SnapCalculator`
**File:** `SnapMyWindows/WindowActions/SnapCalculator.swift`
- Add case to the `calculate` switch with the correct geometry
- Use `x`, `y`, `w`, `h` from `visibleFrame` to calculate the target rect

### 3. Add shortcut name
**File:** `SnapMyWindows/Shortcuts/ShortcutNames.swift`
- Add a new `static let` with default key binding
- Use `.init(keyCode, modifiers:)` pattern

### 4. Register in ShortcutRegistrar
**File:** `SnapMyWindows/Shortcuts/ShortcutRegistrar.swift`
- Add `KeyboardShortcuts.onKeyUp(for: .newName) { WindowSnapper.snap(.newAction) }`

### 5. Add to MenuBarView
**File:** `SnapMyWindows/UI/MenuBarView.swift`
- The `ForEach(SnapAction.allCases)` loop handles this automatically if using `CaseIterable`
- Update the `keyEquivalent` and `modifiers` extensions if needed

### 6. Add unit test
**File:** `SnapMyWindowsTests/SnapCalculatorTests.swift`
- Add a test verifying the geometry calculation for the new action

### 7. Build and test
- Run `/swift-build` to verify compilation
- Run tests to verify the new geometry

## Example: Adding "Left Third"
```swift
// SnapAction.swift
case leftThird  // + displayName "Left Third"

// SnapCalculator.swift
case .leftThird:
    return CGRect(x: x, y: y, width: w / 3, height: h)

// ShortcutNames.swift
static let snapLeftThird = Self("snapLeftThird", default: .init(.d, modifiers: [.command, .option]))

// ShortcutRegistrar.swift
KeyboardShortcuts.onKeyUp(for: .snapLeftThird) { WindowSnapper.snap(.leftThird) }
```
