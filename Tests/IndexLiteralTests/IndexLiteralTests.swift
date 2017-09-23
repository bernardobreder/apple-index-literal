//
//  IndexLiteralTests.swift
//  IndexLiteral
//
//  Created by Bernardo Breder on 21/01/17.
//
//

import XCTest
@testable import IndexLiteral

class IndexLiteralTests: XCTestCase {
    
    func testValue() throws {
        XCTAssertEqual("abc", IndexLiteral("abc").string)
        XCTAssertEqual(1, IndexLiteral(1).int)
        
        XCTAssertNil(IndexLiteral(1).string)
        XCTAssertNil(IndexLiteral("a").int)
        
        XCTAssertTrue(IndexLiteral("abc").isString)
        XCTAssertTrue(IndexLiteral(1).isInt)
        
        XCTAssertFalse(IndexLiteral(1).isString)
        XCTAssertFalse(IndexLiteral("a").isInt)
    }
    
    func testFunction() {
        var count = 0
        
        IndexLiteral("abc").string { _ in count += 1 }
        IndexLiteral(1).int { _ in count += 1 }
        
        XCTAssertEqual(2, count)
        
        IndexLiteral(1).string { _ in count += 1 }
        IndexLiteral("a").int { _ in count += 1 }
        
        XCTAssertEqual(2, count)
    }

    func testCodec() throws {
        XCTAssertEqual(IndexLiteral(1), try IndexLiteral(encoded: IndexLiteral(1).encode()))
        XCTAssertEqual(IndexLiteral("ação"), try IndexLiteral(encoded: IndexLiteral("ação").encode()))
    }
    
    func testDescription() throws {
        XCTAssertEqual("abc", IndexLiteral("abc").description)
        XCTAssertEqual("1", IndexLiteral(1).description)
        
        XCTAssertEqual("abc", IndexLiteral("abc").debugDescription)
        XCTAssertEqual("1", IndexLiteral(1).debugDescription)
    }

}
