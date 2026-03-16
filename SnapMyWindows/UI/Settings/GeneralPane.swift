import SwiftUI
import ServiceManagement

struct GeneralPane: View {
    @EnvironmentObject var appState: AppState
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 0) {
                Text("BEHAVIOR")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Brand.dark.opacity(0.5))
                    .padding(.bottom, 8)

                VStack(spacing: 0) {
                    toggleRow("Drag to Snap", isOn: $appState.dragSnapEnabled, subtitle: "Snap windows by dragging to screen edges")
                        .onChange(of: appState.dragSnapEnabled) { _ in
                            appState.updateDragSnapState()
                        }

                    Divider()
                        .background(Brand.dark.opacity(0.2))

                    toggleRow("Launch at Login", isOn: $launchAtLogin, subtitle: "Start Snap My Windows when you log in")
                        .onChange(of: launchAtLogin) { newValue in
                            if newValue {
                                try? SMAppService.mainApp.register()
                            } else {
                                try? SMAppService.mainApp.unregister()
                            }
                        }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Brand.dark.opacity(0.3), lineWidth: 1)
                )
            }

            Spacer()
        }
        .padding(24)
    }

    private func toggleRow(_ title: String, isOn: Binding<Bool>, subtitle: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(Brand.dark)
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(Brand.dark.opacity(0.5))
            }
            Spacer()
            Toggle("", isOn: isOn)
                .toggleStyle(.switch)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
    }
}
