//
//  SparkTests.swift
//  SparkTests
//
//  Created by Fardeen Bablu on 8/2/24.
//

import XCTest
@testable import SparkApp

final class SparkTests: XCTestCase {
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    func testLoadQuickLinksFromCSV() throws {
        let quickLinks = loadQuickLinksFromCSV()
        XCTAssertFalse(quickLinks.isEmpty, "Quick links should not be empty")
        
        // Test specific properties of the loaded quick links
        XCTAssertGreaterThan(quickLinks.count, 0, "Should load at least one quick link")
        
        if let firstLink = quickLinks.first {
            XCTAssertFalse(firstLink.name.isEmpty, "Quick link name should not be empty")
            XCTAssertFalse(firstLink.type.isEmpty, "Quick link type should not be empty")
        }
    }
    
    func testLoadPeopleFromJSON() throws {
        let people = loadPeopleFromJSON()
        XCTAssertFalse(people.isEmpty, "People list should not be empty")
        
        // Test specific properties of the loaded people
        XCTAssertGreaterThan(people.count, 0, "Should load at least one person")
        
        if let firstPerson = people.first {
            XCTAssertFalse(firstPerson.name.isEmpty, "Person name should not be empty")
            XCTAssertFalse(firstPerson.position.isEmpty, "Person position should not be empty")
            XCTAssertFalse(firstPerson.email.isEmpty, "Person email should not be empty")
            XCTAssertFalse(firstPerson.phone.isEmpty, "Person phone should not be empty")
            XCTAssertFalse(firstPerson.imageURL.isEmpty, "Person image URL should not be empty")
            XCTAssertFalse(firstPerson.url.isEmpty, "Person URL should not be empty")
            XCTAssertFalse(firstPerson.location.isEmpty, "Person location should not be empty")
        }
    }
    
    func testQuickLinkConversion() throws {
        let testQuickLinks = [
            QuickLink(name: "Test Link 1", type: "URL", url: "https://example.com", description: "A test link"),
            QuickLink(name: "Test Link 2", type: "Dashboard", url: nil, description: "A dashboard link")
        ]
        
        let jsonString = convertQuickLinksToJSON(quickLinks: testQuickLinks)
        XCTAssertNotNil(jsonString, "JSON conversion should succeed")
        
        // Verify JSON structure
        guard let jsonData = jsonString?.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let decodedQuickLinks = try JSONDecoder().decode([QuickLink].self, from: jsonData)
            XCTAssertEqual(decodedQuickLinks.count, testQuickLinks.count, "Decoded quick links count should match original")
            XCTAssertEqual(decodedQuickLinks[0].name, "Test Link 1", "First quick link name should match")
            XCTAssertEqual(decodedQuickLinks[1].type, "Dashboard", "Second quick link type should match")
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    func testPersonCardView() throws {
        let testPerson = Person(name: "John Doe", position: "Developer", email: "john@example.com", phone: "123-456-7890", imageURL: "https://example.com/image.jpg", url: "https://example.com", location: "New York", vCard: nil)
        
        let personCard = PersonCard(person: testPerson)
        
    }
    
    func testEventFiltering() throws {
        let testEvents = [
            Event(name: "Team Meeting", dateTime: "2024-08-10 10:00 AM", location: "Conference Room A", category: .professionalInternal),
            Event(name: "Client Presentation", dateTime: "2024-08-15 2:00 PM", location: "Main Auditorium", category: .professionalGuests),
            Event(name: "Webinar", dateTime: "2024-08-20 11:00 AM", location: "Online", category: .virtualOnly)
        ]
        
        let internalEvents = testEvents.filter { $0.category == .professionalInternal }
        XCTAssertEqual(internalEvents.count, 1, "Should have one internal event")
        XCTAssertEqual(internalEvents.first?.name, "Team Meeting", "Internal event should be Team Meeting")
        
        let virtualEvents = testEvents.filter { $0.category == .virtualOnly }
        XCTAssertEqual(virtualEvents.count, 1, "Should have one virtual event")
        XCTAssertEqual(virtualEvents.first?.name, "Webinar", "Virtual event should be Webinar")
    }
    
    func testNewsItemFavoriteToggle() throws {
        var testNewsItem = NewsItem(title: "Test News", section: .news, isFavorite: false)
        
        XCTAssertFalse(testNewsItem.isFavorite, "News item should start as not favorite")
        
        testNewsItem.isFavorite.toggle()
        XCTAssertTrue(testNewsItem.isFavorite, "News item should be favorite after toggle")
        
        testNewsItem.isFavorite.toggle()
        XCTAssertFalse(testNewsItem.isFavorite, "News item should not be favorite after second toggle")
    }
}
