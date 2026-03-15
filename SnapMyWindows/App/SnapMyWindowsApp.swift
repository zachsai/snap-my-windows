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
    private var pollTimer: Timer?
    private var settingsWindow: NSWindow?

    init() {
        isAccessibilityGranted = AccessibilityChecker.isTrusted()
        ShortcutRegistrar.registerAll()

        if !isAccessibilityGranted {
            startPolling()
        }
    }

    func openSettings() {
        if let window = settingsWindow {
            window.makeKeyAndOrderFront(nil)
        } else {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 450, height: 300),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            window.title = "Snap My Windows Settings"
            window.contentViewController = NSHostingController(rootView: SettingsView())
            window.center()
            window.isReleasedWhenClosed = false
            settingsWindow = window
            window.makeKeyAndOrderFront(nil)
        }
        NSApp.activate(ignoringOtherApps: true)
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
                }
                timer.invalidate()
                self.pollTimer = nil
            }
        }
    }
}
