//
//  CHHapticPattern + patterns.swift
//  HapticMap
//
//  Created by Duran Timothée on 05.01.22.
//

import CoreHaptics
import Foundation

extension CHHapticPattern {
    
    /// A continuous, smooth and slow stride pattern.
    static var smoothSlowStride: CHHapticPattern? {
        var events = [CHHapticEvent]()

        for i in Swift.stride(from: 0, to: 10, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(0.1))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        let pattern = try? CHHapticPattern(events: events, parameters: [])
        return pattern
    }
    
    /// A continuous, sharp and slow stride pattern.
    static var smoothSharpStride: CHHapticPattern? {
        var events = [CHHapticEvent]()

        for i in Swift.stride(from: 0, to: 10, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        let pattern = try? CHHapticPattern(events: events, parameters: [])
        return pattern
    }
    
    
    /// An intermitent, smooth and fast stride pattern.
    static var smoothFastBatchStride: CHHapticPattern? {
        var events = [CHHapticEvent]()

        for i in Swift.stride(from: 0, to: 10, by: 0.01) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(0.1))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            if i.truncatingRemainder(dividingBy: 1) < 0.5 {
                events.append(event)
            }
            
        }
        let pattern = try? CHHapticPattern(events: events, parameters: [])
        return pattern
    }
    
    /// A continuous, smooth and fast stide pattern.
    static var smoothFastStride: CHHapticPattern? {
        var events = [CHHapticEvent]()

        for i in Swift.stride(from: 0, to: 1, by: 0.03) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(0.1))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        let pattern = try? CHHapticPattern(events: events, parameters: [])
        return pattern
    }
    
}
