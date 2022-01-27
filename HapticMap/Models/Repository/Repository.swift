//
//  ItinariesRepository.swift
//  HapticMap
//
//  Created by Duran Timothée on 14.10.21.
//

import Combine
import CoreData
import Foundation

/// A generic repository used to interact with an underlaying CoreData persistant sotrage.
class Repository<Entity: NSManagedObject>: NSObject, RepositoryProtocol, NSFetchedResultsControllerDelegate {
    
    var allEntitiesPublisher: AnyPublisher<[Entity], Error> {
        itinerariesValue.eraseToAnyPublisher()
    }
    
    private let managedObjectContext: NSManagedObjectContext
    
    private let itinerariesController: NSFetchedResultsController<Entity>
    
    private var itinerariesValue = CurrentValueSubject<[Entity], Error>([])
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        let request: NSFetchRequest<Entity> = NSFetchRequest<Entity>(entityName: String(describing: Entity.self))
        
        request.sortDescriptors = []
        itinerariesController = NSFetchedResultsController(fetchRequest: request,
                                                       managedObjectContext: managedObjectContext,
                                                       sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        itinerariesController.delegate = self
        
        do {
            try itinerariesController.performFetch()
            self.itinerariesValue.value = itinerariesController.fetchedObjects ?? []
        } catch {
            itinerariesValue.send(completion: .failure(error))
        }
    }
    
    func create() throws -> Entity {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            throw RepositoryError.fetchRequestFailed
        }
        return managedObject
    }
    
    func delete(entity: Entity) {
        managedObjectContext.delete(entity)
    }
    
    func save() throws {
        try managedObjectContext.save()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedItineraries = controller.fetchedObjects as? [Entity]
        else { return }
        self.itinerariesValue.value = fetchedItineraries
    }
    
}
