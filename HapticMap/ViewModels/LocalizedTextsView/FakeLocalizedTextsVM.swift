//
//  FakeLocalizedTextsVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.12.21.
//

import Foundation

/// Fake implementation of `LocalizedTextsVMProtocol` for SwiftUI Preview purposes.
class FakeLocalizedTextsVM: LocalizedTextsVMProtocol {
    
    @Published var errorPacket: ErrorPacket? = nil
    
    @Published var showNewLocalizedText: Bool = false
    
    var element: Element
    
    var hexString: String = "#F3AB4C"
    
    var translations: [LocalizedText] = []
    
    init(isEmtpy: Bool = false) {
        
        element = Element(context: PersistenceController.preview.container.viewContext)
        if !isEmtpy {
            let ctx = PersistenceController.preview.container.viewContext
            let word1 = LocalizedText(context: ctx)
            word1.language = "en"
            word1.value = "Room 123"
            
            let word2 = LocalizedText(context: ctx)
            word2.language = "fr"
            word2.value = "Salle 123"
            
            translations = [word1, word2]
        }
        
    }
    
    func delete(indexSet: IndexSet) {
        //maps.remove(atOffsets: indexSet)
    }
    
}
