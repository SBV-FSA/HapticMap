//
//  ItinariesVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 04.10.21.
//

import Combine
import CoreData
import Foundation
import SwiftUI

class ItinariesVM<Repository: RepositoryProtocol>: ItinariesVMProtocol {
    
    @Published var activityItem: ActivityItemWrapper?
    @Published var errorPacket: ErrorPacket? = nil
    @Published var itineraries: [Itinerary] = []
    @Published var editingItinerary: Itinerary? = nil
    @Published var showNewItinerarySheet = false
    private var cancellables = [AnyCancellable]()
    
    private let repository: Repository
    
    init(model: Repository) {
        
        self.repository = model
        self.repository.allEntitiesPublisher.sink { state in
            switch state {
            case .finished:
                return
            case .failure(let error):
                self.errorPacket = ErrorPacket(error: error)
            }
        } receiveValue: { itin in
            switch itin {
            case let (itineraries as [Itinerary]) as Any: // https://stackoverflow.com/questions/49406684/switch-on-array-type
                self.itineraries = itineraries
            default:
                break
            }
        }.store(in: &cancellables)

    }
    
    func delete(itinaries: [Itinerary]) {
        itinaries.compactMap{$0 as? Repository.T}.forEach { repository.delete(entity: $0)}
        do {
            try repository.save()
        } catch {
            self.errorPacket = ErrorPacket(error: error)
        }
    }
    
}
