//
//  UIColor + rgba.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import UIKit

extension UIColor {
    
    /// A tuple representation of the red, green and blue components.
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
}
