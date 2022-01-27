//
//  URLExtensionsTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 25.10.21.
//

import XCTest
import Combine
@testable import HapticMap

class URLExtensionsTests: XCTestCase {

    func testHumanReadableNameWorksWithUnderscores() throws {
        let name = "Test_Name"
        let url = URL(fileURLWithPath: name)
        XCTAssertEqual(url.humanReadableName, "Test Name")
    }
    
    func testHumanReadableNameWorksWithHyphen() throws {
        let name = "Test-Name"
        let url = URL(fileURLWithPath: name)
        XCTAssertEqual(url.humanReadableName, "Test Name")
    }
    
    func testHumanReadableNameWorksWithSpaces() throws {
        let name = "Test Name"
        let url = URL(fileURLWithPath: name)
        XCTAssertEqual(url.humanReadableName, "Test Name")
    }
    
    func testHumanReadableNameCapitalizeCorrectly() throws {
        let name = "tEsT NaME"
        let url = URL(fileURLWithPath: name)
        XCTAssertEqual(url.humanReadableName, "Test Name")
    }

}
