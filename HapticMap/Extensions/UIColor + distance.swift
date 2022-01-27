//
//  UIColor + distance.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import UIKit

extension UIColor {
    
    /// Computes an euclidean distance from a given color using the red, green and blue components.
    /// - Parameter color: The color from which to compute the distance.
    /// - Returns: The computed distance, squared.
    func distance(to color: UIColor) -> CGFloat {
        return sqrt(distanceSquared(to: color))
    }
    
}
