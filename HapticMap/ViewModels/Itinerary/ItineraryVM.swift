//
//  ItineraryVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//

import Combine
import Foundation
import SwiftUI

class ItineraryVM<Repository: RepositoryProtocol>: ItineraryVMProtocol {
    
    var selectedMap: Map?
    
    @Published var errorPacket: ErrorPacket? = nil
    
    @Published var maps: [Map] = []

    @Published var showNewMapSheet = false
    
    @Published var itinerary: Itinerary? {
        didSet {
            maps = itinerary?.mapsArray ?? []
        }
    }
    
    private var cancellables = [AnyCancellable]()
    private var repository: Repository
    
    init(repository: Repository, itinerary: Itinerary? = nil) {
        self.itinerary = itinerary
        self.maps = itinerary?.mapsArray ?? []
        self.repository = repository
    }
    
    func move(from source: IndexSet, to destination: Int) {
        maps.move(fromOffsets: source, toOffset: destination)
        for (index,map) in maps.enumerated() {
            map.order = NSNumber(value: index)
        }
        do {
            try repository.save()
        } catch {
            errorPacket = ErrorPacket(error: error)
        }
    }
    
    func delete(indexSet: IndexSet) {
        indexSet.compactMap{maps[$0] as? Repository.T}.forEach{repository.delete(entity: $0)}
        do {
            try repository.save()
            withAnimation {
                maps.remove(atOffsets: indexSet)
            }
        } catch {
            errorPacket = ErrorPacket(error: error)
        }
    }
    
    func reloadMaps() {
        maps = itinerary?.mapsArray ?? []
    }

}
