//
//  UIColorExtensionsTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 18.10.21.
//

import XCTest
@testable import HapticMap

class UIColorExtensionsTests: XCTestCase {

    func testRedComponentReturnsCorrectHex() throws {
        let color = UIColor(red: 12/255, green: 0, blue: 0, alpha: 0)
        let hex = color.hexString
        let lowerBound = String.Index(utf16Offset: 0, in: hex)
        let upperBound = String.Index(utf16Offset: 2, in: hex)
        XCTAssertEqual(hex[lowerBound..<upperBound], "0C")
    }
    
    func testGreenComponentReturnsCorrectHex() throws {
        let color = UIColor(red: 0, green: 42/255, blue: 0, alpha: 0)
        let hex = color.hexString
        let lowerBound = String.Index(utf16Offset: 2, in: hex)
        let upperBound = String.Index(utf16Offset: 4, in: hex)
        XCTAssertEqual(hex[lowerBound..<upperBound], "2A")
    }
    
    func testBlueComponentReturnsCorrectHex() throws {
        let color = UIColor(red: 0, green: 0, blue: 63/255, alpha: 0)
        let hex = color.hexString
        let lowerBound = String.Index(utf16Offset: 4, in: hex)
        let upperBound = String.Index(utf16Offset: 6, in: hex)
        XCTAssertEqual(hex[lowerBound..<upperBound], "3F")
    }
    
    func testColorReturnsCorrectHex() throws {
        let color = UIColor(red: 85/255, green: 30/255, blue: 60/255, alpha: 0)
        let hex = color.hexString
        XCTAssertEqual(hex, "551E3C")
    }
    
    func testAlphaDoesNotAffectHey() throws {
        let color = UIColor(red: 85/255, green: 30/255, blue: 60/255, alpha: 10/255)
        let hex = color.hexString
        XCTAssertEqual(hex, "551E3C")
    }
    
    func testIsSimilarOnIdenticalColors() throws {
        let color = UIColor.red
        XCTAssertTrue(color.isSimilar(to: color, threshold: 0))
        XCTAssertTrue(color.isSimilar(to: color, threshold: 1))
    }
    
    func testIsSimilarOnGreatlyDifferentColors() throws {
        let color1 = UIColor.red
        let color2 = UIColor.blue
        XCTAssertFalse(color1.isSimilar(to: color2, threshold: 0))
        XCTAssertFalse(color1.isSimilar(to: color2, threshold: 1))
    }
    
    func testDistanceSquaredComparedToDistance() throws {
        let color1 = UIColor.red
        let color2 = UIColor.blue
        let squaredDistance = color1.distanceSquared(to: color2)
        let distance = color1.distance(to: color2)
        XCTAssertEqual(sqrt(squaredDistance), distance)
    }
    
    func testSquaredDistance() throws {
        let color1 = UIColor.red
        let color2 = UIColor.blue
        let squaredDistance = color1.distanceSquared(to: color2)
        XCTAssertEqual(squaredDistance, 2)
    }

}
