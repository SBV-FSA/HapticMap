//
//  MapVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import UIKit

class MapVM: MapVMProtocol {
    
    var map: Map
    
    @Published var showInfos: Bool = false
    
    var preferenceRepository: PreferenceRepository
    
    private var colorObservers = [FeedbackObserver]()
    private var lastObservedCategory: Category?
    
    init(map: Map, feedbackPreferences: PreferenceRepository = PreferenceRepository.shared) {
        self.preferenceRepository = feedbackPreferences
        self.map = map
        registerObservers()
    }
    
    func touchBegan(with color: UIColor) {
        let category = category(of: color)
        if lastObservedCategory != category {
            print("Touch began with: \(category.rawValue)")
            lastObservedCategory = category
            colorObservers.forEach({$0.touchBegan(with: category, userInfo: getCustomCategory(for: color))})
        }
    }
    
    func touchMoved(with color: UIColor) {
        let category = category(of: color)
        if lastObservedCategory != category {
            print("Touch moved with: \(category.rawValue)")
            lastObservedCategory = category
            colorObservers.forEach({$0.touchMoved(with: category, userInfo: getCustomCategory(for: color))})
        }
    }
    
    func touchEnded(with color: UIColor) {
        let category = category(of: color)
        lastObservedCategory = nil
        print("Touch ended with: \(category.rawValue)")
        colorObservers.forEach({$0.touchEnded(with: category, userInfo: getCustomCategory(for: color))})
    }
    
    func refreshCategories() {
        registerObservers()
    }
    
    private func getCustomCategory(for color: UIColor) -> String? {
        let element = map.elementsArray.first(where: {$0.uiColor?.isSimilar(to: color) ?? false})
        return element?.localizedDescription?.value
    }
    
    private func registerObservers() {
        colorObservers = preferenceRepository.activeFeedbacks.map{FeedbackObserver.makeObserverFor($0, map: map)}
    }
    
    private func category(of color: UIColor) -> Category {
        return Category.allCases.first(where: {$0.color?.isSimilar(to: color) ?? false}) ?? .other
    }
    
}
