//
//  NewMapVM.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.10.21.
//

import Foundation
import UIKit

class NewMapVM<Repository: RepositoryProtocol, ElementRepository: RepositoryProtocol>: NewMapVMProtocol {

    @Published var errorPacket: ErrorPacket? = nil
    
    @Published var fileName: String?
    
    @Published var inputImage: UIImage? = nil {
        didSet {
            if let inputImage = inputImage {
                loadFile(image: inputImage)
            }
        }
    }
    
    @Published var isChoosingImportMethod: Bool = false
    
    @Published var isImportingPhoto: Bool = false
    
    @Published var isImportingFile: Bool = false

    @Published var isLoading: Bool = false
    
    @Published var mapName: String = ""
    
    private var imageData: Data?
    
    private let itinerary: Itinerary?
    
    private let repository: Repository
    
    private let elementRepo: ElementRepository
    
    private var map: Map? = nil
    
    /// Default initializer. Takes as parameter a repository used to saved the newly created map and an optional itinerary.
    /// - Parameters:
    ///   - repository: The repository used to perfom operations on the newly created map.
    ///   - itinerary: Optionally, the itinerery which the new map should belong.
    ///   - map: Optionally, a map to edit. The view will populate the fields accordingly.
    init(repository: Repository, elementRepository: ElementRepository, itinerary: Itinerary? = nil, map: Map? = nil) {
        self.repository = repository
        self.elementRepo = elementRepository
        self.itinerary = itinerary
        
        do {
            self.map = try map ?? repository.create() as? Map
            if let name = map?.wrappedName {
                mapName = name
            }
            if let _ = map?.image {
                fileName = NSLocalizedString("file_saved", comment: "Indicates that a file is saved")
            }
        } catch {
            errorPacket = ErrorPacket(error: NewMapVMError.creationFailed)
        }
    }
    
    func loadFile(fileImporterResult: Result<URL, Error>) {
        do {
            let fileUrl = try fileImporterResult.get()
            fileName = fileUrl.lastPathComponent
            if mapName == "" {
                mapName = fileUrl.humanReadableName
            }
            guard fileUrl.startAccessingSecurityScopedResource() else { return }
            imageData = try Data(contentsOf: fileUrl)
            fileUrl.stopAccessingSecurityScopedResource()
        } catch {
            errorPacket = ErrorPacket(error: NewMapVMError.fileNotFound)
        }
    }
    
    func save(completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        
        guard let map = map else {
            isLoading = false
            return completion(.failure(NewMapVMError.missingMap))
        }
        
        if let imageData = imageData {
            map.image = NSData(data: imageData)
        } else if map.image == nil {
            isLoading = false
            return completion(.failure(NewMapVMError.missingFile))
        }
        
        map.name = mapName
        if let providedItinerary = itinerary {
            map.itinerary = providedItinerary
            if map.order == nil {
                let highestOrder = providedItinerary.mapsArray.reduce(0) { partialResult, map in max(partialResult, map.wrappedOrder) }
                map.order = NSNumber(value: (highestOrder + 1))
            }
        }
        
        return map.detectColors { colors in
            colors.forEach { color in
                if let element = try? self.elementRepo.create() as? Element {
                    element.color = color.hexString
                    element.map = map
                }
            }
            
            do {
                try self.repository.save()
                try self.elementRepo.save()
                DispatchQueue.main.async {
                    completion(.success(()))
                }
                
                
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    completion(.failure(NewMapVMError.savingFailed))
                }
            }
        }
    
    }
    
    /// Loads the given image into imageData and updates the interface.
    /// - Parameter image: The image of the map to load in memory.
    private func loadFile(image: UIImage) {
        fileName = NSLocalizedString("image_from_library", comment: "An image form the device photo library")
        imageData = image.pngData()
    }
    
}
