//
//  FeedbackStateWrapper.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Foundation

/// Wrapper class conforming to *Identifiable* and *Equatable* procotols reprensenting a feedback setting.
struct FeedbackStateWrapper: Identifiable, Equatable {
    
    /// A UUID unrelated to the feedback but used by SwiftUI.
    let id = UUID()
    
    /// The wrapped feedback.
    var feedback: Feedback
    
    /// Indicates if the feedback is switched on or off.
    var isOn: Bool
    
}
