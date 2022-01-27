//
//  NewItineraryVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.10.21.
//

import Combine
import Foundation

class NewItineraryVM<Repository: RepositoryProtocol>: NewItineraryVMProtocol {
    
    var isEditing: Bool = false
    
    var errorPacket: ErrorPacket? = nil
    
    var shouldDismissViewPublisher = PassthroughSubject<Bool, Never>()
    
    private var shouldDismissView = false {
            didSet {
                shouldDismissViewPublisher.send(shouldDismissView)
            }
        }
    
    @Published var itineraryName: String = ""
    
    /// The provided itinerary
    private var providedItinerary: Itinerary? = nil
    
    /// The repository used to fetch, create and save the itinerary.
    private let repository: Repository
    
    /// Default initializer. Takes as parameter a repository used to saved the newly created map and an optional itinerary.
    /// - Parameters:
    ///   - repository: The repository used to perfom operations on the newly created map.
    ///   - itinerary: Optionally, an itinerery to edit.
    init(repository: Repository, itinerary: Itinerary? = nil) {
        self.repository = repository
        if let itinerary = itinerary {
            self.providedItinerary = itinerary
            self.itineraryName = itinerary.wrappedName
            self.isEditing = true
        }
    }
    
    /// Saves current values to the repository and returns a completion handler.
    /// - Parameter completion: A `Result` returning a success of failure with an error.
    func save() {
        guard let itinerary = try? providedItinerary ?? repository.create() as? Itinerary else {
            return errorPacket = ErrorPacket(error: NewItineraryVMError.creationFailed)
        }
        itinerary.name = itineraryName
        
        do {
            try repository.save()
            return shouldDismissView = true
        } catch {
            return errorPacket = ErrorPacket(error: NewItineraryVMError.savingFailed)
        }
    }
    
}
