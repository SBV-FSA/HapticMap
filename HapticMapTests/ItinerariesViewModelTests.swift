//
//  ItinerariesViewModelTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 19.10.21.
//

import XCTest
import Combine
@testable import HapticMap

class ItinerariesViewModelTests: XCTestCase {
    
    private var vm: ItinariesVM<FakeRepository<Itinerary>>!
    private var fakeRepository: FakeRepository<Itinerary>!
    
    override func setUp() {
        
    }
    
    func testFailedDeletionShouldPublishErrorPacket() {
        fakeRepository = FakeRepository<Itinerary>()
        vm = ItinariesVM(model: fakeRepository)
        let expectation = self.expectation(description: "wait for error packet to be sent")
        fakeRepository.saveShouldFail = true
        let itinerary = try! fakeRepository.create()
        
        let sub = vm.$errorPacket.sink { result in
            switch result {
            case .some(let errorPacket):
                if errorPacket.error as! RepositoryError == RepositoryError.cannotSaveContext {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            case .none:
                break
            }
        }
        
        self.vm.delete(itinaries: [itinerary])
        waitForExpectations(timeout: 1.0) { _ in
            sub.cancel()
        }
    
    }
    
    func testFailedToRetrieveItinerariesShouldPublishErrorPacket() {
        fakeRepository = FakeRepository<Itinerary>(allEntitiesPublisherShouldFail: true)
        vm = ItinariesVM(model: fakeRepository)
        let expectation = self.expectation(description: "wait for error packet to be sent")
        
        let sub = vm.$errorPacket.sink { result in
            switch result {
            case .some(let errorPacket):
                if errorPacket.error as! RepositoryError == RepositoryError.other {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            case .none:
                break
            }
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            sub.cancel()
        }
    }
    
    func testNoErrorOccuresWhenItinerariesPublisherFinishes() {
        fakeRepository = FakeRepository<Itinerary>(allEntitiesPublisherShouldFail: true)
        vm = ItinariesVM(model: fakeRepository)
        let expectation = self.expectation(description: "wait for error packet to be sent")
        
        let sub = vm.$errorPacket.sink { result in
            switch result {
            case .some(_):
                XCTFail()
            case .none:
                expectation.fulfill()
            }
        }
        
        fakeRepository.finishPublisher()
        waitForExpectations(timeout: 1.0) { _ in
            sub.cancel()
        }
    }
    
}
