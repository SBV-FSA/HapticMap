//
//  ElementDto.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import Foundation

/// A data transfer object representing a map element.
public struct ElementDto: Codable {
    
    /// The hexadecimal color of the element, without `#`.
    let color: String
    
    /// The localized descriptions of the element.
    let descriptions: [LocalizedTextDto]
    
}
