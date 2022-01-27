//
//  ActivityItemsWrapper.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.11.21.
//

import Foundation

/// Wrapper struct to simplify SwiftUI's usage. Usefull when working with `UIActivityViewController`.
struct ActivityItemWrapper: Identifiable {
    
    /// ID used by SwiftUI.
    let id = UUID()
    
    /// The element to share.
    let element: Any
    
}
