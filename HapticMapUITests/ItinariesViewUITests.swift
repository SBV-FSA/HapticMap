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

    /// Tests that by pressing _Edit_ and selecting the deletion icon on a specific row actually deletes the item from the list.
    func testDeletionMakesItineraryDisappear() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.cells["Work to Home"].exists)
        let navigationBar = XCUIApplication().navigationBars["Itineraries"]
        navigationBar.buttons["Edit"].tap()
        app.tables.children(matching: .cell).matching(identifier: "Work to Home").element(boundBy: 0).buttons["Delete "].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.matching(identifier: \"AABBC\").buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        navigationBar.buttons["Done"].tap()
        XCTAssertFalse(tablesQuery.cells["Work to Home"].exists)
    }
    
    /// Tests that by pressing _Edit_ and selecting the deletion icon on a specific row do not delete other rows.
    func testDeletionDontDeletesOtherRows() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.cells["Train Station to Hospital"].exists)
        let navigationBar = XCUIApplication().navigationBars["Itineraries"]
        navigationBar.buttons["Edit"].tap()
        app.tables.children(matching: .cell).matching(identifier: "Work to Home").element(boundBy: 0).buttons["Delete "].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.matching(identifier: \"AABBC\").buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        navigationBar.buttons["Done"].tap()
        XCTAssertTrue(tablesQuery.cells["Train Station to Hospital"].exists)
    }
    
    func testItineraryWithNoNameDisplaysCorrectly() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.cells["Unnamed itinerary..."].exists)
    }
    
    func testAlertIsDisplayedIfErrorOccuresWhenRetrievingItineraries() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesViewWithRepositoryError", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        XCTAssertEqual(app.alerts.count, 1)
    }
    
    func testAlertIsDisplayedIfErrorOccuresWhenDeleting() throws {
        app.launchEnvironment.updateValue("scenarioItinerariesViewWithDeletionError", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertEqual(app.alerts.count, 0)
        let tablesQuery = app.tables
        tablesQuery.cells["Work to Home"].swipeLeft()
        tablesQuery.cells["Work to Home"].buttons["Delete"].tap()
        XCTAssertEqual(app.alerts.count, 1)
    }
    
    func testMessageDisplayedIfNoItineraries() {
        app.launchEnvironment.updateValue("scenarioItinerariesViewNoItineraries", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertTrue(app.staticTexts["There are no itineraries yet."].exists)
    }
    
    func testShareSheetIsPresented() {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertFalse(app.buttons["Share"].exists)
        tablesQuery.cells["Work to Home"].press(forDuration: 1)
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Share"]/*[[".cells.buttons[\"Share\"]",".buttons[\"Share\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let activityListView = app.otherElements.element(matching: .other,
                                                         identifier: "ActivityListView")
        XCTAssertTrue(activityListView.waitForExistence(timeout: 1.0))
        activityListView.buttons["Close"].tap()
    }
    
    func testDeleteWithContextMenu() {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertFalse(app.buttons["Delete"].exists)
        tablesQuery.cells["Work to Home"].press(forDuration: 1)
        app.collectionViews.buttons["Delete"].tap()
        XCTAssertFalse(tablesQuery.cells["Work to Home"].exists)
    }
    
    func testRenameWithContextMenu() {
        app.launchEnvironment.updateValue("scenarioItinerariesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        let tablesQuery = app.tables
        XCTAssertFalse(app.buttons["Rename"].exists)
        tablesQuery.cells["Work to Home"].press(forDuration: 1)
        app.collectionViews.buttons["Rename"].tap()
        XCTAssertTrue(app.staticTexts["Rename"].exists)
        app.buttons["OK"].tap()
        sleep(1)
        XCTAssertFalse(app.staticTexts["Rename"].exists)
    }

}
