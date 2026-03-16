# macOS App Development Gotchas

A living log of macOS platform quirks and workarounds discovered during development. Reference this when debugging platform-specific issues or starting new macOS projects.

---

## 1. LSUIElement + Window Activation

**Problem:** `LSUIElement = true` apps use `.accessory` activation policy, which prevents reliable window display. `NSApp.activate(ignoringOtherApps:)` alone is insufficient — macOS won't bring accessory app windows to the front.

**Fix:** Temporarily switch to `.regular` activation policy before showing the window, then restore `.accessory` when the window closes. This briefly shows a dock icon, which is the accepted trade-off all major menu bar apps (Rectangle, Ice) use.

```swift
// Before showing window
NSApp.setActivationPolicy(.regular)
NSApp.activate(ignoringOtherApps: true)
window.makeKeyAndOrderFront(nil)

// On window close
NotificationCenter.default.addObserver(
    forName: NSWindow.willCloseNotification,
    object: window, queue: .main
) { _ in
    NSApp.setActivationPolicy(.accessory)
}
```

---

## 2. MenuBarExtra Button Action Timing

**Problem:** Button actions inside `MenuBarExtra` fire while the menu is still dismissing (~150ms animation). Window operations attempted during this animation are unreliable.

**Fix:** Use `DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)` (200ms minimum) before performing any window operations triggered from a MenuBarExtra button.

---

## 3. `.tint()` + Toggle `.switch` Style on macOS 13

**Problem:** Applying `.tint()` to a `Toggle` with `.switch` style on macOS 13 causes an `NSInvalidArgumentException` crash at runtime.

**Fix:** Don't use `.tint()` on switch-style toggles when targeting macOS 13. Use `toggleStyle(.switch)` without tint, or guard the tint modifier behind an availability check for macOS 14+.

---

## 4. AX Coordinate System vs NSScreen

**Problem:** The Accessibility (AXUIElement) coordinate system uses top-left origin, while `NSScreen` uses bottom-left origin. Mixing them without conversion causes windows to snap to wrong positions.

**Fix:** Convert between coordinate systems:
```swift
// NSScreen → AX coordinates
axY = primaryScreen.frame.maxY - nsRect.maxY
```

---

## 5. Window Resize Clamping

**Problem:** macOS may clamp window sizes during a move or resize operation, causing the final frame to differ from what was set.

**Fix:** Set size, then position, then size again to work around OS clamping behavior.
