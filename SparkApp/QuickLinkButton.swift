//
//  QuickLinkButton.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/8/24.
//

import SwiftUI

/// A button representing a quick link
struct QuickLinkButton: View {
    let link: QuickLink
    let icon: String
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            handleLinkAction(link)
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.largeTitle)
                Text(link.name)
                    .font(.caption)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(backgroundColorFor(type: link.type))
        .cornerRadius(10)
    }
    
    /// Returns the background color for a given link type
    func backgroundColorFor(type: String) -> Color {
        switch type {
        case "Dashboard":
            return Color.blue.opacity(0.1)
        case "URL":
            return Color.green.opacity(0.1)
        case "Access Required":
            return Color.gray.opacity(0.1)
        default:
            return Color.secondary.opacity(0.1)
        }
    }
    
    /// Handles the action when the link is tapped
    func handleLinkAction(_ link: QuickLink) {
        switch link.type {
        case "Dashboard":
            print("Show dashboard alert for \(link.name)")
        case "URL":
            if let url = URL(string: link.url ?? "") {
                UIApplication.shared.open(url)
            }
        case "Access Required":
            print("Show access required alert for \(link.name)")
        default:
            print("Unknown link type for \(link.name)")
        }
    }
}
