import Foundation

/// Detects rapid sequential shortcut presses and resolves them into combined actions.
/// E.g., Left Half → Top Half within 500ms = Top Left quarter.
final class SnapChainResolver {
    static let shared = SnapChainResolver()

    private static let chainTimeout: TimeInterval = 0.5

    private var lastAction: SnapAction?
    private var lastActionTime: Date?

    var snapHandler: (SnapAction) -> Void = { WindowSnapper.snap($0) }

    /// Look up chain resolution table. Pure function — no side effects.
    static func resolve(previous: SnapAction, current: SnapAction) -> SnapAction? {
        switch (previous, current) {
        case (.leftHalf, .topHalf), (.topHalf, .leftHalf):
            return .topLeft
        case (.leftHalf, .bottomHalf), (.bottomHalf, .leftHalf):
            return .bottomLeft
        case (.rightHalf, .topHalf), (.topHalf, .rightHalf):
            return .topRight
        case (.rightHalf, .bottomHalf), (.bottomHalf, .rightHalf):
            return .bottomRight
        default:
            return nil
        }
    }

    func handle(_ action: SnapAction) {
        let now = Date()

        if let previous = lastAction,
           let previousTime = lastActionTime,
           now.timeIntervalSince(previousTime) < Self.chainTimeout,
           let combined = Self.resolve(previous: previous, current: action) {
            // Chain resolved — snap to combined action and reset
            lastAction = nil
            lastActionTime = nil
            snapHandler(combined)
        } else {
            // No chain — snap directly and store as potential chain start
            lastAction = action
            lastActionTime = now
            snapHandler(action)
        }
    }

    /// Reset state (useful for testing).
    func reset() {
        lastAction = nil
        lastActionTime = nil
    }

    /// Override the last action time (for testing timeout behavior).
    func setLastActionTime(_ date: Date) {
        lastActionTime = date
    }
}
