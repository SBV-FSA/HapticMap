//
//  FakeMapInfoVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

/// Fake implementation of `MapInfoVMProtocol` for SwiftUI Preview purposes.
class FakeMapInfoVM: MapInfoVMProtocol {
    
    var officialCategories: [Element] = []
    var customCategories: [Element] = []
    var unassignedCategories: [Element] = []
    
    init() {
    }
    
    func loadColors() {}
}
