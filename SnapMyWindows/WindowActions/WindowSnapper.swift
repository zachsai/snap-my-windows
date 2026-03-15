import Foundation

/// Orchestrates the full snap flow: get focused window → detect screen → calculate target → resize.
enum WindowSnapper {
    static func snap(_ action: SnapAction) {
        guard AccessibilityChecker.isTrusted() else {
            AccessibilityChecker.promptIfNeeded()
            return
        }

        guard let window = WindowElement.focusedWindow(),
              let currentFrame = window.frame else {
            return
        }

        let screen = ScreenDetector.screen(for: currentFrame)
        let visibleFrame = ScreenDetector.visibleFrameInAX(for: screen)
        let targetFrame = SnapCalculator.calculate(
            action: action,
            visibleFrame: visibleFrame,
            currentFrame: currentFrame
        )

        window.setFrame(targetFrame)
    }
}
