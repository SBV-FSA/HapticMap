//
//  MapVMProtocol.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import UIKit

/// MapView ViewModel Protocol.
protocol MapVMProtocol: ObservableObject {
    
    // MARK: - Variables
    
    /// The displayed map.
    var map: Map { get set }
    
    /// Boolean indicating if the view should display map informations.
    var showInfos: Bool { get set }
    
    /// Preference repository.
    var preferenceRepository: PreferenceRepository { get set }
    
    // MARK: - Methods
    
    /// Delegate method called when a touch began on screen.
    /// - Parameter color: The color of the element under the touch.
    func touchBegan(with color: UIColor)
    
    /// Delegate method called when a touch moved on screen.
    /// - Parameter color: The color of the element under the touch.
    func touchMoved(with color: UIColor)
    
    /// Delegate method called when a touch ended on screen.
    /// - Parameter color: The color of the element under the touch.
    func touchEnded(with color: UIColor)
    
    /// Reloads user's preferences from repository and updates map behavior accordingly.
    func refreshCategories()
    
}
