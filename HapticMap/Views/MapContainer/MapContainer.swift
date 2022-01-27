//
//  MapContainer.swift
//  HapticMap
//
//  Created by Duran Timothée on 18.10.21.
//

import SwiftUI

/// A view that displays HapticMaps and reacts to user touches.
struct MapContainer: UIViewControllerRepresentable {
    
    var mapImage: UIImage
    var onStartedAction: ((UIColor) -> Void)? = nil
    var onChangedAction: ((UIColor) -> Void)? = nil
    var onEndedAction: ((UIColor) -> Void)? = nil
    
    typealias UIViewControllerType = MapContainerViewController
    
    func makeUIViewController(context: Context) -> MapContainerViewController {
        let controller = MapContainerViewController(mapImage: mapImage)
        controller.delegate = self
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MapContainerViewController, context: Context) { }
    
    /// Adds an action to perform when the user interaction with the map starts.
    /// - Parameter action: The action to perform when this user interaction stats. The action closure’s parameter contains the color detected at the user's touch position.
    /// - Returns: A MapContainer that triggers `action` when the user interaction starts.
    func onStarted(_ action:@escaping (UIColor) -> Void) -> MapContainer {
        return MapContainer(mapImage: mapImage, onStartedAction: action, onChangedAction: onChangedAction, onEndedAction: onEndedAction)
    }
    
    /// Adds an action to perform when the user performs a pan gesture on the map and the underlying color changes.
    /// - Parameter action: The action to perform when this user performs a pan gesture. The action closure’s parameter contains the new color detected.
    /// - Returns: A MapContainer that triggers `action` when the user performs a pan gesture and the underlying color changed.
    func onChanged(_ action:@escaping (UIColor) -> Void) -> MapContainer {
        return MapContainer(mapImage: mapImage, onStartedAction: onStartedAction, onChangedAction: action, onEndedAction: onEndedAction)
    }
    
    /// Adds an action to perform when the user interaction with the map ends.
    /// - Parameter action: The action to perform when this user interaction ends. The action closure’s parameter contains the last color detected.
    /// - Returns: A MapContainer that triggers `action` when the user interaction ends.
    func onEnded(_ action:@escaping (UIColor) -> Void) -> MapContainer {
        return MapContainer(mapImage: mapImage, onStartedAction: onStartedAction, onChangedAction: onChangedAction, onEndedAction: action)
    }
    
}

extension MapContainer: MapContainerDelegate {
    
    func touchBegan(with color: UIColor) { onStartedAction?(color) }
    
    func touchMoved(with color: UIColor) { onChangedAction?(color) }
    
    func touchEnded(with color: UIColor) { onEndedAction?(color) }
    
}
