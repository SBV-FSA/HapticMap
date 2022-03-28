//
//  BootManager.swift
//  HapticMap
//
//  Created by Timothée Duran on 19.03.22.
//

import Foundation

/// Responsible for background processes required at app launch.
class BootManager {
    
    static var shared = BootManager()
    
    /// Function design to be called when the app will launch. Sets the defaults preferences and saves the current app version as the last used by the user.
    func appWillLaunch() {
        
        // 1. If the app was never launched before, set the preferences to default
        if UserDefaults.standard.lastVersionUsed == nil {
            PreferenceRepository.shared.resetToDefault()
        }
        
        // 2. If the app was never launched before, seed an example itinerary
        if UserDefaults.standard.lastVersionUsed == nil  {
            if let path = Bundle.main.path(forResource: "example", ofType: "hcit") {
                let fileUrl = URL(fileURLWithPath: path)
                ImportManager.importItinerary(from: fileUrl, persistenceController: .shared)
            }
        }
        
        // 3. Set the last version used as the current one in User Defaults
        setLastVersionUsed()
        
    }
    
    /// Saves the current app version in UserDefaults.
    private func setLastVersionUsed() {
        
        // Get the app version
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            UserDefaults.standard.lastVersionUsed = version
        }
    }
    
}
