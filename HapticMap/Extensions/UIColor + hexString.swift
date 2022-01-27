//
//  UIColor + hexString.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import UIKit

extension UIColor {
    
    /**
     A string representation encoding the red, green and blue components of the color using an hexadexadecimal format.
     
     For example, a color defined as `[R: 255, G: 0, B: 0]` returns `FF0000`.
     - Warning: It doesn't include `#` charater.
     */
    var hexString: String {
        let rgba_ = rgba
        return String(
            format: "%02X%02X%02X",
            Int(rgba_.red * 0xff),
            Int(rgba_.green * 0xff),
            Int(rgba_.blue * 0xff)
        )
    }
    
    /// Creates a UIColor object from an hexadecimal string
    /// - Parameter hex: hexadecimal string with format "#rrggbbaa", where
    /// r is 'red', g is 'green', b is 'blue' and a is 'alpha'
    /// Will return nil if the format is not respected
    public convenience init?(hexa: String?) {
        let r, g, b, a: CGFloat
        
        guard let hex = hexa else { return nil }

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if (hexColor.count == 6) { // alpha missing
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1.0

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
}
