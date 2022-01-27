//
//  VerticalLabelStyle.swift
//  HapticMap
//
//  Created by Duran Timothée on 08.11.21.
//

import SwiftUI

/// Custom label style that displays an icon on top of a text.
struct VerticalLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 16) {
            configuration.icon.font(.system(size: 60))
            configuration.title.multilineTextAlignment(.center)
        }
    }
    
}
