import XCTest
@testable import SoulEcho

final class SoulEchoTests: XCTestCase {
    func testUIColorExtension() throws {
        let color = UIColor(hex: "#FCD34D")
        XCTAssertNotNil(color)
        let invalid = UIColor(hex: "invalid")
        XCTAssertNil(invalid)
    }

    func testAppDelegateInit() throws {
        let appDelegate = AppDelegate()
        XCTAssertNotNil(appDelegate)
    }

    func testSceneDelegateInit() throws {
        let sceneDelegate = SceneDelegate()
        XCTAssertNotNil(sceneDelegate)
    }
}
