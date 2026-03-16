import AppKit
import QuartzCore

/// Monitors global mouse drag events and snaps windows when released at screen edges/corners.
final class DragSnapMonitor {
    private var dragMonitor: Any?
    private var mouseUpMonitor: Any?
    private(set) var currentZone: SnapZone?
    private var currentScreen: NSScreen?
    private var previewOverlay: SnapPreviewOverlay?
    private(set) var isRunning = false
    private var lastProcessedTime: CFTimeInterval = 0

    func start() {
        guard !isRunning else { return }
        isRunning = true

        dragMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDragged) { [weak self] event in
            self?.handleDrag(event)
        }
        mouseUpMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp) { [weak self] event in
            self?.handleMouseUp(event)
        }
    }

    func stop() {
        if let dragMonitor { NSEvent.removeMonitor(dragMonitor) }
        if let mouseUpMonitor { NSEvent.removeMonitor(mouseUpMonitor) }
        dragMonitor = nil
        mouseUpMonitor = nil
        currentZone = nil
        currentScreen = nil
        previewOverlay?.dismiss()
        previewOverlay = nil
        isRunning = false
    }

    // MARK: - Private

    private func handleDrag(_ event: NSEvent) {
        // Throttle to ~60fps
        let now = CACurrentMediaTime()
        guard now - lastProcessedTime >= 0.016 else { return }
        lastProcessedTime = now

        let cursor = NSEvent.mouseLocation

        // Find which screen the cursor is on
        guard let screen = NSScreen.screens.first(where: { $0.frame.contains(cursor) }) else {
            clearZone()
            return
        }

        let zone = SnapZoneDetector.detect(cursor: cursor, in: screen.frame)

        // Early-out if zone unchanged
        if zone == currentZone && screen == currentScreen { return }

        currentZone = zone
        currentScreen = screen

        if let zone {
            let visibleFrame = ScreenDetector.visibleFrameInAX(for: screen)
            let targetFrame = SnapCalculator.calculate(action: zone.snapAction, visibleFrame: visibleFrame)
            // Convert AX frame back to NS for the overlay
            let nsFrame = ScreenDetector.axToNS(targetFrame)
            if previewOverlay == nil { previewOverlay = SnapPreviewOverlay() }
            previewOverlay?.show(frame: nsFrame)
        } else {
            previewOverlay?.dismiss()
        }
    }

    private func handleMouseUp(_ event: NSEvent) {
        guard let zone = currentZone, let screen = currentScreen else {
            clearZone()
            return
        }

        snapFrontmostWindow(action: zone.snapAction, screen: screen)
        clearZone()
    }

    private func clearZone() {
        currentZone = nil
        currentScreen = nil
        previewOverlay?.dismiss()
    }

    private func snapFrontmostWindow(action: SnapAction, screen: NSScreen) {
        guard let window = WindowElement.focusedWindow(),
              let currentFrame = window.frame else { return }

        let visibleFrame = ScreenDetector.visibleFrameInAX(for: screen)
        let targetFrame = SnapCalculator.calculate(
            action: action,
            visibleFrame: visibleFrame,
            currentFrame: currentFrame
        )
        window.setFrame(targetFrame)
    }
}
