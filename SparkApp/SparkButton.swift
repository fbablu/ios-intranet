//
//  SparkButton.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/2/24.
//

import SwiftUI

/// A custom button used in the Spark app
struct SparkButton: View {
    var action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .frame(width: 50, height: 60)
                .foregroundColor(.white)
                .background(isPressed ? Color.gray : Color.blue)
                .clipShape(Circle())
                .padding(.all, 20)
                .padding(.vertical, 20)
        }
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                hapticFeedback()
            }
        )
    }
    
    /// Provides haptic feedback when the button is pressed
    func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.5)
    }
}
