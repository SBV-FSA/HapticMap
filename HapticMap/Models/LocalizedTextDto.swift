//
//  LocalizedTextDto.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import Foundation

/// A data transfer object representing a localized text.
public struct LocalizedTextDto: Codable {
    
    /// Language code [ISO 639-1: two-letter codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
    let language: String
    
    /// The localized text.
    let value: String
    
}
