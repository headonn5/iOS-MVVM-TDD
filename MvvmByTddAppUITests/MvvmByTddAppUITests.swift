//
//  MvvmByTddAppUITests.swift
//  MvvmByTddAppUITests
//
//  Created by Nishant Paul on 02/10/22.
//

import XCTest

class MvvmByTddAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func test_WhenGetPostsClicked_PostsShown() {
        
        let getPostsButton = app.buttons["Get Posts"]
        XCTAssertTrue(getPostsButton.exists)
        
        // Act
        getPostsButton.tap()
        
        // Assert
        // Check if only one table view exists
        if app.tables.element.waitForExistence(timeout: 5) {
            XCTAssertEqual(app.tables.count, 1)
        }
        
        // Check if at least one cell exists
        XCTAssertTrue(app.tables.cells.count > 0)
        
        // Tap first cell
        app.tables.cells.element(boundBy: 0).tap()
        
        // Tap back button
        app.navigationBars["MvvmByTddApp.PostDetailView"].buttons["Back"].tap()
    }
}
