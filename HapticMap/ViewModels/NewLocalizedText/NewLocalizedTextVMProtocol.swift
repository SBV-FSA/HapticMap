//
//  NewLocalizedTextVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

/// NewLocalizedTextView ViewModel Protocol.
protocol NewLocalizedTextVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The list of available languages as ISO 639-1 codes.
    var availableLanguages: [String] { get }
    
    /// The user defined description in the `selectedLanguage` language.
    var description: String { get set }
    
    /// The selected language as ISO 639-1 code.
    var selectedLanguage: String { get set }
    
    // MARK: - Methods
    
    /// Saves the newly created map.
    /// - Parameters:
    ///   - completion: A completion handler returning a success if the map is correctly saved or an error otherwise.
    func save(completion: @escaping (Result<Void, Error>) -> Void)
    
}
