//
//  NewLocalizedTextVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 16.12.21.
//

import Foundation

class NewLocalizedTextVM<Repository: RepositoryProtocol>: NewLocalizedTextVMProtocol {
    
    @Published var selectedLanguage: String
    
    @Published var description = ""
    
    let availableLanguages: [String]
    
    private let repository: Repository
    
    private let category: Element
    
    init(category: Element, repository: Repository) {
        self.category = category
        self.repository = repository
        
        let existingLocalizations = category.descriptionsArray.compactMap{$0.language}
        availableLanguages = ["fr", "de", "en", "it"]
            .filter{!existingLocalizations.contains($0)}
            .sorted {Locale.current.localizedString(forLanguageCode: $0) ?? "" < Locale.current.localizedString(forLanguageCode: $1) ?? ""}
        
        if availableLanguages.contains(where: {$0 == Locale.current.languageCode}) {
            selectedLanguage = Locale.current.languageCode ?? ""
        } else {
            selectedLanguage = availableLanguages.first ?? ""
        }
    }
    
    func save(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let localizedText = try repository.create() as! LocalizedText
            localizedText.value = description
            localizedText.language = selectedLanguage
            localizedText.category = category
            try repository.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
    
}
