//
//  MapInfoVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

class MapInfoVM: MapInfoVMProtocol {
    
    @Published var officialCategories = [Element]()
    @Published var customCategories = [Element]()
    @Published var unassignedCategories = [Element]()
    
    private let map: Map
    
    init(map: Map) {
        self.map = map
    }
    
    func loadColors() {
        officialCategories = map
            .elementsArray.filter{$0.category != .other}
            .sorted(by: {
                NSLocalizedString($0.category.rawValue, comment: "Translation of the category") < NSLocalizedString($1.category.rawValue, comment: "Translation of the category")
            })
        customCategories = map.elementsArray
            .filter{$0.category == .other && !$0.descriptionsArray.isEmpty}
            .sorted(by: {$0.localizedDescription?.value ?? "" < $1.localizedDescription?.value ?? ""})
        unassignedCategories = map.elementsArray
            .filter{$0.category == .other && $0.descriptionsArray.isEmpty}
            .sorted(by: {$0.uiColor?.hexString ?? "" < $1.uiColor?.hexString ?? ""})
    }
    
}
