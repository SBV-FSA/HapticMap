//
//  TestCoreDataStack.swift
//  HapticMapTests
//
//  Created by Duran Timothée on 14.10.21.
//

import CoreData
import HapticMap

class TestCoreDataStack: PersistenceController {
    
    override init(inMemory: Bool = false) {
        super.init(inMemory: true)
    }
    
}
