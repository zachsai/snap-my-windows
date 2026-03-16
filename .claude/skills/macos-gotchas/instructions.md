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

---

## 6. Multiple DerivedData Directories — Stale Binary Trap

**Problem:** Xcode can create multiple `DerivedData/AppName-<hash>/` directories for the same project (e.g., from building via Xcode GUI vs. `xcodebuild` CLI, different workspace configs, or after clearing derived data). Scripts that pick a build using `find | head -1` or alphabetical order may launch a **stale binary** from the wrong directory. You'll iterate on code changes that appear to have no effect because the old binary keeps running.

**Symptoms:**
- Code changes have zero observable effect after rebuild + relaunch
- NSLog/print statements you added never appear in logs
- The bug you "fixed" persists identically across multiple attempts

**Fix:** Always select the DerivedData directory by **most recently modified binary**, not by directory name:
```bash
# WRONG — picks alphabetically, may be stale
find ~/Library/Developer/Xcode/DerivedData/AppName-*/Build/Products/Debug/AppName.app -maxdepth 0 | head -1

# RIGHT — picks the most recently built binary
ls -t ~/Library/Developer/Xcode/DerivedData/AppName-*/Build/Products/Debug/AppName.app/Contents/MacOS/AppName | head -1 | sed 's|/Contents/MacOS/.*||'
```

**Prevention:** Periodically clean up stale DerivedData directories:
```bash
# List all DerivedData dirs for your project
ls -ltd ~/Library/Developer/Xcode/DerivedData/AppName-*/
# Remove stale ones (keep only the most recent)
```
