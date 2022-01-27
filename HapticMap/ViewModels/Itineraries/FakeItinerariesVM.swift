//
//  FakeItinerariesVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 04.10.21.
//

import CoreData
import Foundation

/// Fake implementation of `ItinariesVMProtocol` for SwiftUI Preview purposes.
class FakeItinerariesVM: ItinariesVMProtocol {
    
    @Published var activityItem: ActivityItemWrapper?
    @Published var errorPacket: ErrorPacket? = nil
    @Published var itineraries: [Itinerary] = []
    @Published var editingItinerary: Itinerary? = nil
    @Published var showNewItinerarySheet = false
    
    private let failedOnDelete: Bool
    
    init(seed: Bool = true, failedOnDelete: Bool = false, failedOnRetreive: Bool = false) {
    
        self.failedOnDelete = failedOnDelete
        
        if failedOnRetreive {
            errorPacket = ErrorPacket(error: RepositoryError.fetchRequestFailed)
        }
        
        if seed {
            let previewContext = PersistenceController.preview.container.viewContext
            
            let itinerary1 = Itinerary(context: previewContext)
            itinerary1.name = "Work to Home"
            
            let itinerary2 = Itinerary(context: previewContext)
            itinerary2.name = "Train Station to Hospital"
            
            let itinerary3 = Itinerary(context: previewContext)
            try! previewContext.save()
            itineraries = [itinerary1, itinerary2, itinerary3]
        }
        
    }
    
    func delete(itinaries: [Itinerary]) {
        if failedOnDelete {
            errorPacket = ErrorPacket(error: RepositoryError.fetchRequestFailed)
        }
        
        itinaries.forEach { itinerary in
            self.itineraries.removeAll { $0.name == itinerary.name}
        }
    }

}
