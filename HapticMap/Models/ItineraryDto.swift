//
//  ItineraryDto.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import Foundation

/// A data transfer object representing itineraries.
public struct ItineraryDto: Codable {
    
    /// The name of the itinerary.
    let name: String?
    
    /// The maps included in this itinerary.
    let maps: [MapDto]
    
}
