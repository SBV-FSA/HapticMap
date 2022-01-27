//
//  RepositoryError.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import Foundation

/// Error thrown by the repository.
enum RepositoryError: Error {
    
    /// An error occured while creating an entity. _e.g., no space left on device._
    case cannotCreateEntity
    
    /// An error occured while saving the CoreData context. _e.g., no space left on device._
    case cannotSaveContext
    
    /// An error occured while fetching entities. _e.g., the underlaying fetch request is incorrect._
    case fetchRequestFailed
    
    /// An error occured for reasons not listed in this enum.
    case other
    
}
