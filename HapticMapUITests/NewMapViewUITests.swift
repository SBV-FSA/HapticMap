//
//  NewMapViewUITests.swift
//  HapticMapUITests
//
//  Created by Duran Timothée on 25.10.21.
//

import XCTest

class NewMapViewUITests: XCTestCase {

    private var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testImportShowsImportMethod() throws {
        app.launchEnvironment.updateValue("scenarioNewMapView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        
        app.buttons["Import File"].tap()
        XCTAssertTrue(app.sheets["Choose a location."].buttons["Photo library"].exists)
        XCTAssertTrue(app.sheets["Choose a location."].buttons["Files"].exists)
    }
    
    func testChoosingFilesOpensFileImporter() throws {
        app.launchEnvironment.updateValue("scenarioNewMapView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        app.buttons["Import File"].tap()
        app.sheets["Choose a location."].buttons["Files"].tap()
        
        let fileImporterTitle = app/*@START_MENU_TOKEN@*/.navigationBars["FullDocumentManagerViewControllerNavigationBar"]/*[[".otherElements[\"Browse View\"]",".otherElements[\"DOC.browsingRoot Source: com.apple.FileProvider.LocalStorage, Title: File Provider Storage\"].navigationBars[\"FullDocumentManagerViewControllerNavigationBar\"]",".navigationBars[\"FullDocumentManagerViewControllerNavigationBar\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.staticTexts["On My iPhone"]
        let predicate = NSPredicate(format: "exists == 1")
        expectation(for: predicate, evaluatedWith: fileImporterTitle, handler: nil)
        waitForExpectations(timeout:2, handler: nil)
        
        XCTAssertTrue(fileImporterTitle.exists)
        app/*@START_MENU_TOKEN@*/.navigationBars["FullDocumentManagerViewControllerNavigationBar"]/*[[".otherElements[\"Browse View\"]",".otherElements[\"DOC.browsingRoot Source: com.apple.FileProvider.LocalStorage, Title: File Provider Storage\"].navigationBars[\"FullDocumentManagerViewControllerNavigationBar\"]",".navigationBars[\"FullDocumentManagerViewControllerNavigationBar\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.buttons["Cancel"].tap()
        XCTAssertTrue(!app.sheets["Choose a location."].buttons["Files"].exists)
    }
    
    func testImportImageFromLibraryDismissesTheSheet() throws {
        app.launchEnvironment.updateValue("scenarioNewMapView", forKey: "UI_TEST_SCENARIO")
        app.launch()
        app.buttons["Import File"].tap()
        app.sheets["Choose a location."].scrollViews.otherElements.buttons["Photo library"].tap()
        app.scrollViews.otherElements.images.firstMatch.tap()
        XCTAssertTrue(!app.sheets["Choose a location."].exists)
        XCTAssertTrue(app.buttons["Import File"].exists)
    }
    
    func testDisplaysErrors() throws {
        app.launchEnvironment.updateValue("scenarioNewMapViewErrorOnSave", forKey: "UI_TEST_SCENARIO")
        app.launch()
        app.buttons["OK"].tap()
        XCTAssertEqual(app.alerts.count, 1)
    }
    
    func testCancelDismissesView() throws {
        app.launchEnvironment.updateValue("scenarioNewMapViewPresentationMode", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertTrue(!app.navigationBars["New Map"].exists)
        app.buttons["open"].tap()
        XCTAssertTrue(app.navigationBars["New Map"].exists)
        app.buttons["Cancel"].tap()
        XCTAssertTrue(!app.navigationBars["New Map"].exists)
    }
    
    func testOKDismissesView() throws {
        app.launchEnvironment.updateValue("scenarioNewMapViewPresentationMode", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertTrue(!app.navigationBars["New Map"].exists)
        app.buttons["open"].tap()
        XCTAssertTrue(app.navigationBars["New Map"].exists)
        app.buttons["OK"].tap()
        XCTAssertTrue(!app.navigationBars["New Map"].exists)
    }
    
    func testOKButtonDisabledIfNoName() throws {
        app.launchEnvironment.updateValue("scenarioNewMapViewNoNameWithFile", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertFalse(app.buttons["OK"].isEnabled)
    }
    
    func testOKButtonDisabledIfNoFile() throws {
        app.launchEnvironment.updateValue("scenarioNewMapViewNoFileWithName", forKey: "UI_TEST_SCENARIO")
        app.launch()
        XCTAssertFalse(app.buttons["OK"].isEnabled)
    }

}
