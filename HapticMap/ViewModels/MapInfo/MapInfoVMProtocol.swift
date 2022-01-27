//
//  MapInfoVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

/// MapInfoView ViewModel Protocol.
protocol MapInfoVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The list of official categories found on the map, ordered by alphabetical order in the user's language.
    var officialCategories: [Element] { get set }
    
    /// The list of custom categories found on the map, ordered by alphabetical order in the user's language or any fallback language if it doesn't inculde the language.
    var customCategories: [Element] { get set }
    
    /// The list of unassigned categories found on the map, ordered by alphabetical order in the user's language.
    var unassignedCategories: [Element] { get set }
    
    func loadColors()

}
