//
//  ItineraryVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//

import Foundation

/// ItineraryView ViewModel Protocol.
protocol ItineraryVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// Error Packet containing informations if an error occured.
    var errorPacket: ErrorPacket? { get set }
    
    /// The itinerary.
    var itinerary: Itinerary? { get set }
    
    /// The maps belonging to the itinerary, ordered by the position in it.
    var maps: [Map] { get set }

    /// The currently selected map.
    var selectedMap: Map? { get set }
    
    /// Boolean indicating if the view should display an interface to create itinerary.
    var showNewMapSheet: Bool { get set }
    
    // MARK: - Methods
    
    /// Moves a map at a given position in `itinerary`.
    func move(from source: IndexSet, to destination: Int)
    
    /// Permanently delete the map displayed at the given offsets.
    func delete(indexSet: IndexSet)
    
    /// Realoads the array of maps.
    func reloadMaps()

}
