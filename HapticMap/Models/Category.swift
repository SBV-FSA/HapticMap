//
//  Category.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Foundation
import UIKit

/// Represents an element of the environment.
public enum Category: String, CaseIterable, Codable {
    case border
    case destination
    case empty
    case intersection
    case itinerary
    case other
    case pedestrianCrossing
    case pedestrianCrossingWithLights
    case road
}

extension Category {
    
    /// The color used to represent this category.
    var color: UIColor? {
        switch self {
        case .border:
            return UIColor(red: 0.74902, green: 0.12941, blue: 0.11765, alpha: 1)
        case .destination:
            return UIColor(red: 0.09804, green: 0.63921, blue: 0.40784, alpha: 1)
        case .empty:
            return .white
        case .intersection:
            return UIColor(red: 0.52157, green: 0.52549, blue: 0.52549, alpha: 1)
        case .itinerary:
            return UIColor(red: 0.11372, green: 0.28627, blue: 0.72549, alpha: 1)
        case .other:
            return nil
        case .pedestrianCrossing:
            return UIColor(red: 1, green: 0.81176, blue: 0, alpha: 1)
        case .pedestrianCrossingWithLights:
            return UIColor(red: 0.92941, green: 0.29804, blue: 0.02745, alpha: 1)
        case .road:
            return UIColor(red: 0.04313, green: 0.04706, blue: 0.05098, alpha: 1)
        }
    }
    
    /// The list of supported feedback types for this category.
    var supportedFeedback: [Feedback] {
        switch self {
        case .border:
            return [.sound, .haptic]
        case .destination:
            return [.sound, .spoken]
        case .empty:
            return []
        case .intersection:
            return [.audio, .haptic, .sound]
        case .itinerary:
            return [.audio, .haptic]
        case .other:
            return [.haptic, .spoken]
        case .pedestrianCrossing:
            return [.haptic, .audio, .sound, .spoken]
        case .pedestrianCrossingWithLights:
            return [.haptic, .audio, .sound, .spoken]
        case .road:
            return [.haptic, .audio]
        }
    }
    
}
