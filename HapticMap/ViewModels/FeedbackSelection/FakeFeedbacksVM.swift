//
//  FakeFeedbackSelectionViewModel.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Foundation

/// Fake implementation of `FeedbacksVMProtocol` for SwiftUI Preview purposes.
class FakeFeedbackTypesVM: FeedbacksVMProtocol {
    
    @Published var states: [FeedbackStateWrapper] = []
    
    let preferenceRepository: PreferenceRepository
    
    init(feedbackPreferences: PreferenceRepository? = nil) {
        self.preferenceRepository = feedbackPreferences ?? PreferenceRepository(defaults: .makeClearedInstance())
        loadPreferences()
    }
    
    func resetToDefault() {}
    
    private func loadPreferences() {
        states = Feedback.allCases.map {FeedbackStateWrapper(feedback: $0, isOn: preferenceRepository.activeFeedbacks.contains($0))}
        states[0].isOn = true
    }
    
}
