//
//  MessageView.swift
//  HapticMap
//
//  Created by Duran Timothée on 21.10.21.
//

import SwiftUI

/// A simple text with icon for displaying simple informations to the user.
struct MessageView: View {
    
    private let message: LocalizedStringKey
    private let systemImage: String
    
    init(message: LocalizedStringKey, systemImage: String) {
        self.message = message
        self.systemImage = systemImage
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Label(message, systemImage: systemImage)
                .labelStyle(VerticalLabelStyle()).font(.title2).foregroundColor(.secondary)
                
        }.padding(.all, 32)
        
    }
}

#if !TESTING
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "no_maps", systemImage: "map.fill")
    }
}
#endif
