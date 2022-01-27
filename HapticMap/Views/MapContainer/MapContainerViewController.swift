//
//  MapContainerViewController.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import UIKit

/// A set of methods implemented by the delegate of a map container to react to user interactions.
protocol MapContainerDelegate {
    
    /// Delegate method called when the map container detects a new touch. If multiple touches occures, only one of them is considered with unexpected behaviour.
    func touchBegan(with: UIColor)
    
    /// Delegate method called when the map container detects a pan gesture mouvement. If multiple touches occures, only one of them is considered with unexpected behaviour.
    ///
    /// Contrary to `UIPanGestureRecognizer` having a similar signature, `touchMoved(with: UIColor)` is only called if the color has changed since last call.
    func touchMoved(with: UIColor)
    
    /// Delegate method called when the map container detects touch ended. If multiple touches occures, only one of them is considered with unexpected behaviour.
    func touchEnded(with: UIColor)
    
}

/// HapticMap Container. Use this class to display a HapticMap, track the user touches and get informations about the elements touched.
class MapContainerViewController: UIViewController {

    /// The delegate of the map container.
    ///
    /// The map container maintains a strong reference to its delegate. The delegate must adopt the MapContainerDelegate protocol and implement all of its methods.
    var delegate: MapContainerDelegate?
    
    
    /// The map's gesture recognizer.
    @IBOutlet private weak var gesture: UIPanGestureRecognizer!
    
    /// UIImageView used to display HapticMaps.
    @IBOutlet private weak var imageView: UIImageView!
    
    /// The image representing a map.
    private var mapImage: UIImage?
    
    /// The last color touched by the user, if any.
    private var previousTouchColor: UIColor? = nil
    
    /// Default initializer
    /// - Parameter mapImage: The image representing a map.
    init(mapImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.mapImage = mapImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Category.border.color
        imageView.image = mapImage
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
    }

}

extension MapContainerViewController: UIGestureRecognizerDelegate {
    
    /// Returns the color underlaying the first touch found, of nil if no touches are provided.
    /// - Parameter touches: The set of touches.
    /// - Returns: The color of the element at the first touch found position.
    private func getColorOfFirstTouch(touches: Set<UITouch>) -> UIColor? {
        guard let touch = touches.first else { return nil}
        let location = touch.location(in: self.view)
        return view.colorOfPoint(point: location)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let color = getColorOfFirstTouch(touches: touches) {
            previousTouchColor = color
            delegate?.touchBegan(with: color)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let color = getColorOfFirstTouch(touches: touches) else { return }
        if color != previousTouchColor {
            previousTouchColor = color
            delegate?.touchMoved(with: color)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let color = getColorOfFirstTouch(touches: touches) {
            delegate?.touchEnded(with: color)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let color = getColorOfFirstTouch(touches: touches) {
            delegate?.touchEnded(with: color)
        }
    }
    
}
