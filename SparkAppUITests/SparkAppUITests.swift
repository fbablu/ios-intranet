//
//  SparkUITests.swift
//  SparkUITests
//
//  Created by Fardeen Bablu on 8/2/24.
//

import XCTest

final class SparkUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testTabNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test navigation between tabs
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Home"].exists)
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["News"].exists)
        XCTAssertTrue(app.tabBars["Tab Bar"].buttons["Events"].exists)
        
        app.tabBars["Tab Bar"].buttons["News"].tap()
        XCTAssertTrue(app.navigationBars["News"].exists)
        
        app.tabBars["Tab Bar"].buttons["Events"].tap()
        XCTAssertTrue(app.navigationBars["Events"].exists)
    }
    
    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test search functionality
        app.searchFields["Search for people, clients, matters"].tap()
        app.searchFields["Search for people, clients, matters"].typeText("John")
        
        // Add assertions to check search results
        // XCTAssertTrue(app.staticTexts["John Doe"].exists)
    }
    
    func testQuickLinkInteraction() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to Home tab
        app.tabBars["Tab Bar"].buttons["Home"].tap()
        
        // Test interaction with a quick link
        let quickLinkButton = app.buttons["Test Link"] // Replace with an actual quick link name
        XCTAssertTrue(quickLinkButton.exists)
        quickLinkButton.tap()
        
        // Add assertions to verify the result of tapping the quick link
    }
    
    // Add more UI tests as needed
}
