//
//  Itinerary+CoreDataClass.swift
//  HapticMap
//
//  Created by Duran Timothée on 15.10.21.
//
//

import CoreData
import Foundation

/**
 An itinerary mainly represented by its name, containing an ordered collections of maps.
 */
@objc(Itinerary)
public final class Itinerary: NSManagedObject {

    /// Fetches all the records and sorts them alphabetically.
    static var alphabeticalItinerariesRequest: NSFetchRequest<Itinerary> {
        let request: NSFetchRequest<Itinerary> = Itinerary.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
    
}
