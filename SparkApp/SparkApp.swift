//
//  SparkApp.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/2/24.
//

import SwiftUI
import SwiftData

/// The main entry point for the Spark application.
@main
struct SparkApp: App {
    /// Shared model container for SwiftData.
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
