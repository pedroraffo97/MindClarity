//
//  OwnModifiers.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 10.06.24.
//

import Foundation


import SwiftUI

//Modifier for the Black Button
struct BlackButtonModifier: ViewModifier {
    // The body method is required by the ViewModifier protocol and applies the desired styling
    func body(content: Content) -> some View {
        content
            // Set the font style to headline
            .font(.headline)
            // Apply a bordered button style
            .buttonStyle(.bordered)
            // Set the background color to black
            .background(Color.black)
            // Set the text color to white
            .foregroundColor(.white)
            // Clip the shape of the button to a rounded rectangle with a corner radius of 10
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// Extend the View protocol to include a method for applying the BlackButtonModifier
extension View {
    // This method applies the BlackButtonModifier to any view
    func blackButtonModifier() -> some View {
        self.modifier(BlackButtonModifier())
    }
}
