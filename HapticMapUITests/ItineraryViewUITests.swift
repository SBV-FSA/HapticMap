//
//  ItineraryViewUITests.swift
//  HapticMapUITests
//
//  Created by Duran Timothée on 19.10.21.
//

import XCTest

class ItineraryViewUITests: XCTestCase {

    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchEnvironment.updateValue("scenarioItineraryView", forKey: "UI_TEST_SCENARIO")
        app.launch()
    }
    
    func testMapWithNameDisplaysCorrectly()throws {
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.cells["Train Station"].exists)
    }
    
    func testMapWithNoNameDisplaysCorrectly()throws {
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.cells["Unnamed map..."].exists)
    }

}
