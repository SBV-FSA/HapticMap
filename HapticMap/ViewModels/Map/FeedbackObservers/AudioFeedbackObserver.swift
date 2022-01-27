//
//  AudioFeedback.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import Foundation
import UIKit

/// An observer responsible for issuing continuous frequencies feedback.
class AudioFeedbackObserver: FeedbackObserver {

    /// The set of categories that should be represented using this observer.
    private var categories = Set<Category>()
    
    /// An instance of `ToneOutputUnit`.
    private let toneOutputUnit = ToneOutputUnit()
    
    /// A dictionary associating each category with a frequency.
    private let dictionary: [Category: Double] = [
        .intersection: 500,
        .itinerary: 400,
        .pedestrianCrossing: 600,
        .pedestrianCrossingWithLights: 600,
        .road: 300,
    ]
    
    override init() {
        super.init()
        if let categories = PreferenceRepository().activeCategories[.audio] {
            self.categories = categories
        }
    }
    
    override func touchBegan(with category: Category?, userInfo: String? = nil) {
        playCoorespondingFrequency(for: category)
    }
    
    override func touchMoved(with category: Category?, userInfo: String? = nil) {
       playCoorespondingFrequency(for: category)
    }
    
    override func touchEnded(with category: Category?, userInfo: String? = nil) {
        toneOutputUnit.stop()
    }
    
    /// Plays a frequency if needed.
    /// - Parameter category: The category to play.
    private func playCoorespondingFrequency(for category: Category?) {
        guard let category = category else {
            toneOutputUnit.stop()
            return
        }
        if !categories.contains(category) {
            toneOutputUnit.stop()
            return
        }
        
        if !dictionary.contains(where: {$0.0 == category}) {
            toneOutputUnit.stop()
            return
        }
        toneOutputUnit.enableSpeaker()
        toneOutputUnit.setToneVolume(vol: 0.3)
        toneOutputUnit.setToneTime(t: 100)
        dictionary.forEach { (category_, frequency) in
            if category == category_ {
                toneOutputUnit.setFrequency(freq: frequency)
            }
        }
    }
    
}
