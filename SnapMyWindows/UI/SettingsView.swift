import SwiftUI

enum SettingsTab: String, CaseIterable {
    case shortcuts = "Shortcuts"
    case general = "General"
    case about = "About"

    var icon: String {
        switch self {
        case .shortcuts: return "keyboard"
        case .general: return "gearshape"
        case .about: return "info.circle"
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: SettingsTab = .shortcuts

    var body: some View {
        HStack(spacing: 0) {
            sidebar
            content
        }
        .frame(width: 650, height: 450)
    }

    private var sidebar: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Settings")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 12)

            ForEach(SettingsTab.allCases, id: \.self) { tab in
                sidebarButton(tab)
            }

            Spacer()

            Button {
                NSWorkspace.shared.open(URL(string: "https://www.zachsai.com")!)
            } label: {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .onHover { hovering in
                if hovering {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 4)

            Text("Snap My Windows")
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.3))
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .frame(width: 170)
        .background(Brand.navy)
    }

    private func sidebarButton(_ tab: SettingsTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            HStack(spacing: 8) {
                Image(systemName: tab.icon)
                    .font(.system(size: 12))
                    .frame(width: 16)
                Text(tab.rawValue)
                    .font(.system(size: 13, weight: selectedTab == tab ? .semibold : .regular))
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                selectedTab == tab
                    ? Brand.accent.opacity(0.15)
                    : Color.clear
            )
            .foregroundColor(selectedTab == tab ? Brand.accent : .white.opacity(0.8))
            .cornerRadius(6)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 8)
    }

    @ViewBuilder
    private var content: some View {
        Group {
            switch selectedTab {
            case .shortcuts:
                ShortcutsPane()
            case .general:
                GeneralPane()
                    .environmentObject(appState)
            case .about:
                AboutPane()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Brand.light)
    }
}
