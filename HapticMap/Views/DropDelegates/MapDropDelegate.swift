//
//  MapDropDelegate.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import SwiftUI
import UniformTypeIdentifiers

/// DropDelegate reacting to map drops.
struct MapDropDelegate: DropDelegate {
    
    /// The itinerary where the dropped occured.
    var itinerary: Itinerary
    
    func performDrop(info: DropInfo) -> Bool {
        if let item = info.itemProviders(for: [UTType.data]).first {
            DispatchQueue.main.async {
                item.loadObject(ofClass: Map.self) { reader, error in
                    guard let map = reader as? Map else {
                        return
                    }
                    map.itinerary = itinerary
                    try? map.managedObjectContext?.save()
                }}
        }
        return true
    }
    
}
