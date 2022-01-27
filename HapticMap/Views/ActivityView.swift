//
//  ActivityView.swift
//  HapticMap
//
//  Created by Duran Timothée on 09.11.21.
//

import SwiftUI

/// SwiftUI wrapper for `UIActivityViewController`.
struct ActivityView: UIViewControllerRepresentable {
    
    /// The array of data objects on which to perform the activity. The type of objects in the array is variable and dependent on the data your application manages. For example, the data might consist of one or more string or image objects representing the currently selected content.
    var activityItems: [Any]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) { }

}
