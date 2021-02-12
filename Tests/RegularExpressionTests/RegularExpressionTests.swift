//
//  RegularExpressionTests.swift
//  RegularExpressionTests
//
//  Created by Galen Rhodes on 2/11/21.
//

import XCTest
@testable import RegularExpression

class RegularExpressionTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testRegularExpression() throws {
        let str = "Now is the time for all good men to come to the aid of their country."

        if let rx = RegularExpression(pattern: "\\b(\\S+)") {
            rx.forEachMatchString(in: str) { s in
                if let str = s[1] { print("> \"\(str)\"") }
                return false
            }
        }
        else {
            XCTFail("Malformed Regular Expression Pattern.")
        }
    }

}
