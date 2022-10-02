//
//  PostsListTableViewControllerTests.swift
//  MvvmByTddAppTests
//
//  Created by Nishant Paul on 02/10/22.
//

import XCTest
@testable import MvvmByTddApp

class PostsListTableViewControllerTests: XCTestCase {
    
    func test_ViewDidLoad_RendersTableView() {
        
        // Arrange
        let expectation = XCTestExpectation(description: "The response model is expected to be updated.")
        let dataService = MockDataService()
        dataService.expectation = expectation
        
        let viewModel = PostsViewModel(webService: dataService, actions: nil)
        
        let sut = PostsListTableViewController()
        sut.responseVM = viewModel
        
        XCTAssertNotNil(sut.tableView)
        
        // Act
        sut.responseVM.callApi()
        
        // Load the view controller if checking for activities
        // in viewDidLoad of PostsListTableViewController
        sut.loadViewIfNeeded()
        
        // Wait for expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
        
        // Assert
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
}
