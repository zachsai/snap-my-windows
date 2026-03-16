import SwiftUI
import AppKit

enum Brand {
    static let accent = Color(hex: 0x7BFF00)
    static let light = Color(hex: 0xF1F1F1)
    static let dark = Color(hex: 0x221A10)
    static let navy = Color(hex: 0x06024C)
    static let variant = Color(hex: 0x0C0472)

    enum NS {
        static let accent = NSColor(red: 0x7B / 255, green: 0xFF / 255, blue: 0x00 / 255, alpha: 1)
    }
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
