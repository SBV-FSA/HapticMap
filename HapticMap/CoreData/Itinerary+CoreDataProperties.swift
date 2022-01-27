//
//  Itinerary+CoreDataProperties.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//
//

import CoreData
import Foundation

extension Itinerary: Identifiable {
        
    // MARK: - NSManaged properties.
    
    /// The set of maps belonging to the itinerary.
    @NSManaged public var maps: NSSet?
    
    /// The name of the itinerary.
    @NSManaged public var name: String?
    
    // MARK: - Convenience initializers.
    
    convenience init(context: NSManagedObjectContext, dto: ItineraryDto) {
        self.init(context: context)
        self.name = dto.name
        dto.maps.forEach { mapDto in
            let map = Map(context: context, dto: mapDto)
            map.itinerary = self
        }
    }
    
    // MARK: - Convenience properties.

    /// The itinerary represented as a data object.
    public var data: Data? {
        let mapsDto = mapsArray.compactMap{$0.dto}
        let itineraryDto = ItineraryDto(name: name, maps: mapsDto)
        return try? JSONEncoder().encode(itineraryDto)
    }
    
    /// All the maps linked to this itinerary, ordered by position in it.
    public var mapsArray: [Map] {
        let set = maps as? Set<Map> ?? []
        return set.sorted {
            $0.wrappedOrder < $1.wrappedOrder
        }
    }
    
    /// The `name` attribute a non-optional string with a default value if nil.
    public var wrappedName: String {
        name ?? "unnamed_itinerary"
    }
    
    /// Exports the itinerary to the default FileManager and returns its url.
    /// - Returns: The local url to this itinerary, nil if an error occured or if the data is ill-formatted.
    public func exportToURL() -> URL? {
        guard let encoded = self.data else { return nil }
        
        let documents = FileManager.default.urls(
            for: .documentDirectory,
               in: .userDomainMask
        ).first
        
        guard let path = documents?.appendingPathComponent("/\(wrappedName).hcit") else {
            return nil
        }
        
        do {
            try encoded.write(to: path, options: .atomicWrite)
            return path
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    // MARK: - NSFetchRequests.
    
    /// A fetch request returning all the itineraries.
    /// - Returns: All the maps in the persistent storage.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Itinerary> {
        return NSFetchRequest<Itinerary>(entityName: "Itinerary")
    }

}

// MARK: Generated accessors for maps
extension Itinerary {
    
    @objc(addMapsObject:)
    @NSManaged public func addToMaps(_ value: Map)
    
    @objc(removeMapsObject:)
    @NSManaged public func removeFromMaps(_ value: Map)
    
    @objc(addMaps:)
    @NSManaged public func addToMaps(_ values: NSSet)
    
    @objc(removeMaps:)
    @NSManaged public func removeFromMaps(_ values: NSSet)
    
}
