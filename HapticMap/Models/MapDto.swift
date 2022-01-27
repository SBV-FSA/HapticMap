//
//  MapDto.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import Foundation

/// A data transfer object representing a map.
public struct MapDto: Codable {
    
    /// The elements found in the map, i.e. categories like roads, buildings, etc.
    let elementsArray: [ElementDto]
    
    /// The encoded map image.
    let imageData: Data
    
    /// The map's name.
    let name: String
    
    /// The map's position in an itinerary.
    let order: Int?
    
    /// Categories included in the map. No categories means that the map has not been analysed yet.
    let elements: [ElementDto]?
    
}
