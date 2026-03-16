import CoreGraphics

/// Pure geometry: given a snap action and a screen's visible frame (in AX coordinates),
/// returns the target window frame.
enum SnapCalculator {
    static func calculate(action: SnapAction, visibleFrame: CGRect, currentFrame: CGRect? = nil) -> CGRect {
        let x = visibleFrame.origin.x
        let y = visibleFrame.origin.y
        let w = visibleFrame.width
        let h = visibleFrame.height

        switch action {
        case .leftHalf:
            return CGRect(x: x, y: y, width: w / 2, height: h)
        case .rightHalf:
            return CGRect(x: x + w / 2, y: y, width: w / 2, height: h)
        case .topHalf:
            return CGRect(x: x, y: y, width: w, height: h / 2)
        case .bottomHalf:
            return CGRect(x: x, y: y + h / 2, width: w, height: h / 2)
        case .topLeft:
            return CGRect(x: x, y: y, width: w / 2, height: h / 2)
        case .topRight:
            return CGRect(x: x + w / 2, y: y, width: w / 2, height: h / 2)
        case .bottomLeft:
            return CGRect(x: x, y: y + h / 2, width: w / 2, height: h / 2)
        case .bottomRight:
            return CGRect(x: x + w / 2, y: y + h / 2, width: w / 2, height: h / 2)
        case .maximize:
            return visibleFrame
        case .center:
            guard let current = currentFrame else { return visibleFrame }
            let cx = x + (w - current.width) / 2
            let cy = y + (h - current.height) / 2
            return CGRect(x: cx, y: cy, width: current.width, height: current.height)
        case .leftThird:
            return CGRect(x: x, y: y, width: w / 3, height: h)
        case .centerThird:
            return CGRect(x: x + w / 3, y: y, width: w / 3, height: h)
        case .rightThird:
            return CGRect(x: x + 2 * w / 3, y: y, width: w / 3, height: h)
        case .leftTwoThirds:
            return CGRect(x: x, y: y, width: 2 * w / 3, height: h)
        case .rightTwoThirds:
            return CGRect(x: x + w / 3, y: y, width: 2 * w / 3, height: h)
        }
    }
}
