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

        Settings {
            SettingsView()
        }
    }
}

final class AppState: ObservableObject {
    @Published var isAccessibilityGranted: Bool = false
    private var pollTimer: Timer?

    init() {
        isAccessibilityGranted = AccessibilityChecker.isTrusted()
        ShortcutRegistrar.registerAll()

        if !isAccessibilityGranted {
            startPolling()
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
                }
                timer.invalidate()
                self.pollTimer = nil
            }
        }
    }
}
