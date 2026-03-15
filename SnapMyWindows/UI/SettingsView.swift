import SwiftUI
import KeyboardShortcuts
import ServiceManagement

struct SettingsView: View {
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled

    var body: some View {
        Form {
            Section("Shortcuts") {
                ForEach(ShortcutMapping.all, id: \.name) { mapping in
                    HStack {
                        Text(mapping.label)
                            .frame(width: 120, alignment: .trailing)
                        KeyboardShortcuts.Recorder(for: mapping.name)
                    }
                }
            }

            Section("General") {
                Toggle("Launch at Login", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin) { newValue in
                        if newValue {
                            try? SMAppService.mainApp.register()
                        } else {
                            try? SMAppService.mainApp.unregister()
                        }
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
        .init(label: "Left Third", name: .snapLeftThird),
        .init(label: "Center Third", name: .snapCenterThird),
        .init(label: "Right Third", name: .snapRightThird),
        .init(label: "Left Two Thirds", name: .snapLeftTwoThirds),
        .init(label: "Right Two Thirds", name: .snapRightTwoThirds),
    ]
}
