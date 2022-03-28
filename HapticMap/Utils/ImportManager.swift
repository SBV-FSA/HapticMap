//
//  ImportManager.swift
//  HapticMap
//
//  Created by Timothée Duran on 19.03.22.
//

import Foundation

class ImportManager {
    
    static func importItinerary(from url: URL, persistenceController: PersistenceController) {
        do {
            let data = try Data(contentsOf: url)
            let itineraryDto = try JSONDecoder().decode(ItineraryDto.self, from: data)
            let context = persistenceController.container.viewContext
            let _ = Itinerary(context: context, dto: itineraryDto)
            try context.save()
        } catch {
            
        }
        
        try? FileManager.default.removeItem(at: url)
    }
    
}
