import SwiftUI
import KeyboardShortcuts

struct MenuBarView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if !AccessibilityChecker.isTrusted() {
            Text("Snap My Windows needs Accessibility\naccess to move and resize windows.")
                .font(.caption)
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

        Button("Settings…") {
            appState.openSettings()
        }

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
        case .topHalf: return .upArrow
        case .bottomHalf: return .downArrow
        case .topLeft: return "u"
        case .topRight: return "i"
        case .bottomLeft: return "j"
        case .bottomRight: return "k"
        case .maximize: return .return
        case .center: return "c"
        case .leftThird: return "d"
        case .centerThird: return "f"
        case .rightThird: return "g"
        case .leftTwoThirds: return "e"
        case .rightTwoThirds: return "t"
        }
    }

    var modifiers: EventModifiers {
        [.command, .option]
    }
}
