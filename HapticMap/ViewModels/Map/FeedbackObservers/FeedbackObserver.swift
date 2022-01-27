//
//  FeedbackObservers.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import UIKit

class FeedbackObserver: Equatable, Hashable {
    
    static func == (lhs: FeedbackObserver, rhs: FeedbackObserver) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    static func makeObserverFor(_ feedback: Feedback, map: Map) -> FeedbackObserver {
        switch feedback {
        case .audio:
            return AudioFeedbackObserver()
        case .haptic:
            return HapticFeedbackObserver()
        case .spoken:
            return SpokenFeedbackObserver(map: map)
        case .sound:
            return SoundFeedbackObserver()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
    
    func touchBegan(with: Category?, userInfo: String? = nil) { }
    
    func touchMoved(with: Category?, userInfo: String? = nil) { }
    
    func touchEnded(with: Category?, userInfo: String? = nil) { }
    
}
