//
//  NewItineraryVMError.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.10.21.
//

import Foundation

enum NewItineraryVMError: LocalizedError {
    case creationFailed
    case missingItinerary
    case savingFailed
    
    var errorDescription: String? {
        switch self {
        case .creationFailed:
            return NSLocalizedString("error_creation_failed", comment: "Impossible to create a new itinerary. This might be due to a lack of space on the device")
        case .missingItinerary:
            return NSLocalizedString("error_missing_itinerary", comment: "Indicates that a itinerary is expected but isn't found")
        case .savingFailed:
            return NSLocalizedString("error_saving_failed", comment: "Indicates that an error occured during saving")
        }
    }
}
