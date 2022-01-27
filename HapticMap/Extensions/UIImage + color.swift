//
//  UIImage + color.swift
//  HapticMap
//
//  Created by Duran Timothée on 22.12.21.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Returns the color of a given pixel.
    /// - Parameter point: The position of the pixel.
    /// - Returns: The UIColor at this position.
    func color(of point: CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
}
