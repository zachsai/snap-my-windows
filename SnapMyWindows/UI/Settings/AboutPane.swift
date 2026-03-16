import SwiftUI

struct AboutPane: View {
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 22))

            Text("Snap My Windows")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Brand.dark)

            Text("Version \(version)")
                .font(.system(size: 12))
                .foregroundColor(Brand.dark.opacity(0.5))

            Text("by Zachs AI")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Brand.accent)

            Spacer()

            Text("Free and open-source window management for macOS")
                .font(.system(size: 11))
                .foregroundColor(Brand.dark.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
    }
}
