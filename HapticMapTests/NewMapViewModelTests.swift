//
//  NewMapViewModelTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 25.10.21.
//

import XCTest
import Combine
@testable import HapticMap

class NewMapViewModelTests: XCTestCase {
    
    private var vm: NewMapVM<FakeRepository<Map>, FakeRepository<Element>>!
    private var fakeMapRepository: FakeRepository<Map>!
    private var fakeElementRepository: FakeRepository<Element>!
    private let localFileName = "Test.png"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private var fileURL: URL {
        documentDirectory.appendingPathComponent(localFileName)
    }
    
    override func setUpWithError() throws {
        // Saving a test map to local documents
        let fileURL = documentDirectory.appendingPathComponent(localFileName)
        try UIImage(named: "map-size-color-test")?.pngData()?.write(to: fileURL)
    }
    
    override func tearDownWithError() throws {
        // Deleting test map to local documents
        let fileURL = documentDirectory.appendingPathComponent(localFileName)
        try FileManager.default.removeItem(at: fileURL)
    }
    
    func testLoadFileFillsMapNameAndFileName() throws {
        fakeMapRepository = FakeRepository<Map>()
        fakeElementRepository = FakeRepository<Element>()
        vm = NewMapVM(repository: fakeMapRepository, elementRepository: fakeElementRepository)
        
        let fileImporterResult: Result<URL, Error> = .success(fileURL)
        vm.loadFile(fileImporterResult: fileImporterResult)
        
        XCTAssertEqual(vm.mapName, "Test")
        XCTAssertEqual(vm.fileName, localFileName)
    }
    
    func testLoadPhotoFillsFileNameAndNotName() throws {
        fakeMapRepository = FakeRepository<Map>()
        fakeElementRepository = FakeRepository<Element>()
        vm = NewMapVM(repository: fakeMapRepository, elementRepository: fakeElementRepository)
        
        let testImage = UIImage(named: "map-size-color-test")
        vm.inputImage = testImage
        
        XCTAssertEqual(vm.mapName, "")
        XCTAssertEqual(vm.fileName, NSLocalizedString("image_from_library", comment: ""))
    }
    
    func testReturnsCorrectErrorIfNoFileFound() throws {
        fakeMapRepository = FakeRepository<Map>()
        fakeElementRepository = FakeRepository<Element>()
        vm = NewMapVM(repository: fakeMapRepository, elementRepository: fakeElementRepository)
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = "Test.png"
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        try UIImage(named: "map-size-color-test")?.pngData()?.write(to: fileURL)
        
        let wrongURL = documentDirectory.appendingPathComponent(UUID().uuidString)
        let fileImporterResult: Result<URL, Error> = .success(wrongURL)
        vm.loadFile(fileImporterResult: fileImporterResult)
        
        XCTAssertEqual(vm.errorPacket?.error as! NewMapVMError, NewMapVMError.fileNotFound)
    }
    
    func testSaveReturnsCorrectErrorIfNoFileProvided() throws {
        fakeMapRepository = FakeRepository<Map>()
        fakeElementRepository = FakeRepository<Element>()
        vm = NewMapVM(repository: fakeMapRepository, elementRepository: fakeElementRepository)
        let expectation = self.expectation(description: "wait for error to be sent")
        vm.save { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                switch error {
                case NewMapVMError.missingFile:
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSaveReturnsCorrectErrorIfRepositoryFailsMapCreation() throws {
        fakeMapRepository = FakeRepository<Map>()
        fakeMapRepository.createShouldFail = true
        fakeElementRepository = FakeRepository<Element>()
        vm = NewMapVM(repository: fakeMapRepository, elementRepository: fakeElementRepository)
        
        let expectation = self.expectation(description: "wait for error to be sent")
        let fileImporterResult: Result<URL, Error> = .success(fileURL)
        vm.loadFile(fileImporterResult: fileImporterResult)
        
        vm.save { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                switch error {
                case NewMapVMError.missingMap:
                    expectation.fulfill()
                default:
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
