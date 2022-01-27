//
//  Element+CoreDataProperties.swift
//  HapticMap
//
//  Created by Duran Timothée on 06.12.21.
//
//

import CoreData
import Foundation
import UIKit
import SwiftUI

extension Element {
    
    // MARK: - NSManaged properties.
    
    /// The hexadecimal color of the element, without `#`.
    @NSManaged public var color: String?
    
    /// The localized descriptions of the element,.
    @NSManaged public var descriptions: NSSet?
    
    /// The parent map of the element,.
    @NSManaged public var map: Map?
    
    // MARK: - Convenience initializers.
    
    convenience init(context: NSManagedObjectContext, dto: ElementDto) {
        self.init(context: context)
        self.color = dto.color
        dto.descriptions.forEach { descriptionDto in
            let localizedText = LocalizedText(context: context, dto: descriptionDto)
            localizedText.category = self
        }
    }
    
    // MARK: - Convenience properties.
    
    /// The corresponding category of the element,. Computed but finding the first category having a similar color.
    public var category: Category {
        if let color = uiColor,
            let category = Category.allCases.first(where: {$0.color?.isSimilar(to: color) ?? false}) {
            return category
        }
        return .other
    }
    
    /// The localized descriptions  of the element, as an array. Returns an empty array if data is non-existent or ill-formatted.
    public var descriptionsArray: [LocalizedText] {
        let set = descriptions as? Set<LocalizedText>
        return Array(set ?? [])
    }
    
    /// The element represented as a codable data transfer object.
    public var dto: ElementDto? {
        guard let color = color else {
            return nil
        }
        
        return ElementDto(color: color, descriptions: descriptionsArray.compactMap{$0.dto})
    }
    
    /// The localized description of the element, in the app's language. If no description can be found in the app's language, another languge is returns. If no description exsists, returns "nil".
    public var localizedDescription: LocalizedText? {
        descriptionsArray.first(where: {$0.language == Locale.current.languageCode}) ?? descriptionsArray.first
    }
    
    /// The `color` attribute as `UIColor`. Returns `nil` if the `color` property is non-existent or ill-formatted.
    public var uiColor: UIColor? {
        if let color = color {
            print("color \(color)")
            return UIColor(hexa:"#".appending(color))
        }
        return nil
    }
    
    /// The `color` attribute as `Color`. Returns `Color.clear` if the `color` property is non-existent or ill-formatted.
    public var wrappedColor: Color {
        if let uiColor = uiColor {
            return Color(uiColor)
        }
        return .clear
    }
    
}

// MARK: Generated accessors for descriptions
extension Element {

    @objc(addDescriptionsObject:)
    @NSManaged public func addToDescriptions(_ value: LocalizedText)

    @objc(removeDescriptionsObject:)
    @NSManaged public func removeFromDescriptions(_ value: LocalizedText)

    @objc(addDescriptions:)
    @NSManaged public func addToDescriptions(_ values: NSSet)

    @objc(removeDescriptions:)
    @NSManaged public func removeFromDescriptions(_ values: NSSet)

}

extension Element : Identifiable {

}
