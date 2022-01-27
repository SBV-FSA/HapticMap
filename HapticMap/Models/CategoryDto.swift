//
//  CategoryDto.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import Foundation

/// A user defined category displayed on the map.
struct CategoryDto: Codable {
    
    /// The hexadecimal color of this custom category. (e.g.: #FF2312).
    let color: String
    
    /// User defined description of this color, one item per language. Nil means that this category is part of the offical set provided with the app.
    let descriptions: [LocalizedString]?
    
}
