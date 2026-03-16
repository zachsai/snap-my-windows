import AppKit

/// Displays a translucent overlay showing the snap destination during drag.
/// Reuses a single NSPanel instance to avoid allocation churn.
final class SnapPreviewOverlay {
    private var panel: NSPanel?

    func show(frame: CGRect) {
        if let panel {
            panel.setFrame(frame, display: true)
            panel.orderFront(nil)
            return
        }

        let panel = NSPanel(
            contentRect: frame,
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        panel.isOpaque = false
        panel.hasShadow = false
        panel.ignoresMouseEvents = true
        panel.level = .floating
        panel.backgroundColor = .clear
        panel.isReleasedWhenClosed = false

        let contentView = NSView(frame: panel.contentView!.bounds)
        contentView.autoresizingMask = [.width, .height]
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = Brand.NS.accent.withAlphaComponent(0.15).cgColor
        contentView.layer?.borderColor = Brand.NS.accent.withAlphaComponent(0.4).cgColor
        contentView.layer?.borderWidth = 2
        contentView.layer?.cornerRadius = 10
        panel.contentView?.addSubview(contentView)

        panel.orderFront(nil)
        self.panel = panel
    }

    func dismiss() {
        panel?.orderOut(nil)
    }
}
