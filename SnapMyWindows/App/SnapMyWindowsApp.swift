import SwiftUI
import KeyboardShortcuts

@main
struct SnapMyWindowsApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra("Snap My Windows", systemImage: "rectangle.split.2x1") {
            MenuBarView()
                .environmentObject(appState)
        }
    }
}

final class AppState: ObservableObject {
    @Published var isAccessibilityGranted: Bool = false
    @AppStorage("dragSnapEnabled") var dragSnapEnabled: Bool = true
    private var pollTimer: Timer?
    private var settingsWindow: NSWindow?
    private let dragSnapMonitor = DragSnapMonitor()
    init() {
        isAccessibilityGranted = AccessibilityChecker.isTrusted()
        ShortcutRegistrar.registerAll()
        updateDragSnapState()

        if !isAccessibilityGranted {
            startPolling()
        }
    }

    func updateDragSnapState() {
        if dragSnapEnabled && isAccessibilityGranted {
            dragSnapMonitor.start()
        } else {
            dragSnapMonitor.stop()
        }
    }

    func openSettings() {

        NSApp.setActivationPolicy(.regular)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            NSApp.activate(ignoringOtherApps: true)

            if let window = settingsWindow {
                window.orderFrontRegardless()
            } else {
                let window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 650, height: 450),
                    styleMask: [.titled, .closable],
                    backing: .buffered,
                    defer: false
                )
                window.title = "Snap My Windows Settings"
                window.contentViewController = NSHostingController(rootView: SettingsView().environmentObject(self))
                window.center()
                window.isReleasedWhenClosed = false
                window.orderFrontRegardless()
                settingsWindow = window

                NotificationCenter.default.addObserver(
                    forName: NSWindow.willCloseNotification,
                    object: window,
                    queue: .main
                ) { _ in
                    NSApp.setActivationPolicy(.accessory)
                }
            }
        }
    }

    private func startPolling() {
        pollTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            if AccessibilityChecker.isTrusted() {
                DispatchQueue.main.async {
                    self.isAccessibilityGranted = true
                    self.updateDragSnapState()
                }
                timer.invalidate()
                self.pollTimer = nil
            }
        }
    }
}
