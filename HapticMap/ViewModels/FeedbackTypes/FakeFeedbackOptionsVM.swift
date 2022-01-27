//
//  FakeFeedbackTypesVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import Foundation

/// Fake implementation of `FeedbackOptionsVMProtocol` for SwiftUI Preview purposes.
class FakeFeedbackOptionsVM: FeedbackOptionsVMProtocol {
    
    let feedback: Feedback = .sound
    @Published var feedbackIsOn = true
    @Published var options: [CategoriesStateWrapper] = [
        CategoriesStateWrapper(category: .pedestrianCrossing, isOn: true),
        CategoriesStateWrapper(category: .road, isOn: false),
        CategoriesStateWrapper(category: .destination, isOn: true)
    ]
    
}
