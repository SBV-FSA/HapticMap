//
//  FakeNewItineraryVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.10.21.
//

import Combine
import Foundation

/// Fake implementation of `NewItineraryVMProtocol` for SwiftUI Preview purposes.
class FakeNewItineraryVM: NewItineraryVMProtocol {
    
    var isEditing: Bool = false
    
    var errorPacket: ErrorPacket? = nil
    
    var shouldDismissViewPublisher = PassthroughSubject<Bool, Never>()
    
    var itineraryName: String = ""
    
    func save() { }
}
