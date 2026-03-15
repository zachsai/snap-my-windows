import SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    var body: some View {
        Form {
            ForEach(ShortcutMapping.all, id: \.name) { mapping in
                HStack {
                    Text(mapping.label)
                        .frame(width: 120, alignment: .trailing)
                    KeyboardShortcuts.Recorder(for: mapping.name)
                }
            }
        }
        .padding()
        .frame(width: 340)
    }
}

private struct ShortcutMapping {
    let label: String
    let name: KeyboardShortcuts.Name

    static let all: [ShortcutMapping] = [
        .init(label: "Left Half", name: .snapLeftHalf),
        .init(label: "Right Half", name: .snapRightHalf),
        .init(label: "Top Left", name: .snapTopLeft),
        .init(label: "Top Right", name: .snapTopRight),
        .init(label: "Bottom Left", name: .snapBottomLeft),
        .init(label: "Bottom Right", name: .snapBottomRight),
        .init(label: "Maximize", name: .snapMaximize),
        .init(label: "Center", name: .snapCenter),
    ]
}
