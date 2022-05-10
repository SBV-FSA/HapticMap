//
//  ItinariesViewUITests.swift
//  HapticMapUITests
//
//  Created by Duran Timothée on 07.10.21.
//

import XCTest

class ItinariesViewUITests: XCTestCase {
    
    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }


    func testAlertIsDisplayedIfErrorOccuresWhenRetrievingItineraries() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesViewWithRepositoryError", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        XCTAssertEqual(app.alerts.count, 1)
    }
    
}
