//
//  RepositoryProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import Combine
import Foundation

/// Generic repository interface.
protocol RepositoryProtocol {
    
    /// Type of the entities managed by the repository.
    associatedtype T
    
    /// A publisher constantly returning current values in the repository.
    var allEntitiesPublisher: AnyPublisher<[T], Error> { get }
    
    /// Deletes an entity.
    func delete(entity: T)
    
    /// Creates an empty entitiy.
    /// - Returns: A newly created entity.
    func create() throws -> T
    
    /// Save the repository; i.e.: commits changes.
    func save() throws
    
}
