//
//  UIImage + colors.swift
//  HapticMap
//
//  Created by Duran Timothée on 29.11.21.
//

import UIKit

extension UIImage {
    
    /// Returns a dictionnary with all colors found on the image as key and the number of times they apprear as value.
    /// - Parameter completion: Completion handler containing the colors dicitionnary.
    func colors(completion: @escaping ([UIColor: Int]) -> Void) {
        let width = Int(size.width)
        let height = Int(size.height)
        let stepSize = 40
        
        var points = [CGPoint]()
        for x in stride(from: 0, to: width, by: stepSize) {
            for y in stride(from: 0, to: height, by: stepSize) {
                points.append(CGPoint(x: x, y: y))
            }
        }
        
        return DispatchQueue.global(qos: .userInitiated).async {
            var colors = [UIColor: Int]()
            let lock = NSLock()
            DispatchQueue.concurrentPerform(iterations: points.count) { index in
                let point = points[index]
                let color = self.color(of: point)
                
                if let count = colors[color] {
                    lock.lock()
                    colors[color] = count + 1
                    lock.unlock()
                } else {
                    lock.lock()
                    colors[color] = 1
                    lock.unlock()
                }
            }
            completion(colors)
        }
        
    }
    
}
