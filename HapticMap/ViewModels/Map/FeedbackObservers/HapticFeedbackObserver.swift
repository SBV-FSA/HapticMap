//
//  HapticFeedbackObserver.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import CoreHaptics
import Foundation

/// An observer responsible for issuing vibrations or hapitc feedback.
class HapticFeedbackObserver: FeedbackObserver {
    
    /// Constant for a haptic pattern representing a car crash.
    private let HAPTIC_CAR_CRASH_FILE = "car_crash_1"
    
    /// Constant for a haptic pattern representing a concrete collision.
    private let HAPTIC_CONCRETE_FILE = "concrete_3"
    
    /// Constant for haptic pattern files extension.
    private let HAPTIC_PATTERN_EXTENSION = "ahap"
    
    /// The set of categories that should be represented using this observer.
    private var categories = Set<Category>()
    
    /// HapticEngine used to issue vibrations.
    private var engine: CHHapticEngine?
    
    /// Stores the last category detected for the gesture. Nil after touch ends.
    private var lastCategory: Category?
    
    /// Instance of `CHHapticAdvancedPatternPlayer`.
    private var player: CHHapticAdvancedPatternPlayer?
    
    override init() {
        super.init()
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
        if let categories = PreferenceRepository().activeCategories[.haptic] {
            self.categories = categories
        }
        configureHandlers()
    }
    
    override func touchBegan(with category: Category?, userInfo: String? = nil) {
        guard let category = category else {
            try? player?.cancel()
            return
        }
        playHaptic(for: category)
        lastCategory = category
    }
    
    override func touchMoved(with category: Category?, userInfo: String? = nil) {
        guard let category = category else {
            try? player?.cancel()
            return
        }
        playHaptic(for: category)
        lastCategory = category
    }
    
    override func touchEnded(with category: Category?, userInfo: String? = nil) {
        try? player?.cancel()
        lastCategory = nil
    }
    
    /// Configures actions when engine stops or resets such as restarting the engine if it failed.
    private func configureHandlers() {
        // The engine stopped; print out why
        engine?.stoppedHandler = { reason in
            print("The engine stopped: \(reason)")
        }

        // If something goes wrong, attempt to restart the engine immediately
        engine?.resetHandler = { [weak self] in
            print("The engine reset")

            do {
                try self?.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }
    
    /// Plays a suited haptic feedback if needed.
    /// - Parameter category: The category to play.
    private func playHaptic(for category: Category) {
        if !categories.contains(category) {
            try? player?.cancel()
            return
        }
        
        // 1. Checks if a haptic pattern should be played using a file.
        var file: String?
        switch category {
        case .border:
            file = Bundle.main.path(forResource: HAPTIC_CAR_CRASH_FILE, ofType: HAPTIC_PATTERN_EXTENSION)
        case .empty:
            if lastCategory != .border && lastCategory != .empty && lastCategory != nil {
                file = Bundle.main.path(forResource: HAPTIC_CONCRETE_FILE, ofType: HAPTIC_PATTERN_EXTENSION)
            }
        default:
            break
        }
        
        if let file = file, let engine = engine {
            try? player?.cancel()
            try? engine.playPattern(from: URL(fileURLWithPath: file))
            return
        }

        // 2. Checks if a haptic pattern should be played using code.
        var pattern:CHHapticPattern?
        switch category {
        case .intersection:
            pattern = .smoothFastBatchStride
        case .itinerary:
            pattern = .smoothSharpStride
        case .pedestrianCrossing, .pedestrianCrossingWithLights:
            pattern = .smoothFastStride
        case .road, .other:
            pattern = .smoothSlowStride
        default:
            break
        }
        
        if let pattern = pattern, let engine = engine {
            try? player?.cancel()
            player = try? engine.makeAdvancedPlayer(with: pattern)
            player?.loopEnabled = true
            try? player?.start(atTime: 0)
        }
        
    }
    
}
