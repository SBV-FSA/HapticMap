//
//  SpokenFeedbackObserver.swift
//  HapticMap
//
//  Created by Duran Timothée on 02.11.21.
//

import AVFoundation
import Foundation
import UIKit

/// An observer responsible for given an audio descriptions of elements.
class SpokenFeedbackObserver: FeedbackObserver {
    
    /// An instance of `AVSpeechSynthesizer`.
    private let synthesizer = AVSpeechSynthesizer()
    
    /// Voice speed.
    private let synthesizerRate = Float(0.6)
    
    /// The set of categories that should be represented using this observer.
    private var categories = Set<Category>()
    
    /// The map to describe.
    private let map: Map
    
    init(map: Map) {
        self.map = map
        if let categories = PreferenceRepository().activeCategories[.spoken] {
            self.categories = categories
        }
    }
    
    override func touchBegan(with category: Category?, userInfo: String? = nil) {
        if let category = category {
            speak(category: category, userInfo: userInfo)
        }
    }
    
    override func touchMoved(with category: Category?, userInfo: String? = nil) {
        if let category = category {
            speak(category: category, userInfo: userInfo)
        }
    }
    
    override func touchEnded(with category: Category?, userInfo: String? = nil) {
        
    }
    
    /// Describes the element to the user in his language if needed.
    /// - Parameters:
    ///   - category: The category to describe.
    ///   - userInfo: Optional informations to read such as custom categories for example.
    private func speak(category: Category, userInfo: String? = nil) {
        var readingString = ""
        if let userInfo = userInfo, category == .other {
            readingString = userInfo
        } else if category != .other {
            readingString = NSLocalizedString(category.rawValue, comment: "Translation of the category")
        }
        if !categories.contains(category) { return }
        
        /* A good practice would be to use `UIAccessibility.post(notification:.announcement, argument:"Hello World!")`. However, using this modifies the system vibrations behavior and creates confusion by acting as follows:
        * 1. When moving the finger on an element on the map, the haptic feedback is correct.
        * 2. Once the user touches an element, this SpokenFeedbackObserver sends a UIAccessibility announcement to describe the element using VoiceOver
        * 3. After a few milliseconds, iOS turns the vibrations off
        * 4. Once VoiceOver finished reading the text, iOS turns the vibrations back on using a fade transition
        * 5. Moreover, if the user moves the finger on another element while speaking, no vibrations will be felt.
        */
        
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: readingString)
        utterance.voice = AVSpeechSynthesisVoice(language: Locale.current.languageCode)
        utterance.rate = synthesizerRate
        synthesizer.speak(utterance)
    }
    
}
