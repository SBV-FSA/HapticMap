//
//  Map+NSItemProvider.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.11.21.
//

import Foundation
import UniformTypeIdentifiers

extension Map: NSItemProviderReading {

    public static var readableTypeIdentifiersForItemProvider: [String] {
        return [typeIdentifier.identifier]
    }

    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Map {
        let decodedMap = try JSONDecoder().decode(MapDto.self, from: data)
        let ctx = PersistenceController.shared.container.viewContext
        let map = Map(context: ctx)
        map.name = decodedMap.name
        map.image = NSData(data: decodedMap.imageData)
        return map
    }
    
}

extension Map: NSItemProviderWriting {
    
    /// Custom UTType representing this map.
    static public let typeIdentifier = UTType("ch.elca.hapticmap.hcmp")!
    
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [typeIdentifier.identifier]
    }
    
    public func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        guard let dto = dto else {
            completionHandler(nil, nil)
            return nil
        }
        
        let encodedMap = try? JSONEncoder().encode(dto)
        completionHandler(encodedMap, nil)
        return nil
    }

}
