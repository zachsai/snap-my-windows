import CoreGraphics

/// Represents a screen edge/corner zone that triggers a snap action during drag.
enum SnapZone: Equatable {
    case leftHalf, rightHalf, topLeft, topRight, bottomLeft, bottomRight

    var snapAction: SnapAction {
        switch self {
        case .leftHalf: return .leftHalf
        case .rightHalf: return .rightHalf
        case .topLeft: return .topLeft
        case .topRight: return .topRight
        case .bottomLeft: return .bottomLeft
        case .bottomRight: return .bottomRight
        }
    }
}

/// Pure geometry: detects which snap zone a cursor position falls in relative to a screen frame.
/// Works in NS coordinates (bottom-left origin) since NSEvent.mouseLocation uses that system.
enum SnapZoneDetector {
    static let edgeThreshold: CGFloat = 6
    static let cornerThreshold: CGFloat = 50

    /// Detect zone for cursor position within a screen frame (NS coordinates).
    /// Returns nil if cursor is not near any snap-triggering edge.
    static func detect(cursor: CGPoint, in screenFrame: CGRect) -> SnapZone? {
        let nearLeft = cursor.x - screenFrame.minX < edgeThreshold
        let nearRight = screenFrame.maxX - cursor.x < edgeThreshold
        let nearTop = screenFrame.maxY - cursor.y < cornerThreshold
        let nearBottom = cursor.y - screenFrame.minY < cornerThreshold

        // Corners take priority over edges
        if nearLeft && nearTop { return .topLeft }
        if nearRight && nearTop { return .topRight }
        if nearLeft && nearBottom { return .bottomLeft }
        if nearRight && nearBottom { return .bottomRight }

        // Edges (only left/right — top/bottom alone don't trigger)
        if nearLeft { return .leftHalf }
        if nearRight { return .rightHalf }

        return nil
    }
}
