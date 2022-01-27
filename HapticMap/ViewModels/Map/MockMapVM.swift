//
//  FakeMapViewModel.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import UIKit

class MockMapVM: MapVMProtocol {
    
    var map: Map
    
    @Published var showInfos: Bool = false
    
    var preferenceRepository: PreferenceRepository = PreferenceRepository(defaults: .makeClearedInstance())
    
    var touchBeganCalled = false
    
    var touchMovedCalled = false
    
    var touchEndedCalled = false
    
    func touchBegan(with color: UIColor) { }
    
    func touchMoved(with color: UIColor) { }
    
    func touchEnded(with color: UIColor) { }
    
    func refreshCategories() { }
    
    init() {
        let repository = Repository<Map>(managedObjectContext: PersistenceController.preview.container.viewContext)
        let map = try! repository.create() as Map
        let imageData = UIImage(named: "map-size-color-test")?.pngData()!
        map.image = NSData(data: imageData!)
        try! repository.save()
        self.map = map
    }
    
}
