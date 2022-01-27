//
//  MapViewUITests.swift
//  HapticMapUITests
//
//  Created by Duran Timothée on 19.10.21.
//

import XCTest

class MapViewUITests: XCTestCase {

    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchEnvironment.updateValue("scenarioMapView", forKey: "UI_TEST_SCENARIO")
        app.launch()
    }
    
    func testMapDisplayCausesNoCrash() throws {
        XCTAssert(app.staticTexts["Map"].exists)
        app.swipeUp()
    }

}
