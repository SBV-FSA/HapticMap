//
//  Persistence.swift
//  Test
//
//  Created by Duran Timothée on 04.10.21.
//

import CoreData

/// Controls every aspects of the app related to persistence storage.
open class PersistenceController {
    
    /// Persistent Database used for production purposes.
    public static let shared = PersistenceController()
    
    /// In-Memory Persistent Database used for preview or test purposes.
    public static let preview = PersistenceController(inMemory: true)
    
    /// CoreData's container.
    public let container: NSPersistentCloudKitContainer
    
    /// The name of the NSPersistentContainer object.
    private let cloudKitContainerName = "Model"
    
    /// Default initializer.
    /// - Parameter inMemory: Setting it to `true` creates a container living in memory with no CloudKit synchronization.
    public init(inMemory: Bool = false) {
        
        container = NSPersistentCloudKitContainer(name: cloudKitContainerName)

        if inMemory {
            let persistentStoreDescription = NSPersistentStoreDescription()
            persistentStoreDescription.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [persistentStoreDescription]
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            container.persistentStoreDescriptions.first?.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }
    
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            self.container.viewContext.automaticallyMergesChangesFromParent = true
            self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)") // TODO: Properly handle this case.
            }
        })

    }
    
}
