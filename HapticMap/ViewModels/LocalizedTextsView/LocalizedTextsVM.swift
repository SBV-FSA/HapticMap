//
//  LocalizedTextsVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.12.21.
//

import Combine
import Foundation

class LocalizedTextsVM<Repository: RepositoryProtocol>: LocalizedTextsVMProtocol {
    
    var element: Element
    
    var hexString: String
    
    @Published var showNewLocalizedText: Bool = false
    
    @Published var errorPacket: ErrorPacket? = nil
    
    @Published var translations: [LocalizedText] = []
    
    var repository: Repository
    
    private var cancellable: Cancellable?
    
    init(element: Element, repository: Repository) {
        self.element = element
        self.repository =  repository
        hexString = "#" + (element.color ?? "")
        
        self.translations = element.descriptionsArray.sorted{$0.wrappedReadableLanguage < $1.wrappedReadableLanguage}

        cancellable = repository.allEntitiesPublisher.sink { completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: { localizedTextArray in
            self.translations = element.descriptionsArray.sorted{$0.wrappedReadableLanguage < $1.wrappedReadableLanguage}
        }
    }
    
    func delete(indexSet: IndexSet) {
        indexSet.compactMap{translations[$0] as? Repository.T}.forEach{repository.delete(entity: $0)}
        do {
            try repository.save()
            translations.remove(atOffsets: indexSet)
        } catch {
            errorPacket = ErrorPacket(error: error)
        }
    }
    
}
