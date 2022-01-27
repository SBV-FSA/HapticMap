//
//  FakeMapsRepository.swift
//  HapticMap
//
//  Created by Duran Timothée on 25.10.21.
//

import Combine
import CoreData

class FakeRepository<Entity: NSManagedObject>: RepositoryProtocol {
    
    var allEntitiesPublisher: AnyPublisher<[Entity], Error> {
        publisherValue.eraseToAnyPublisher()
    }
    
    var saveShouldFail = false
    var createShouldFail = false
    var flagContextSaved = false
    
    private var entities: [Entity] = []
    private var publisherValue = CurrentValueSubject<[Entity], Error>([])
    private let managedObjectContext: NSManagedObjectContext
    
    init(allEntitiesPublisherShouldFail: Bool = false) {
        managedObjectContext = PersistenceController.init(inMemory: true).container.viewContext
        if allEntitiesPublisherShouldFail {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.publisherValue.send(completion: .failure(RepositoryError.other))
            }
        }
    }
    
    func finishPublisher() {
        publisherValue.send(completion: .finished)
    }
    
    func delete(entity: Entity) {
        entities.removeAll(where: {$0 == entity})
        publisherValue.send(entities)
    }
    
    func create() throws -> Entity {
        if createShouldFail {
            throw RepositoryError.cannotCreateEntity
        }
        let className = String(describing: Entity.self)
        return NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as! Entity
    }
    
    func save() throws {
        if saveShouldFail {
            throw RepositoryError.cannotSaveContext
        }
        flagContextSaved = true
    }
    
}
