import SwiftUI
import KeyboardShortcuts

struct ShortcutsPane: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                shortcutSection("Halves", shortcuts: [
                    ("Left Half", .snapLeftHalf),
                    ("Right Half", .snapRightHalf),
                    ("Top Half", .snapTopHalf),
                    ("Bottom Half", .snapBottomHalf),
                ])

                shortcutSection("Quarters", shortcuts: [
                    ("Top Left", .snapTopLeft),
                    ("Top Right", .snapTopRight),
                    ("Bottom Left", .snapBottomLeft),
                    ("Bottom Right", .snapBottomRight),
                ])

                shortcutSection("Thirds", shortcuts: [
                    ("Left Third", .snapLeftThird),
                    ("Center Third", .snapCenterThird),
                    ("Right Third", .snapRightThird),
                    ("Left Two Thirds", .snapLeftTwoThirds),
                    ("Right Two Thirds", .snapRightTwoThirds),
                ])

                shortcutSection("Other", shortcuts: [
                    ("Maximize", .snapMaximize),
                    ("Center", .snapCenter),
                ])
            }
            .padding(24)
        }
    }

    private func shortcutSection(_ title: String, shortcuts: [(String, KeyboardShortcuts.Name)]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(Brand.dark.opacity(0.5))
                .textCase(.uppercase)
                .padding(.bottom, 8)

            VStack(spacing: 0) {
                ForEach(Array(shortcuts.enumerated()), id: \.element.1.rawValue) { index, item in
                    HStack {
                        Text(item.0)
                            .font(.system(size: 13))
                            .foregroundColor(Brand.dark)
                        Spacer()
                        KeyboardShortcuts.Recorder(for: item.1)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)

                    if index < shortcuts.count - 1 {
                        Divider()
                            .background(Brand.dark.opacity(0.2))
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Brand.dark.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
