//
//  NewMapVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import Foundation
import UIKit

/// NewMapView ViewModel Protocol.
protocol NewMapVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// Error Packet containing informations if an error occured.
    var errorPacket: ErrorPacket? { get set }
    
    /// The name of the imported file.
    var fileName: String? { get set }
    
    /// The image loaded using the "Import form Library" method.
    var inputImage: UIImage? { get set }
    
    /// True if the user is currently choosing between importing from library or files.
    var isChoosingImportMethod: Bool { get set }
    
    /// True if the user is currently importing a map from the photo library.
    var isImportingPhoto: Bool { get set }
    
    /// True if the user is currently importhing a map form the files picker.
    var isImportingFile: Bool { get set }
    
    var isLoading: Bool { get set }
    
    /// The name of the new map.
    var mapName: String { get set }
    
    // MARK: - Methods
    
    /// Loads the given file in memory and adapts UI variables.
    /// - Parameters:
    ///   - fileImporterResult: A result encapsulating the imported file local URL or an error.
    func loadFile(fileImporterResult: Result<URL, Error>)
    
    /// Saves the newly created map.
    /// - Parameters:
    ///   - completion: A completion handler returning a success if the map is correctly saved or an error otherwise.
    func save(completion: @escaping (Result<Void, Error>) -> Void)
    
}
