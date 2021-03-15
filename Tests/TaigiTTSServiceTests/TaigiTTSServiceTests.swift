import XCTest
@testable import TaigiTTSService

final class TaigiTTSServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(TaigiTTSService().text, "Hello, World!")
        
        let expectation = XCTestExpectation(description: "asdf")
        TaigiTTSService.player(for: "li-ho") { player in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 120)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
