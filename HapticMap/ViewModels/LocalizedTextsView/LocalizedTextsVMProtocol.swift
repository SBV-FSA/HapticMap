//
//  LocalizedTextsVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.12.21.
//

import Foundation

/// LocalizedTextsView ViewModel Protocol.
protocol LocalizedTextsVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The element.
    var element: Element { get set }
    
    /// Error Packet containing informations if an error occured.
    var errorPacket: ErrorPacket? { get set }
    
    /// The hexadecimal string representing the color including `#`.
    var hexString: String { get set }
    
    /// Boolean indicating if the view should display an interface to create a new localized text.
    var showNewLocalizedText: Bool { get set }
    
    /// The list of all translations linked to the element ordered by localized language name.
    var translations: [LocalizedText] { get set }
    
    // MARK: - Methods
    
    /// Permanently delete the localized texts displayed at the given offsets.
    func delete(indexSet: IndexSet)
    
}
