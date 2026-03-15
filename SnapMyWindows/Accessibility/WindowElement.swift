import ApplicationServices
import CoreGraphics

/// Wraps an AXUIElement representing a window, providing get/set for position and size.
struct WindowElement {
    let element: AXUIElement

    /// Returns the WindowElement for the currently focused window, if any.
    static func focusedWindow() -> WindowElement? {
        let systemWide = AXUIElementCreateSystemWide()

        var focusedApp: AnyObject?
        guard AXUIElementCopyAttributeValue(systemWide, kAXFocusedApplicationAttribute as CFString, &focusedApp) == .success else {
            return nil
        }

        var focusedWindow: AnyObject?
        guard AXUIElementCopyAttributeValue(focusedApp as! AXUIElement, kAXFocusedWindowAttribute as CFString, &focusedWindow) == .success else {
            return nil
        }

        return WindowElement(element: focusedWindow as! AXUIElement)
    }

    /// The window's frame in AX coordinates (top-left origin).
    var frame: CGRect? {
        get {
            guard let position = getPosition(), let size = getSize() else { return nil }
            return CGRect(origin: position, size: size)
        }
    }

    /// Sets the window's frame in AX coordinates.
    /// Sets size, then position, then size again to handle OS clamping.
    func setFrame(_ rect: CGRect) {
        setSize(rect.size)
        setPosition(rect.origin)
        setSize(rect.size)
    }

    // MARK: - Private

    private func getPosition() -> CGPoint? {
        var value: AnyObject?
        guard AXUIElementCopyAttributeValue(element, kAXPositionAttribute as CFString, &value) == .success else {
            return nil
        }
        var point = CGPoint.zero
        guard AXValueGetValue(value as! AXValue, .cgPoint, &point) else { return nil }
        return point
    }

    private func getSize() -> CGSize? {
        var value: AnyObject?
        guard AXUIElementCopyAttributeValue(element, kAXSizeAttribute as CFString, &value) == .success else {
            return nil
        }
        var size = CGSize.zero
        guard AXValueGetValue(value as! AXValue, .cgSize, &size) else { return nil }
        return size
    }

    private func setPosition(_ point: CGPoint) {
        var mutablePoint = point
        guard let value = AXValueCreate(.cgPoint, &mutablePoint) else { return }
        AXUIElementSetAttributeValue(element, kAXPositionAttribute as CFString, value)
    }

    private func setSize(_ size: CGSize) {
        var mutableSize = size
        guard let value = AXValueCreate(.cgSize, &mutableSize) else { return }
        AXUIElementSetAttributeValue(element, kAXSizeAttribute as CFString, value)
    }
}
