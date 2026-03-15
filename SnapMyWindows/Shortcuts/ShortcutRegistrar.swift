import KeyboardShortcuts

enum ShortcutRegistrar {
    static func registerAll() {
        KeyboardShortcuts.onKeyUp(for: .snapLeftHalf) { WindowSnapper.snap(.leftHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapRightHalf) { WindowSnapper.snap(.rightHalf) }
        KeyboardShortcuts.onKeyUp(for: .snapTopLeft) { WindowSnapper.snap(.topLeft) }
        KeyboardShortcuts.onKeyUp(for: .snapTopRight) { WindowSnapper.snap(.topRight) }
        KeyboardShortcuts.onKeyUp(for: .snapBottomLeft) { WindowSnapper.snap(.bottomLeft) }
        KeyboardShortcuts.onKeyUp(for: .snapBottomRight) { WindowSnapper.snap(.bottomRight) }
        KeyboardShortcuts.onKeyUp(for: .snapMaximize) { WindowSnapper.snap(.maximize) }
        KeyboardShortcuts.onKeyUp(for: .snapCenter) { WindowSnapper.snap(.center) }
        KeyboardShortcuts.onKeyUp(for: .snapLeftThird) { WindowSnapper.snap(.leftThird) }
        KeyboardShortcuts.onKeyUp(for: .snapCenterThird) { WindowSnapper.snap(.centerThird) }
        KeyboardShortcuts.onKeyUp(for: .snapRightThird) { WindowSnapper.snap(.rightThird) }
        KeyboardShortcuts.onKeyUp(for: .snapLeftTwoThirds) { WindowSnapper.snap(.leftTwoThirds) }
        KeyboardShortcuts.onKeyUp(for: .snapRightTwoThirds) { WindowSnapper.snap(.rightTwoThirds) }
    }
}
