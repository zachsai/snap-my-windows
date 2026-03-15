import SwiftUI
import KeyboardShortcuts

struct MenuBarView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if !appState.isAccessibilityGranted {
            Button("Grant Accessibility Access…") {
                AccessibilityChecker.promptIfNeeded()
            }
            Divider()
        }

        ForEach(SnapAction.allCases) { action in
            Button(action.displayName) {
                WindowSnapper.snap(action)
            }
            .keyboardShortcut(action.keyEquivalent, modifiers: action.modifiers)
        }

        Divider()

        Button("Quit") {
            NSApplication.shared.terminate(nil)
        }
        .keyboardShortcut("q")
    }
}

private extension SnapAction {
    var keyEquivalent: KeyEquivalent {
        switch self {
        case .leftHalf: return .leftArrow
        case .rightHalf: return .rightArrow
        case .topLeft: return "u"
        case .topRight: return "i"
        case .bottomLeft: return "j"
        case .bottomRight: return "k"
        case .maximize: return .return
        case .center: return "c"
        }
    }

    var modifiers: EventModifiers {
        [.command, .option]
    }
}
