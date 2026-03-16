import XCTest
@testable import SnapMyWindows

final class SnapChainResolverTests: XCTestCase {
    // MARK: - Pure resolution table tests

    func testLeftThenTopResolvesToTopLeft() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .leftHalf, current: .topHalf), .topLeft)
    }

    func testLeftThenBottomResolvesToBottomLeft() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .leftHalf, current: .bottomHalf), .bottomLeft)
    }

    func testRightThenTopResolvesToTopRight() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .rightHalf, current: .topHalf), .topRight)
    }

    func testRightThenBottomResolvesToBottomRight() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .rightHalf, current: .bottomHalf), .bottomRight)
    }

    func testTopThenLeftResolvesToTopLeft() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .topHalf, current: .leftHalf), .topLeft)
    }

    func testTopThenRightResolvesToTopRight() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .topHalf, current: .rightHalf), .topRight)
    }

    func testBottomThenLeftResolvesToBottomLeft() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .bottomHalf, current: .leftHalf), .bottomLeft)
    }

    func testBottomThenRightResolvesToBottomRight() {
        XCTAssertEqual(SnapChainResolver.resolve(previous: .bottomHalf, current: .rightHalf), .bottomRight)
    }

    // MARK: - Non-chainable pairs return nil

    func testMaximizeThenLeftReturnsNil() {
        XCTAssertNil(SnapChainResolver.resolve(previous: .maximize, current: .leftHalf))
    }

    func testLeftThenLeftReturnsNil() {
        XCTAssertNil(SnapChainResolver.resolve(previous: .leftHalf, current: .leftHalf))
    }

    func testLeftThenRightReturnsNil() {
        XCTAssertNil(SnapChainResolver.resolve(previous: .leftHalf, current: .rightHalf))
    }

    func testTopThenBottomReturnsNil() {
        XCTAssertNil(SnapChainResolver.resolve(previous: .topHalf, current: .bottomHalf))
    }

    // MARK: - Stateful chain tests

    func testSingleActionSnapsDirectly() {
        let resolver = SnapChainResolver()
        var snapped: [SnapAction] = []
        resolver.snapHandler = { snapped.append($0) }

        resolver.handle(.leftHalf)

        XCTAssertEqual(snapped, [.leftHalf])
    }

    func testChainWithinTimeoutResolvesToCombined() {
        let resolver = SnapChainResolver()
        var snapped: [SnapAction] = []
        resolver.snapHandler = { snapped.append($0) }

        resolver.handle(.leftHalf)
        // Second action arrives immediately (within 500ms)
        resolver.handle(.topHalf)

        XCTAssertEqual(snapped, [.leftHalf, .topLeft])
    }

    func testChainAfterTimeoutDoesNotResolve() {
        let resolver = SnapChainResolver()
        var snapped: [SnapAction] = []
        resolver.snapHandler = { snapped.append($0) }

        resolver.handle(.leftHalf)
        // Simulate timeout by backdating
        resolver.setLastActionTime(Date().addingTimeInterval(-1.0))
        resolver.handle(.topHalf)

        // Should snap topHalf independently, not topLeft
        XCTAssertEqual(snapped, [.leftHalf, .topHalf])
    }

    func testStateResetsAfterChainResolves() {
        let resolver = SnapChainResolver()
        var snapped: [SnapAction] = []
        resolver.snapHandler = { snapped.append($0) }

        resolver.handle(.leftHalf)
        resolver.handle(.topHalf) // Resolves to topLeft

        // Third action should NOT chain with topLeft
        resolver.handle(.rightHalf)

        XCTAssertEqual(snapped, [.leftHalf, .topLeft, .rightHalf])
    }

    // MARK: - SnapCalculator geometry for topHalf/bottomHalf

    let visibleFrame = CGRect(x: 0, y: 25, width: 1920, height: 1055)

    func testTopHalfGeometry() {
        let result = SnapCalculator.calculate(action: .topHalf, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 0, y: 25, width: 1920, height: 527.5))
    }

    func testBottomHalfGeometry() {
        let result = SnapCalculator.calculate(action: .bottomHalf, visibleFrame: visibleFrame)
        XCTAssertEqual(result, CGRect(x: 0, y: 552.5, width: 1920, height: 527.5))
    }
}
