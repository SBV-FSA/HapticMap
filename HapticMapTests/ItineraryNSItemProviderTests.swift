//
//  ItineraryNSItemProviderTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 09.11.21.
//

import XCTest
import HapticMap
import UniformTypeIdentifiers

class ItineraryNSItemProviderTests: XCTestCase {

    private var itinerary: Itinerary = Itinerary(context: PersistenceController.shared.container.viewContext)
    private let itineraryName = UUID().uuidString
    private let map1Name = UUID().uuidString
    private let map1Order = 3
    private let map2Name = UUID().uuidString
    private let map2Order = 1
    private var map1Image: NSData!
    private var map2Image: NSData!
    private let typeIdentifier = UTType("ch.elca.hapticmap.hcit")!
    
    override func setUpWithError() throws {
        itinerary.name = itineraryName
        
        let map1 = Map(context: PersistenceController.shared.container.viewContext)
        map1Image = NSData(data: UIImage(named: "map-size-color-test")!.pngData()!)
        map1.name = map1Name
        map1.image = map1Image
        map1.order = NSNumber(value: map1Order)
        map1.itinerary = itinerary
        
        let map2 = Map(context: PersistenceController.shared.container.viewContext)
        map2Image = NSData(data: UIImage(named: "map-size-color-test")!.pngData()!)
        map2.name = map2Name
        map2.image = map2Image
        map2.order = NSNumber(value: map2Order)
        map2.itinerary = itinerary
    }

    func testTypeIdentifierIsCorrect() throws {
        XCTAssertEqual(Itinerary.typeIdentifier, typeIdentifier)
    }
    
    func testItineraryNameReadWrite() throws {
        let expectation = self.expectation(description: "wait for item to be decoded")
        readItineraryOrFail { decodedItinerary in
            XCTAssertEqual(decodedItinerary.name, self.itineraryName)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.2)
    }
    
    func testItineraryMapsReadWrite() throws {
        let expectation = self.expectation(description: "wait for item to be decoded")
        readItineraryOrFail { decodedMap in
            XCTAssertEqual(decodedMap.mapsArray.count, 2)
            guard let decodedMap1 = decodedMap.mapsArray.first(where: {$0.wrappedName == self.map1Name}) else {
                return XCTFail()
            }
            guard let decodedMap2 = decodedMap.mapsArray.first(where: {$0.wrappedName == self.map2Name}) else {
                return XCTFail()
            }
            XCTAssertEqual(decodedMap1.wrappedName, self.map1Name)
            XCTAssertEqual(decodedMap2.wrappedName, self.map2Name)
            XCTAssertEqual(decodedMap1.order, NSNumber(value: self.map1Order))
            XCTAssertEqual(decodedMap2.order, NSNumber(value: self.map2Order))
            XCTAssertEqual(decodedMap1.image!.length, self.map1Image.length, accuracy: 100)
            XCTAssertEqual(decodedMap2.image!.length, self.map2Image.length, accuracy: 100)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.5)
    }
    
    func testExportToURL() throws {
        let url = itinerary.exportToURL()
        XCTAssertEqual(url?.deletingPathExtension().lastPathComponent, itineraryName)
        XCTAssertEqual(url?.pathExtension, "hcit")
    }
    
    private func readItineraryOrFail(completion: @escaping (Itinerary) -> Void) {
        NSItemProvider(object: itinerary).loadObject(ofClass: Itinerary.self) { reader, error in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
            guard let decodedItinerary = reader as? Itinerary else {
                return XCTFail()
            }
            completion(decodedItinerary)
        }
    }

}
