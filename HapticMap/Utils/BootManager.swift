//
//  BootManager.swift
//  HapticMap
//
//  Created by Timothée Duran on 19.03.22.
//

import Foundation

class BootManager {
    
    static var shared = BootManager()
    
    func appWillLaunch() {
        
        // 1. If the app was never launched before, set the preferences to default
        if UserDefaults.standard.lastVersionUsed == nil {
            PreferenceRepository.shared.resetToDefault()
        }
        
        // 2. Set the last version used as the current one in User Defaults
        setLastVersionUsed()
        
    }
    
    private func setLastVersionUsed() {
        
        // Get the app version
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            UserDefaults.standard.lastVersionUsed = version
        }
    }
    
}
