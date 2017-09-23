//
//  IndexLiteralTests.swift
//  IndexLiteral
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import IndexLiteralTests

extension IndexLiteralTests {

	static var allTests : [(String, (IndexLiteralTests) -> () throws -> Void)] {
		return [
			("testCodec", testCodec),
			("testDescription", testDescription),
			("testFunction", testFunction),
			("testValue", testValue),
		]
	}

}

XCTMain([
	testCase(IndexLiteralTests.allTests),
])

