import AppKit

enum ScreenDetector {
    /// Returns the screen containing the center of the given AX-coordinate frame.
    /// Falls back to the main screen.
    static func screen(for axFrame: CGRect) -> NSScreen {
        let nsRect = axToNS(axFrame)
        let center = CGPoint(x: nsRect.midX, y: nsRect.midY)

        return NSScreen.screens.first { $0.frame.contains(center) }
            ?? NSScreen.main
            ?? NSScreen.screens[0]
    }

    /// Converts an NSScreen's visibleFrame to AX coordinates (top-left origin).
    static func visibleFrameInAX(for screen: NSScreen) -> CGRect {
        nsToAX(screen.visibleFrame)
    }

    /// Converts AX coordinates (top-left origin) to NSScreen coordinates (bottom-left origin).
    static func axToNS(_ rect: CGRect) -> CGRect {
        let primaryHeight = NSScreen.screens[0].frame.height
        return CGRect(
            x: rect.origin.x,
            y: primaryHeight - rect.origin.y - rect.height,
            width: rect.width,
            height: rect.height
        )
    }

    /// Converts NSScreen coordinates (bottom-left origin) to AX coordinates (top-left origin).
    static func nsToAX(_ rect: CGRect) -> CGRect {
        let primaryHeight = NSScreen.screens[0].frame.height
        return CGRect(
            x: rect.origin.x,
            y: primaryHeight - rect.origin.y - rect.height,
            width: rect.width,
            height: rect.height
        )
    }
}
