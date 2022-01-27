//
//  UIColor + isSimilar.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import UIKit

extension UIColor {
    
    /// Returns true if a given color is considered similar by computing an euclidean distance and using a threshold.
    /// - Parameters:
    ///   - color: The color to compare.
    ///   - threshold: The threshold for when to condiser a color similar. Bigger threshold means greater tolerance.
    /// - Returns: True if the compared color is similar.
    func isSimilar(to color: UIColor, threshold: CGFloat = 0.15) -> Bool {
        return distance(to: color) <= threshold
    }
    
}
