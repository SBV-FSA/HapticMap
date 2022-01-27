//
//  NewMapVMError.swift
//  HapticMap
//
//  Created by Duran Timothée on 25.10.21.
//

import Foundation

enum NewMapVMError: LocalizedError {
    case creationFailed
    case fileNotFound
    case missingFile
    case missingMap
    case savingFailed
    
    var errorDescription: String? {
        switch self {
        case .creationFailed:
            return NSLocalizedString("error_creation_failed", comment: "Impossible to create a new map. This might be due to a lack of space on the device")
        case .fileNotFound:
            return NSLocalizedString("error_file_not_found", comment: "Indicates that the given file was not found")
        case .missingFile:
            return NSLocalizedString("error_missing_file", comment: "Indicates that a fils is expected but isn't found")
        case .missingMap:
            return NSLocalizedString("error_missing_map", comment: "Indicates that a map is expected but isn't found")
        case .savingFailed:
            return NSLocalizedString("error_saving_failed", comment: "Indicates that an error occured during saving")
        }
    }
}
