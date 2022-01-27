//
//  Itinerary+NSItemProvider.swift
//  HapticMap
//
//  Created by Duran Timothée on 19.11.21.
//
//

import Foundation
import UniformTypeIdentifiers

extension Itinerary: NSItemProviderReading {
    
    public static var readableTypeIdentifiersForItemProvider: [String] {
        return [typeIdentifier.identifier]
    }

    public static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Itinerary {
        let decodedItinerary = try JSONDecoder().decode(ItineraryDto.self, from: data)
        let ctx = PersistenceController.shared.container.viewContext
        let itinerary = Itinerary(context: ctx, dto: decodedItinerary)
        try ctx.save()
        return itinerary
    }
    
}

extension Itinerary: NSItemProviderWriting {
    
    /// Custom UTType representing this itinerary.
    static public let typeIdentifier = UTType("ch.elca.hapticmap.hcit")!
    
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [typeIdentifier.identifier]
    }
    
    public func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        guard let data = self.data else {
            completionHandler(nil, nil)
            return nil
        }
        completionHandler(data, nil)
        return nil
    }
    
}
