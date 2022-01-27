//
//  ErrorPacket.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//

import Foundation

/// Error wrapper, mainly used for SwiftUI purposes.
struct ErrorPacket: Identifiable {
    
    /// Universally unique identifier of the packet, unrelated to the underlaying error.
    let id = UUID()
    
    /// The encapsulated error.
    let error: Error
    
}
