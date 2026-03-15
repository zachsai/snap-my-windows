import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let snapLeftHalf = Self("snapLeftHalf", default: .init(.leftArrow, modifiers: [.command, .option]))
    static let snapRightHalf = Self("snapRightHalf", default: .init(.rightArrow, modifiers: [.command, .option]))
    static let snapTopLeft = Self("snapTopLeft", default: .init(.u, modifiers: [.command, .option]))
    static let snapTopRight = Self("snapTopRight", default: .init(.i, modifiers: [.command, .option]))
    static let snapBottomLeft = Self("snapBottomLeft", default: .init(.j, modifiers: [.command, .option]))
    static let snapBottomRight = Self("snapBottomRight", default: .init(.k, modifiers: [.command, .option]))
    static let snapMaximize = Self("snapMaximize", default: .init(.return, modifiers: [.command, .option]))
    static let snapCenter = Self("snapCenter", default: .init(.c, modifiers: [.command, .option]))
    static let snapLeftThird = Self("snapLeftThird", default: .init(.d, modifiers: [.command, .option]))
    static let snapCenterThird = Self("snapCenterThird", default: .init(.f, modifiers: [.command, .option]))
    static let snapRightThird = Self("snapRightThird", default: .init(.g, modifiers: [.command, .option]))
    static let snapLeftTwoThirds = Self("snapLeftTwoThirds", default: .init(.e, modifiers: [.command, .option]))
    static let snapRightTwoThirds = Self("snapRightTwoThirds", default: .init(.t, modifiers: [.command, .option]))
}
