//
//  FakeNewLocalizedTextVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

/// Fake implementation of `NewLocalizedTextVMProtocol` for SwiftUI Preview purposes.
class FakeNewLocalizedTextVM: NewLocalizedTextVMProtocol {
    
    @Published var selectedLanguage = Locale.current.languageCode ?? ""
    
    @Published var description = ""
    
    var availableLanguages = ["fr", "de", "en", "it"]
    
    func save(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
}
