//
//  legalbookwormTests.swift
//  legalbookwormTests
//
//  Created by Stefan Zapf on 17.03.21.
//

import XCTest
@testable import legalbookworm

class legalbookwormTests: XCTestCase {

    func testWordTokens() throws {
        let exampleInput = Substring("hello world\nhello Mars\nHello Epstein Drive")

        let actual = TokenizedString.wordTokens(from: exampleInput)
        let expected = [Substring("hello"), Substring("world"), Substring("hello"), Substring("Mars"), Substring("Hello"), Substring("Epstein"), Substring("Drive")]
        let equal = actual == expected
        XCTAssertTrue(equal)
    }
    
    func testTokenizedStringSpiderman() throws {
        let wordToBeTokenized = [Substring("Spiderman")]

        let actual = TokenizedString.wordpieceTokens(from: wordToBeTokenized)
        let expected = ([Substring("Spider"), Substring("man")], [8454, 1399])
        
        let equal = actual == expected
        XCTAssertTrue(equal)
    }
    
    func testTokenizedStringLasercat() throws {
        let wordToBeTokenized = [Substring("Lasercat")]

        let actual = TokenizedString.wordpieceTokens(from: wordToBeTokenized)
        let expected = ([Substring("Las"), Substring("er"), Substring("cat")], [5976, 1200, 12650])
        
        let equal = actual == expected
        XCTAssertTrue(equal)
    }
    
    func testTokenizedStringYourName() throws {
        let wordToBeTokenized = Substring("Till Lohfink")
        
        let wordTokens = TokenizedString.wordTokens(from: wordToBeTokenized)
        let actual = TokenizedString.wordpieceTokens(from: wordTokens)
        print(actual)

        
        let expected = ([Substring("Till"), Substring("Lo"), Substring("h"), Substring("fin"), Substring("k")], [22430, 10605, 1324, 16598, 1377])
        
        let equal = actual == expected
        XCTAssertTrue(equal)
    }

    func testFindMaxLogit() throws {
        
        // Wikipedia contributors, "Perseverance (rover)," Wikipedia, The Free Encyclopedia, https://en.wikipedia.org/w/index.php?title=Perseverance_(rover)&oldid=1013350314 (accessed March 23, 2021).
        let text = "Perseverance has a similar design to its predecessor rover, Curiosity, from which it was moderately upgraded. It carries seven primary payload instruments, 19 cameras, and two microphones. The rover is also carrying the mini-helicopter Ingenuity, or Ginny, an experimental aircraft and technology showcase that will attempt the first powered flight on another planet."
        
        let question = "Who is Perseverance carrying?"
        let expected = "mini-helicopter Ingenuity"

        
        let distilbert = DistilBert()
        let actual = distilbert.findAnswer(for: question, in: text)
        
        let equal = actual == expected
        XCTAssertTrue(equal)
    }

}