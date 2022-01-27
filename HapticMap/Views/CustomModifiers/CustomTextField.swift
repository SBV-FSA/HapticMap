//
//  CustomTextField.swift
//  HapticMap
//
//  Created by Duran Timothée on 21.10.21.
//

import SwiftUI

/// Custom TextField style with a curved background.
struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        let color = Color("BackgroundAccent")
        content
            .padding(8)
            .frame(height: 50)
            .background(color)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1)
            )
    }
    
}

extension View {
    
    /// A custom modifiers that applies a curved light background.
    /// - Returns: The modified View.
    func customTextField() -> some View {
        self.modifier(TextFieldModifier())
    }
    
}
