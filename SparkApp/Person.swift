//
//  Person.swift
//  Spark
//
//  Created by Fardeen Bablu on 8/2/24.
//

import Foundation

/// Represents a person in the application
struct Person: Codable, Identifiable {
    var id = UUID()
    let name: String
    let position: String
    let email: String
    let phone: String
    let imageURL: String
    let url: String
    let location: String
    let vCard: String?
}

/// Loads people data from a JSON file
/// - Returns: An array of Person objects
func loadPeopleFromJSON() -> [Person] {
    guard let url = Bundle.main.url(forResource: "people", withExtension: "json") else {
        print("JSON File not found")
        return []
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let people = try decoder.decode([Person].self, from: data)
        return people
    } catch {
        print("Error reading JSON file: \(error)")
        return []
    }
}
