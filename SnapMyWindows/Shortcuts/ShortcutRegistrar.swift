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
    }
}
