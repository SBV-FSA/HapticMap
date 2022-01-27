//
//  Map+CoreDataProperties.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//
//

import CoreData
import UIKit

extension Map: Identifiable {
    
    // MARK: - NSManaged properties.
    
    /// The elements found in the map, i.e. categories like roads, buildings, etc.
    @NSManaged public var elements: NSSet?
    
    /// The image representing the map.
    @NSManaged public var image: NSData?
    
    /// The parent itinerary.
    @NSManaged public var itinerary: Itinerary?
    
    /// The name of the map.
    @NSManaged public var name: String?
    
    /// The order of the map into it's itinerary.
    @NSManaged public var order: NSNumber?
    
    // MARK: - Convenience initializers.
    
    convenience init(context: NSManagedObjectContext, dto: MapDto) {
        self.init(context: context)
        self.image = NSData(data: dto.imageData)
        self.name = dto.name
        self.order = dto.order as NSNumber?
        dto.elementsArray.forEach { elementDto in
            let element = Element(context: context, dto: elementDto)
            element.map = self
        }
    }
    
    // MARK: - Convenience properties.
    
    /// The map represented as a codable data transfer object.
    public var dto: MapDto? {
        guard let name = name,
              let data = wrappedImage.pngData() else {
            return nil
        }
        
        let elementsDto = elementsArray.compactMap{$0.dto}
        return MapDto(elementsArray: elementsArray.compactMap{$0.dto}, imageData: data, name: name, order: order?.intValue, elements: elementsDto)
    }
    
    /// All the elements linked to this map. Order is undefined.
    public var elementsArray: [Element] {
        let set = elements as? Set<Element> ?? []
        return Array(set)
    }
    
    /// The `image` attribute represented as `UIImage`.
    public var wrappedImage: UIImage {
        guard let image = image else {
            return UIImage()
        }
        return UIImage(data: image as Data) ?? UIImage()
    }
    
    /// The `name` attribute a non-optional string with a default value if nil.
    public var wrappedName: String {
        name ?? "unnamed_map"
    }
    
    /// The `order` attribute represented as `Int`.
    public var wrappedOrder: Int {
        order?.intValue ?? 0
    }
    
    // MARK: - NSFetchRequests.
    
    /// A fetch request returning all the maps.
    /// - Returns: All the maps in the persistent storage.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Map> {
        return NSFetchRequest<Map>(entityName: "Map")
    }
    
    // MARK: - Methods.
    
    public func detectColors(completion: @escaping ([UIColor]) -> Void) {
        return wrappedImage.colors { colorsDict in
            let colors = colorsDict
            // Transforms the dictionary to an array of pairs.
            .map { ($0, $1) }
            // Sorts the array by number of occurences. (Higher first).
            .sorted{$0.1 > $1.1}
            // Maps pairs to color.
            .map{$0.0}
            // Reduces the array to remove similar colors.
            .reduce([UIColor]()) { partialResult, color in
                return partialResult.contains{ $0.isSimilar(to: color, threshold: 0)} ? partialResult : partialResult + [color]
            }
            completion(colors)
        }
    }
    
}
