//
//  FakeNewMapVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 25.10.21.
//

import UIKit

/// Fake implementation of `NewMapVMProtocol` for SwiftUI Preview purposes.
class FakeNewMapVM: NewMapVMProtocol {
    
    @Published var errorPacket: ErrorPacket?
    
    @Published var fileName: String?
    
    @Published var inputImage: UIImage? = nil
    
    @Published var isChoosingImportMethod: Bool = false
    
    @Published var isImportingPhoto: Bool = false
    
    @Published var isImportingFile: Bool = false
    
    @Published var isLoading: Bool = false
    
    @Published var mapName: String = ""
    
    /// Set this value to simulate an error on save.
    var errorOnSave: Error?
    
    func loadFile(fileImporterResult: Result<URL, Error>) {
        
    }
    
    func save(completion: (Result<Void, Error>) -> Void) {
        if let errorOnSave = errorOnSave {
            completion(.failure(errorOnSave))
        } else {
            completion(.success(()))
        }
    }
    
}
