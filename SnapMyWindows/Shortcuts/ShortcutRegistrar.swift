import KeyboardShortcuts

enum ShortcutRegistrar {
    static func registerAll() {
        KeyboardShortcuts.onKeyUp(for: .snapLeftHalf) { SnapChainResolver.shared.handle(.leftHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapRightHalf) { SnapChainResolver.shared.handle(.rightHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapTopHalf) { SnapChainResolver.shared.handle(.topHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapBottomHalf) { SnapChainResolver.shared.handle(.bottomHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapTopLeft) { SnapChainResolver.shared.handle(.topLeft) }
        KeyboardShortcuts.onKeyUp(for: .snapTopRight) { SnapChainResolver.shared.handle(.topRight) }
        KeyboardShortcuts.onKeyUp(for: .snapBottomLeft) { SnapChainResolver.shared.handle(.bottomLeft) }
        KeyboardShortcuts.onKeyUp(for: .snapBottomRight) { SnapChainResolver.shared.handle(.bottomRight) }
        KeyboardShortcuts.onKeyUp(for: .snapMaximize) { SnapChainResolver.shared.handle(.maximize) }
        KeyboardShortcuts.onKeyUp(for: .snapCenter) { SnapChainResolver.shared.handle(.center) }
        KeyboardShortcuts.onKeyUp(for: .snapLeftThird) { SnapChainResolver.shared.handle(.leftThird) }
        KeyboardShortcuts.onKeyUp(for: .snapCenterThird) { SnapChainResolver.shared.handle(.centerThird) }
        KeyboardShortcuts.onKeyUp(for: .snapRightThird) { SnapChainResolver.shared.handle(.rightThird) }
        KeyboardShortcuts.onKeyUp(for: .snapLeftTwoThirds) { SnapChainResolver.shared.handle(.leftTwoThirds) }
        KeyboardShortcuts.onKeyUp(for: .snapRightTwoThirds) { SnapChainResolver.shared.handle(.rightTwoThirds) }
    }
}
