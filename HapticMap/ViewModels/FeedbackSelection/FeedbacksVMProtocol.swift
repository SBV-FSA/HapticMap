//
//  FeedbacksVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Foundation

/// FeedbacksView ViewModel Protocol.
protocol FeedbacksVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// A preference repository used to load current feedback states and listen for changes.
    var preferenceRepository: PreferenceRepository { get }
    
    /// The feedbacks states.
    var states: [FeedbackStateWrapper] { get set }
    
    /// Resets all the preferences to default values, suited for new users.
    func resetToDefault()
    
}
