//
//  Events.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/2/24.
//

import SwiftUI

/// The events view of the application
struct Events: View {
    @State private var titleVisible = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(events) { event in
                        EventCard(event: event)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    LazyHStack {
                        if titleVisible {
                            Text("Events")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                }
            }
        }
        .tabItem {
            Label("Events", systemImage: "calendar")
        }
        .tag(2)
    }
}

/// A view representing a single event
struct EventCard: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(event.name)
                    .font(.headline)
                Spacer()
                Text(event.emoji)
                    .font(.title)
            }
            Text(event.dateTime)
                .font(.subheadline)
            Text(event.location)
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 100)
                .overlay(
                    Text("Event Image Placeholder")
                        .foregroundColor(.gray)
                )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

/// Struct representing an event
struct Event: Identifiable {
    let id = UUID()
    let name: String
    let dateTime: String
    let location: String
    let category: EventCategory
    var emoji: String {
        switch category {
        case .professionalInternal:
            return "👥"
        case .professionalGuests:
            return "🤝"
        case .virtualOnly:
            return "💻"
        case .socialFun:
            return "🎉"
        }
    }
}

/// Enum representing different event categories
enum EventCategory {
    case professionalInternal
    case professionalGuests
    case virtualOnly
    case socialFun
}

/// Sample events
let events: [Event] = [
    Event(name: "Team Meeting", dateTime: "2024-08-10 10:00 AM", location: "Conference Room A", category: .professionalInternal),
    Event(name: "Client Presentation", dateTime: "2024-08-15 2:00 PM", location: "Main Auditorium", category: .professionalGuests),
    Event(name: "Webinar: Legal Updates", dateTime: "2024-08-20 11:00 AM", location: "Online", category: .virtualOnly),
    Event(name: "Summer Picnic", dateTime: "2024-08-25 12:00 PM", location: "Central Park", category: .socialFun),
    // Add more dummy events here as needed
]

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
