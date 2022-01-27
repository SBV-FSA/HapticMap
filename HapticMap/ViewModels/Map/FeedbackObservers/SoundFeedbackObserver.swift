//
//  SoundFeedbackObserver.swift
//  HapticMap
//
//  Created by Duran Timothée on 02.11.21.
//

import AVFoundation
import Foundation

var player: AVAudioPlayer?

/// An observer responsible for playing sounds.
class SoundFeedbackObserver: FeedbackObserver {
    
    /// The set of categories that should be represented using this observer.
    private var categories = Set<Category>()
    
    override init() {
        super.init()
        if let categories = PreferenceRepository().activeCategories[.sound] {
            self.categories = categories
        }
    }
    
    override func touchBegan(with category: Category?, userInfo: String? = nil) {
        if let category = category {
            play(category: category)
        }
    }
    
    override func touchMoved(with category: Category?, userInfo: String? = nil) {
        if let category = category {
            play(category: category)
        }
    }
    
    override func touchEnded(with category: Category?, userInfo: String? = nil) {
        
    }
    
    /// Plays a sound for the fiven category if needed.
    /// - Parameter category: The category to play.
    private func play(category: Category) {
        
        if !categories.contains(category) { return }
        
        guard let url = Bundle.main.url(forResource: category.rawValue, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
