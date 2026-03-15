import ApplicationServices

enum AccessibilityChecker {
    /// Returns true if this app is trusted for accessibility access.
    static func isTrusted() -> Bool {
        AXIsProcessTrusted()
    }

    /// Prompts the user to grant accessibility access if not already granted.
    /// Opens System Settings to the Privacy & Security > Accessibility pane.
    static func promptIfNeeded() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue(): true] as CFDictionary
        AXIsProcessTrustedWithOptions(options)
    }
}
