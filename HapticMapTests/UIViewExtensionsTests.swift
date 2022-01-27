//
//  UIViewExtensionsTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 18.10.21.
//

import XCTest
@testable import HapticMap

class UIViewExtensionsTests: XCTestCase {

    func testColorOfPoint() throws {
        let image = UIImage(named: "map-size-color-test") // Be careful, PNGs can alter colors due to compression. Use PDFs for better reliability.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        imageView.image = image
        
        let tests = [
            (0,0,"000000", "black border"),
            (265,276,"0000FF", "blue square"),
            (265,349,"FF33FF", "pink square"),
            (265,422,"000000", "black square"),
            (265,495,"FFFF00", "yellow square"),
            (265,568,"80FF00", "green square"),
            (100,100,"FFFFFF", "background"),
        ]
        
        tests.forEach { test in
            let point = CGPoint(x: test.0, y: test.1)
            let foundColor = imageView.colorOfPoint(point: point)
            XCTAssertEqual(foundColor.hexString, test.2, "Test \(test.3)")
        }
    }

}
