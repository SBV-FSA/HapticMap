//
//  UserDefaults + variables.swift
//  HapticMap
//
//  Created by Timothée Duran on 19.03.22.
//

import Foundation

extension UserDefaults {

    /// Indicates if the app should use production or staging Firebase environment. Setting this to true configures Firebase with the staging environment at next app launch.
    var lastVersionUsed: String? {
        get { return string(forKey: #function) }
        set { set(newValue, forKey: #function) }
    }

}
