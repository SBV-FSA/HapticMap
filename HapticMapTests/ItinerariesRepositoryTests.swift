//
//  ItinerariesRepositoryTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 14.10.21.
//

import CoreData
import XCTest
@testable import HapticMap

class ItinerariesRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDelete() throws {
        let previewContext = TestCoreDataStack().container.viewContext
        let itinerary1 = Itinerary(context: previewContext)
        itinerary1.name = "Work to Home"
        try previewContext.save()
        
        let fetchRequest: NSFetchRequest<Itinerary> = Itinerary.fetchRequest()
        XCTAssertEqual(try! previewContext.count(for: fetchRequest), 1)
        
        let repository = Repository<Itinerary>(managedObjectContext: previewContext)
        repository.delete(entity: itinerary1)
        XCTAssertNoThrow(try previewContext.save())
        
        XCTAssertEqual(try! previewContext.count(for: fetchRequest), 0)
    }
    
    func testCreate() throws {
        let previewContext = TestCoreDataStack().container.viewContext
        let fetchRequest: NSFetchRequest<Itinerary> = Itinerary.fetchRequest()
        XCTAssertEqual(try! previewContext.count(for: fetchRequest), 0)
        
        let repository = Repository<Itinerary>(managedObjectContext: previewContext)
        let _ = try! repository.create()
        try! repository.save()
        XCTAssertEqual(try! previewContext.count(for: fetchRequest), 1)
    }

}
