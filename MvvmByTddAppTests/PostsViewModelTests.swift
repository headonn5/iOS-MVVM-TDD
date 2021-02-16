//
//  PostsViewModelTests.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant(AWF) on 17/02/21.
//

import XCTest
@testable import MvvmByTddApp

class PostsViewModelTests: XCTestCase {
  
  func testPostsViewModel_WhenDataReturened_PostsModelUpdated() {
    
    // Arrange
    let expectation = XCTestExpectation(description: "The response model is expected to be updated.")
    let dataService = MockDataService()
    dataService.expectation = expectation
  
    let sut = PostsViewModel(webService: dataService, actions: nil)
    
    // Act
    sut.callApi()
    
    // Assert
    self.wait(for: [expectation], timeout: 5.0)
    XCTAssertNotNil(sut.responseList, "The response model update error.")
    XCTAssertEqual(sut.responseList.value.count, 1)
  }
  
  func testPostsViewModel_WhenErrorReturned_PostsModelNotUpdated() {
    
    // Arrange
    let expectation = XCTestExpectation(description: "The response model is expected NOT to be updated.")
    let dataService = MockDataService()
    dataService.error = AppError.parseError
    dataService.expectation = expectation
    
    let sut = PostsViewModel(webService: dataService, actions: nil)
    
    // Act
    sut.callApi()
    
    // Assert
    self.wait(for: [expectation], timeout: 5.0)
    XCTAssertEqual(sut.responseList.value.count, 0, "The response model should not be updated.")
  }
  
}
