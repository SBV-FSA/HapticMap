//
//  FakeItineraryVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//

import Foundation

/// Fake implementation of `ItineraryVMProtocol` for SwiftUI Preview purposes.
class FakeItineraryVM: ItineraryVMProtocol {
    
    var selectedMap: Map?
    
    var errorPacket: ErrorPacket? = nil
    
    var maps: [Map] = []
    
    var itinerary: Itinerary?
    
    var showNewMapSheet = false
    
    init() {
    
        let previewContext = PersistenceController.preview.container.viewContext
        
        itinerary = Itinerary(context: previewContext)
        
        let map1 = Map(context: previewContext)
        map1.name = "Train Station"
        map1.itinerary = itinerary
        
        let map2 = Map(context: previewContext)
        map2.name = "Marketplace"
        map2.itinerary = itinerary
        
        let map3 = Map(context: previewContext)
        map3.itinerary = itinerary

        maps = [map1, map2, map3]
    }
    
    func move(from source: IndexSet, to destination: Int) {
        maps.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(indexSet: IndexSet) {
        maps.remove(atOffsets: indexSet)
    }
    
    func reloadMaps() {
        
    }
    
}
