//
//  NewItineraryVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.10.21.
//

import Combine
import Foundation

/// NewItineraryView ViewModel Protocol.
protocol NewItineraryVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// Error Packet containing informations if an error occured.
    var errorPacket: ErrorPacket? { get set }
    
    /// A boolean beeing true if in edition mode.
    var isEditing: Bool { get set }
    
    /// The name of the itinerary.
    var itineraryName: String { get set }
    
    var shouldDismissViewPublisher: PassthroughSubject<Bool, Never> { get set }
    
    // MARK: - Methods
    
    /// Saves the newly created map.
    /// - Parameters:
    ///   - completion: A completion handler returning a success if the itinerary is correctly saved or an error otherwise.
    func save()
    
}
