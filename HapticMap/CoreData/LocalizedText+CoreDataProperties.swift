//
//  LocalizedText+CoreDataProperties.swift
//  HapticMap
//
//  Created by Duran Timothée on 06.12.21.
//
//

import CoreData
import Foundation

extension LocalizedText {
    
    // MARK: - NSManaged properties.
    
    /// The `ISO 639-1` language code.
    @NSManaged public var language: String?
    
    /// The localized text.
    @NSManaged public var value: String?
    
    /// The parent element.
    @NSManaged public var category: Element?
    
    // MARK: - Convenience initializers.
    
    convenience init(context: NSManagedObjectContext, dto: LocalizedTextDto) {
        self.init(context: context)
        self.language = dto.language
        self.value = dto.value
    }
    
    // MARK: - Convenience properties.
    
    /// The localized text represented as a codable data transfer object.
    public var dto: LocalizedTextDto? {
        guard let language = language,
              let value = value else {
            return nil
        }
        
        return LocalizedTextDto(language: language, value: value)
    }
    
    /// The `language` attribute as a non-optional string with an empty string if nil.
    public var wrappedLanguage: String {
        language ?? ""
    }
    
    /// The `language` attribute as a non-optional, localized and readable string with an empty string if nil.
    public var wrappedReadableLanguage: String {
        let locale: Locale = .current
        return locale.localizedString(forLanguageCode: wrappedLanguage) ?? ""
    }
    
    /// The `value` attribute a non-optional string with an empty string if nil.
    public var wrappedValue: String {
        value ?? ""
    }

}

extension LocalizedText : Identifiable {

}
