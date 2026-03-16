import XCTest
@testable import SnapMyWindows

final class SnapZoneDetectorTests: XCTestCase {
    // Simulates a 1920x1080 screen in NS coordinates (bottom-left origin)
    let screenFrame = CGRect(x: 0, y: 0, width: 1920, height: 1080)

    // MARK: - Edges

    func testCursorAtLeftEdgeMiddle() {
        let cursor = CGPoint(x: 2, y: 540)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .leftHalf)
    }

    func testCursorAtRightEdgeMiddle() {
        let cursor = CGPoint(x: 1918, y: 540)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .rightHalf)
    }

    // MARK: - Corners

    func testCursorAtTopLeftCorner() {
        let cursor = CGPoint(x: 2, y: 1060)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .topLeft)
    }

    func testCursorAtTopRightCorner() {
        let cursor = CGPoint(x: 1918, y: 1060)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .topRight)
    }

    func testCursorAtBottomLeftCorner() {
        let cursor = CGPoint(x: 2, y: 20)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .bottomLeft)
    }

    func testCursorAtBottomRightCorner() {
        let cursor = CGPoint(x: 1918, y: 20)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .bottomRight)
    }

    // MARK: - No zone

    func testCursorInCenter() {
        let cursor = CGPoint(x: 960, y: 540)
        XCTAssertNil(SnapZoneDetector.detect(cursor: cursor, in: screenFrame))
    }

    func testCursorAtTopEdgeOnly() {
        // At top edge but not near left/right — should NOT trigger
        let cursor = CGPoint(x: 960, y: 1078)
        XCTAssertNil(SnapZoneDetector.detect(cursor: cursor, in: screenFrame))
    }

    func testCursorAtBottomEdgeOnly() {
        // At bottom edge but not near left/right — should NOT trigger
        let cursor = CGPoint(x: 960, y: 2)
        XCTAssertNil(SnapZoneDetector.detect(cursor: cursor, in: screenFrame))
    }

    // MARK: - Threshold boundary

    func testCursorJustOutsideLeftEdge() {
        // Exactly at threshold — should NOT trigger (distance == threshold, not <)
        let cursor = CGPoint(x: 6, y: 540)
        XCTAssertNil(SnapZoneDetector.detect(cursor: cursor, in: screenFrame))
    }

    func testCursorJustInsideLeftEdge() {
        let cursor = CGPoint(x: 5, y: 540)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .leftHalf)
    }

    func testCursorJustOutsideRightEdge() {
        let cursor = CGPoint(x: 1914, y: 540)
        XCTAssertNil(SnapZoneDetector.detect(cursor: cursor, in: screenFrame))
    }

    func testCursorJustInsideRightEdge() {
        let cursor = CGPoint(x: 1915, y: 540)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: screenFrame), .rightHalf)
    }

    // MARK: - Secondary monitor with offset origin

    func testLeftHalfOnSecondaryMonitor() {
        let secondaryFrame = CGRect(x: 1920, y: 0, width: 2560, height: 1440)
        let cursor = CGPoint(x: 1922, y: 720)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: secondaryFrame), .leftHalf)
    }

    func testTopRightCornerOnSecondaryMonitor() {
        let secondaryFrame = CGRect(x: 1920, y: 0, width: 2560, height: 1440)
        let cursor = CGPoint(x: 4478, y: 1420)
        XCTAssertEqual(SnapZoneDetector.detect(cursor: cursor, in: secondaryFrame), .topRight)
    }

    // MARK: - SnapZone to SnapAction mapping

    func testSnapZoneActions() {
        XCTAssertEqual(SnapZone.leftHalf.snapAction, .leftHalf)
        XCTAssertEqual(SnapZone.rightHalf.snapAction, .rightHalf)
        XCTAssertEqual(SnapZone.topLeft.snapAction, .topLeft)
        XCTAssertEqual(SnapZone.topRight.snapAction, .topRight)
        XCTAssertEqual(SnapZone.bottomLeft.snapAction, .bottomLeft)
        XCTAssertEqual(SnapZone.bottomRight.snapAction, .bottomRight)
    }
}
