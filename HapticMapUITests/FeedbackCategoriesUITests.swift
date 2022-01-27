//
//  FeedbackCategoriesUITests.swift
//  HapticMapUITests
//
//  Created by Duran Timothée on 09.11.21.
//

import XCTest
import HapticMap

class FeedbackCategoriesUITests: XCTestCase {
    
    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testShowsOffStatus() throws {
        app.launchEnvironment.updateValue("scenarioFeedbackCategoriesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        let tablesQuery = app.tables
        Feedback.allCases.forEach { feedback in
            print("Searching \(feedback.rawValue)")
            let cell = tablesQuery.cells[feedback.rawValue]
            XCTAssertTrue(cell.exists)
            if feedback.isAvailable {
                XCTAssertTrue(cell.staticTexts["Off"].exists)
            } else {
                XCTAssertTrue(cell.staticTexts["Unavailable"].exists)
            }
            
        }
    }
    
    func testShowsOnStatus() throws {
        app.launchEnvironment.updateValue("scenarioFeedbackCategoriesViewAllOn", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        let tablesQuery = app.tables
        Feedback.allCases.forEach { feedback in
            print("Searching \(feedback.rawValue)")
            let cell = tablesQuery.cells[feedback.rawValue]
            XCTAssertTrue(cell.exists)
            if feedback.isAvailable {
                XCTAssertTrue(cell.staticTexts["On"].exists)
            } else {
                XCTAssertTrue(cell.staticTexts["Unavailable"].exists)
            }
            
        }
    }
    
    func testChangeFromOffToOn() throws {
        app.launchEnvironment.updateValue("scenarioFeedbackCategoriesView", forKey: "UI_TEST_SCENARIO")
        app.launch()
                
        XCTAssertTrue(app.tables.cells[Feedback.audio.rawValue].staticTexts["Off"].exists)
        app.tables.cells[Feedback.audio.rawValue].tap()
        app.tables.cells["State"].switches.firstMatch.tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.cells[Feedback.audio.rawValue].staticTexts["On"].exists)
    }
    
}
