//
//  Element+CoreDataClass.swift
//  HapticMap
//
//  Created by Duran Timothée on 06.12.21.
//
//

import CoreData
import Foundation

/**
 An element of the environment on a map.
 
 Detecting colors on a map image is exepnsive and can take several seconds to perform. Therefore, a detection algorithm could run beforehand and the result stored using this class.
 
 _Examples: a road, a destination or custom elements._
 */
@objc(Element)
public class Element: NSManagedObject {

}
