//
//  Feedback.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import CoreHaptics
import Foundation

/**
 Represents a type of feedback given to the user while exploring a map.
 
 Example: A haptic feedback.
 */
enum Feedback: String, CaseIterable {
    
    /// Uses a range of continuous audio frequencies to describe elements.
    case audio
    
    /// Uses a set of haptic patterns to describe elements.
    case haptic
    
    /// Uses VoiceOver to describe elements.
    case spoken
    
    /// Uses UI sounds.
    case sound
    
}

extension Feedback {
    
    /// Indicates if the feedback type is availble on the device.
    var isAvailable: Bool {
        switch self {
        case .haptic:
            return CHHapticEngine.capabilitiesForHardware().supportsHaptics
        default:
            return true
        }
    }
    
    /// The name of the SFSymbol icon used to illustrate the feedback type.
    var iconName: String {
        switch self {
        case .audio:
            return "speaker.wave.1.fill"
        case .haptic:
            return "iphone.radiowaves.left.and.right"
        case .spoken:
            return "message.fill"
        case .sound:
            return "music.note"
        }
    }
    
}
