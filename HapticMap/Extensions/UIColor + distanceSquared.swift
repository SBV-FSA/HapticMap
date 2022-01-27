//
//  UIColor + distanceSquared.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import UIKit

extension UIColor {
    
    /// Computes a squared euclidean distance from a given color using the red, green and blue components.
    ///
    /// This function is more efficient compared to `distance` as it does not imply computing square roots.
    /// - Parameter color: The color from which to compute the distance.
    /// - Returns: The computed distance, squared.
    func distanceSquared(to color: UIColor) -> CGFloat {
        let deltaRed = rgba.red - color.rgba.red
        let deltaGreen = rgba.green - color.rgba.green
        let deltaBlue = rgba.blue - color.rgba.blue
        
        return deltaRed * deltaRed + deltaGreen * deltaGreen + deltaBlue * deltaBlue
    }
    
}
