//
//  MapNSItemProviderTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 09.11.21.
//

import XCTest
import HapticMap
import UniformTypeIdentifiers

class MapNSItemProviderTests: XCTestCase {

    private var map: Map!
    private let mapName = UUID().uuidString
    private let mapOrder = NSNumber(value: 3)
    private var mapImage: NSData!
    private let typeIdentifier = UTType("ch.elca.hapticmap.hcmp")!
    
    override func setUpWithError() throws {
        map = Map(context: PersistenceController.preview.container.viewContext)
        mapImage = NSData(data: UIImage(named: "map-size-color-test")!.pngData()!)
        map.name = mapName
        map.image = mapImage
        map.order = mapOrder
    }

    func testTypeIdentifierIsCorrect() throws {
        XCTAssertEqual(Map.typeIdentifier, typeIdentifier)
    }
    
    func testMapNameReadWrite() throws {
        let expectation = self.expectation(description: "wait for item to be decoded")
        readMapOrFail { decodedMap in
            XCTAssertEqual(decodedMap.name, self.mapName)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.2)
    }
    
    func testMapImageReadWrite() throws {
        let expectation = self.expectation(description: "wait for item to be decoded")
        readMapOrFail { decodedMap in
            XCTAssertEqual(decodedMap.image!.length, self.mapImage.length, accuracy: 100)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.2)
    }
    
    /// The order should not be coded and decoded as it is not relevent in this context.
    func testMapOrderReadWrite() throws {
        let expectation = self.expectation(description: "wait for item to be decoded")
        readMapOrFail { decodedMap in
            XCTAssertNil(decodedMap.order)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.2)
    }
    
    private func readMapOrFail(completion: @escaping (Map) -> Void) {
        NSItemProvider(object: map).loadObject(ofClass: Map.self) { reader, error in
            if let error = error {
                return XCTFail(error.localizedDescription)
            }
            guard let decodedMap = reader as? Map else {
                return XCTFail()
            }
            completion(decodedMap)
        }
    }

}
