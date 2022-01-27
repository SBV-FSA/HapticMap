//
//  FeedbackOptionsVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import Foundation

/// FeedbackOptionsView ViewModel Protocol.
protocol FeedbackOptionsVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The feedback for which to configure the options.
    var feedback: Feedback { get }
    
    /// Indicated if the feedback is activated or not. Disbaled means that the feedback won't be given in any circumstances.
    var feedbackIsOn: Bool { get set }
    
    /// The list of options available for this feedback.
    var options: [CategoriesStateWrapper] { get set }
    
}
