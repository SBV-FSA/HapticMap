//
//  ItinariesVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 04.10.21.
//

import Foundation

/// ItinariesView ViewModel Protocol.
protocol ItinariesVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The selected itinerary used to present a `ActivityView` or `UIActivityViewController` instance for sharing purposes.
    var activityItem: ActivityItemWrapper? { get set }
    
    /// The itinerary beeing currently edited by the user.
    var editingItinerary: Itinerary? { get set }
    
    /// Error Packet containing informations if an error occured.
    var errorPacket: ErrorPacket? { get set }
    
    /// The list of itineraries, ordered by alphabetical order.
    var itineraries: [Itinerary] { get set }
    
    /// Boolean indicating if the view should display an interface to create itineraries.
    var showNewItinerarySheet: Bool { get set }
    
    // MARK: - Methods
    
    /// Permanently delete the itinary displayed at the given offsets.
    func delete(itinaries: [Itinerary])
    
}
