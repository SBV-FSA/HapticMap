//
//  LocalizedText+CoreDataClass.swift
//  HapticMap
//
//  Created by Duran Timothée on 06.12.21.
//
//

import Foundation
import CoreData

/**
 A localized text. Mainly a combination of a language and a content.
 
 Users can define elements with their own vocabulary. Since maps can be shared among different users, it is important to localize the description. `LocalizedText` represents one of the translations.
 
 _Examples: A custom element described as "Room 123" in english could have multiple`LocalizedText` entries like "Salle 123" in french._
 */
@objc(LocalizedText)
public class LocalizedText: NSManagedObject {

}
