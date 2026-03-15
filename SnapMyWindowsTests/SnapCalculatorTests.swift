import XCTest
@testable import SnapMyWindows

final class SnapCalculatorTests: XCTestCase {
    // Simulates a 1920x1080 screen with a 25px menu bar, in AX coordinates (top-left origin)
    let visibleFrame = CGRect(x: 0, y: 25, width: 1920, height: 1055)

    func testLeftHalf() {
        let result = SnapCalculator.calculate(action: .leftHalf, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 0, y: 25, width: 960, height: 1055))
    }

    func testRightHalf() {
        let result = SnapCalculator.calculate(action: .rightHalf, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 960, y: 25, width: 960, height: 1055))
    }

    func testTopLeft() {
        let result = SnapCalculator.calculate(action: .topLeft, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 0, y: 25, width: 960, height: 527.5))
    }

    func testTopRight() {
        let result = SnapCalculator.calculate(action: .topRight, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 960, y: 25, width: 960, height: 527.5))
    }

    func testBottomLeft() {
        let result = SnapCalculator.calculate(action: .bottomLeft, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 0, y: 552.5, width: 960, height: 527.5))
    }

    func testBottomRight() {
        let result = SnapCalculator.calculate(action: .bottomRight, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 960, y: 552.5, width: 960, height: 527.5))
    }

    func testMaximize() {
        let result = SnapCalculator.calculate(action: .maximize, visibleFrame: visibleFrame)
        XCTAssertEqual(result, visibleFrame)
    }

    func testCenter() {
        let currentFrame = CGRect(x: 100, y: 100, width: 800, height: 600)
        let result = SnapCalculator.calculate(action: .center, visibleFrame: visibleFrame, currentFrame: currentFrame)
        XCTAssertEqual(result, CGRect(x: 560, y: 252.5, width: 800, height: 600))
    }

    func testCenterWithoutCurrentFrameFallsBackToVisibleFrame() {
        let result = SnapCalculator.calculate(action: .center, visibleFrame: visibleFrame)
        XCTAssertEqual(result, visibleFrame)
    }

    // Test with an offset screen (e.g., secondary monitor)
    func testLeftHalfOnOffsetScreen() {
        let offsetFrame = CGRect(x: 1920, y: 0, width: 2560, height: 1440)
        let result = SnapCalculator.calculate(action: .leftHalf, visibleFrame: offsetFrame)
        XCTAssertEqual(result, CGRect(x: 1920, y: 0, width: 1280, height: 1440))
    }
}
