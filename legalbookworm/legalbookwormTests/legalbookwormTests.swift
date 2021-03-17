//
//  legalbookwormTests.swift
//  legalbookwormTests
//
//  Created by Stefan Zapf on 17.03.21.
//

import XCTest
@testable import legalbookworm

class legalbookwormTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let exampleInput = "hello world\nhello Mars\nHello Epstein Drive"

        let actual = TokenizedString.wordTokens(from: exampleInput)
        let expected = [Substring("hello"), Substring("world"), Substring("hello"), Substring("Mars"), Substring("Hello"), Substring("Epstein"), Substring("Drive")]
        let equal = actual == expected
        XCTAssertTrue(equal)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
