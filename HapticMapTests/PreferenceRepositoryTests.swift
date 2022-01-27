//
//  PreferenceRepositoryTests.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 03.11.21.
//

import XCTest
@testable import HapticMap

class PreferenceRepositoryTests: XCTestCase {

    private var userDefaults: UserDefaults!
    private var repository: PreferenceRepository!
    
    override func setUpWithError() throws {
        userDefaults = UserDefaults.makeClearedInstance()
        repository = PreferenceRepository(defaults: userDefaults)
    }

    override func tearDownWithError() throws {
    }

    func testReturnsNoFeedbacksWithEmptyUserDefaults() throws {
        XCTAssertTrue(repository.activeFeedbacks.isEmpty)
    }
    
    func testReturnsCorrectFeedbacksWithNotEmptyUserDefaults() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        userDefaults.setValue(true, forKey: feedback.rawValue)
        let newRepository = PreferenceRepository(defaults: userDefaults)
        XCTAssertEqual(newRepository.activeFeedbacks.count, 1)
        XCTAssertTrue(newRepository.activeFeedbacks.contains(feedback))
    }
    
    func testReturnsCorrectCategoriesWithNotEmptyUserDefaults() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        guard let category = Category.allCases.first else {
            return XCTFail("There should be at least one category")
        }
        let defaultsKey = feedback.rawValue + "_" + category.rawValue
        userDefaults.setValue(true, forKey: defaultsKey)
        let newRepository = PreferenceRepository(defaults: userDefaults)
        XCTAssertEqual(newRepository.activeCategories[feedback]!.count, 1)
        XCTAssertTrue(newRepository.activeCategories[feedback]!.contains(category))
    }
    
    func testReturnsNoCategoriesWithEmptyUserDefaults() throws {
        repository.activeCategories.forEach { (key, value) in
            XCTAssertTrue(value.isEmpty)
        }
    }
    
    func testActiveCategoriesListsAllCategories() throws {
        XCTAssertEqual(repository.activeCategories.count, Feedback.allCases.count)
    }
    
    func testSetFeedbackToActive() throws {
        Feedback.allCases.forEach { feedback in
            repository.set(feedback: feedback, active: true)
        }
        XCTAssertEqual(repository.activeFeedbacks.count, Feedback.allCases.count)
    }
    
    func testSetFeedbackToDisbaled() throws {
        Feedback.allCases.forEach { feedback in
            repository.set(feedback: feedback, active: true)
            repository.set(feedback: feedback, active: false)
        }
        XCTAssertEqual(repository.activeFeedbacks.count, 0)
    }
    
    func testSetFeedbackToActiveTwiceDoNotAddAnElementToActiveFeedbacks() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        repository.set(feedback: feedback, active: true)
        repository.set(feedback: feedback, active: true)
        XCTAssertEqual(repository.activeFeedbacks.count, 1)
    }
    
    func testSetCategoryToActive() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        Category.allCases.forEach { category in
            repository.set(category: category, for: feedback, to: true)
        }
        XCTAssertEqual(repository.activeCategories[feedback]?.count, Category.allCases.count)
        
        Category.allCases.forEach { category in
            XCTAssertTrue(repository.activeCategories[feedback]!.contains(category))
        }
    }
    
    func testSetCategoryToDisabled() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        Category.allCases.forEach { category in
            repository.set(category: category, for: feedback, to: true)
            repository.set(category: category, for: feedback, to: false)
        }
        XCTAssertEqual(repository.activeCategories[feedback]?.count, 0)
    }
    
    func testSetCategoryToActiveTwiceDoNotAddAnElementToActiveCategories() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        guard let category = Category.allCases.first else {
            return XCTFail("There should be at least one category")
        }
        repository.set(category: category, for: feedback, to: true)
        repository.set(category: category, for: feedback, to: true)
        XCTAssertEqual(repository.activeCategories[feedback]?.count, 1)
    }
    
    func testDelegateIsCalledWhenFeedbackBecomesActive() throws {
        
    }
    
    func testDelegateIsCalledWhenFeedbackBecomesDisabled() throws {
        
    }
    
    func testDelegateIsCalledWhenCategoryBecomesActive() throws {
        
    }
    
    func testDelegateIsCalledWhenCategoryBecomesDisabled() throws {
        
    }
    
    func testDelegateIsNotCalledWhenSettingAFeedbackActiveWhileAlreadyActive() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least two feedback type")
        }
        guard let endFeedbackTrigger = Feedback.allCases.last else {
            return XCTFail("There should be at least two feedback type")
        }
        if feedback == endFeedbackTrigger { XCTFail("The two feedbacks should be different. Please add more enum values to perfom this test")}
        
        let expectation = self.expectation(description: "Wait for end trigger")
        var count = 0
        let cancellable = repository.feedbacksPublisher.sink { (feedback, active) in
            count += 1
            if feedback == endFeedbackTrigger {
                expectation.fulfill()
            }
        }
        repository.set(feedback: feedback, active: true)
        repository.set(feedback: feedback, active: true)
        repository.set(feedback: endFeedbackTrigger, active: true)
        waitForExpectations(timeout: 0.2) { _ in
            cancellable.cancel()
        }
        XCTAssertEqual(count, 2)
    }
    
    func testDelegateIsNotCalledWhenSettingFeedbackInctiveWhileAlreadyInctive() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least two feedback type")
        }
        guard let endFeedbackTrigger = Feedback.allCases.last else {
            return XCTFail("There should be at least two feedback type")
        }
        if feedback == endFeedbackTrigger { XCTFail("The two feedbacks should be different. Please add more enum values to perfom this test")}
        
        let expectation = self.expectation(description: "Wait for end trigger")
        var count = 0
        let cancellable = repository.feedbacksPublisher.sink { (feedback, active) in
            count += 1
            if feedback == endFeedbackTrigger {
                expectation.fulfill()
            }
        }
        repository.set(feedback: feedback, active: false)
        repository.set(feedback: endFeedbackTrigger, active: true)
        waitForExpectations(timeout: 0.2) { _ in
            cancellable.cancel()
        }
        XCTAssertEqual(count, 1)
    }
    
    func testDelegateIsNotCalledWhenSettingCategoryActiveWhileAlreadyActive() throws {
        guard let feedback = Feedback.allCases.first else {
            return XCTFail("There should be at least one feedback type")
        }
        guard let category = Category.allCases.first else {
            return XCTFail("There should be at least two category type")
        }
        guard let endCategoryTrigger = Category.allCases.last else {
            return XCTFail("There should be at least two category type")
        }
        if category == endCategoryTrigger { XCTFail("The two categories should be different. Please add more enum values to perfom this test")}
        
        let expectation = self.expectation(description: "Wait for end trigger")
        var count = 0
        let cancellable = repository.categoriesPublisher.sink { (feedback, category, active) in
            count += 1
            if feedback != feedback {
                XCTFail("Not the correct feedback")
            }
            if category == endCategoryTrigger {
                expectation.fulfill()
            }
        }
        repository.set(category: category, for: feedback, to: true)
        repository.set(category: category, for: feedback, to: true)
        repository.set(category: endCategoryTrigger, for: feedback, to: true)
        waitForExpectations(timeout: 0.2) { _ in
            cancellable.cancel()
        }
        XCTAssertEqual(count, 2)
    }
    
    func testDelegateIsNotCalledWhenSettingCategoryInctiveWhileAlreadyInctive() throws {
        
    }
    

}
