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

    init() {
        isAccessibilityGranted = AccessibilityChecker.isTrusted()
        ShortcutRegistrar.registerAll()
    }
}
