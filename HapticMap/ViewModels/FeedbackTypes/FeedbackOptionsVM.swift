//
//  FeedbackOptionsVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import Foundation

class FeedbackOptionsVM: FeedbackOptionsVMProtocol {
    
    let feedback: Feedback
    
    @Published var feedbackIsOn: Bool {
        didSet {
            feedbackPreferences.set(feedback: feedback, active: feedbackIsOn)
        }
    }
    
    @Published var options: [CategoriesStateWrapper] {
        didSet {
            options.forEach { categoryWrapper in
                feedbackPreferences.set(category: categoryWrapper.category, for: feedback, to: categoryWrapper.isOn)
            }
        }
    }
    
    private let feedbackPreferences: PreferenceRepository

    init(feedbackPreferences: PreferenceRepository, feedback: Feedback) {
        self.feedbackPreferences = feedbackPreferences
        self.feedback = feedback
        self.feedbackIsOn = feedbackPreferences.activeFeedbacks.contains(feedback)
        self.options = Category.allCases
            .filter({ category in
                category.supportedFeedback.contains {$0 == feedback }
            })
            .map{CategoriesStateWrapper(category: $0, isOn: feedbackPreferences.activeCategories[feedback]?.contains($0) ?? false)}
            .sorted(by: { e1, e2 in
            NSLocalizedString(e1.category.rawValue, comment: "") < NSLocalizedString(e2.category.rawValue, comment: "")
        })
    }
    
}
