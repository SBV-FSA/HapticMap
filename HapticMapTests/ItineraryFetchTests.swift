//
//  ItineraryFetchTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 14.10.21.
//

import XCTest
@testable import HapticMap

class ItineraryFetchTests: XCTestCase {

    func testAlphabeticalItinerariesRequest() throws {
        let previewContext = TestCoreDataStack().container.viewContext
        let itinerary1 = Itinerary(context: previewContext)
        itinerary1.name = "B"
        
        let itinerary2 = Itinerary(context: previewContext)
        itinerary2.name = "A"
        try previewContext.save()
        
        let fetchRequest = Itinerary.alphabeticalItinerariesRequest
        let fetchResult = try! previewContext.fetch(fetchRequest)
        
        XCTAssertEqual(fetchResult[0].name, "A")
        XCTAssertEqual(fetchResult[1].name, "B")
    }

}
