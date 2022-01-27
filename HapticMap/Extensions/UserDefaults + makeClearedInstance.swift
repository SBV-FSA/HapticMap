//
//  UserDefaults + makeClearedInstance.swift
//  HapticMap
//
//  Created by Duran Timothée on 01.11.21.
//

import Foundation

extension UserDefaults {
    
    /// Creates and returns a new, fresh and empty UserDefaults. Mainly used for **testing or preview purposes**.
    /// - Parameters:
    ///   - functionName: The calling function name
    ///   - fileName: The file name of the calling function
    /// - Returns: An empty UserDefaults for testing or preview purposes.
    static func makeClearedInstance(
        for functionName: StaticString = #function,
        inFile fileName: StaticString = #file
    ) -> UserDefaults {
        let className = "\(fileName)".split(separator: ".")[0]
        let testName = "\(functionName)".split(separator: "(")[0]
        let suiteName = "com.hapticmap.test.\(className).\(testName)"

        let defaults = self.init(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }
    
}
