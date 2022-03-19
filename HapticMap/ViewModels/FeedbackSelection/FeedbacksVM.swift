//
//  FeedbacksVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Combine
import Foundation

class FeedbacksVM: FeedbacksVMProtocol {
    
    @Published var states: [FeedbackStateWrapper] = []
    
    let preferenceRepository: PreferenceRepository
    
    init(feedbackPreferences: PreferenceRepository = PreferenceRepository.shared) {
        self.preferenceRepository = feedbackPreferences
        loadPreferences()
        listenChanges()
    }
    
    func resetToDefault() {
        preferenceRepository.resetToDefault()
    }
    
    private var cancellable: Cancellable?
    private func listenChanges() {
        cancellable = preferenceRepository.feedbacksPublisher.sink(receiveValue: { (feedback, value) in
            if let index = self.states.firstIndex(where: {$0.feedback == feedback}) {
                self.states[index].isOn = value
            }
        })
    }
    
    private func loadPreferences() {
        states = Feedback.allCases.map {FeedbackStateWrapper(feedback: $0, isOn: preferenceRepository.activeFeedbacks.contains($0))}
    }
    
}
