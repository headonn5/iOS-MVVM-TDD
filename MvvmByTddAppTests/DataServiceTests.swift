//
//  MvvmByTddAppTests.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 16/02/21.
//

import XCTest
@testable import MvvmByTddApp

class DataServiceTests: XCTestCase {
  
  private var urlResponse: HTTPURLResponse!
  
  override func setUpWithError() throws {
    urlResponse = HTTPURLResponse(url: URL(string: "www.test.com")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])
  }
  
  func testDataService_WhenRequestFails_ErrorOccurs() {
    // Arrange
    let error: AppError = AppError.responseError(error: NSError(domain: "", code: 400, userInfo: nil))
    let mockNetworkService = MockNetworkService(data: nil, response: nil, error: error)
    let sut = DataService(networkService: mockNetworkService)
    
    let expectation = XCTestExpectation(description: "The request is expected to return response Error")
    
    // Act
    sut.fetchList(resource: MockAPIResource(path: "testDataService")) { (result: Result<[PostModel], AppError>) in
      do {
        let _ = try result.get()
        XCTFail("The request should throw error.")
      }
      catch let error {
        guard case AppError.responseError(error: _) = error else {
          XCTFail("The request should throw .responseError")
          return
        }
        expectation.fulfill()
      }
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testDataService_WhenGivenInvalidData_DecodingErrorOccurs() {
    
    // Arrange
    guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "InvalidMockResponse", ofType: "json") else {
      XCTFail("InvalidMockResponse file not found.")
      return
    }
    guard let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
      XCTFail("Error fetching contents of InvalidMockResponse file.")
      return
    }
    
    let mockNetworkService = MockNetworkService(data: data, response: urlResponse, error: nil)
    let sut = DataService(networkService: mockNetworkService)
    let expectation = XCTestExpectation(description: "The request is expected to throw parse error.")
    
    // Act
    sut.fetchList(resource: MockAPIResource(path: "testDataService")) { (result: Result<[PostModel], AppError>) in
      // Assert
      do {
        let _ = try result.get()
        XCTFail("The request should throw parse error.")
        return
      }
      catch let error {
        guard case AppError.parseError = error else {
          XCTFail("The request should throw parse error")
          return
        }
        expectation.fulfill()
      }
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testDataService_WhenGivenValidData_ShouldDecodeSuccessfully() {
    
    // Arrange
    guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "SuccessfulMockResponse", ofType: "json") else {
      XCTFail("SuccessfulMockResponse file not found.")
      return
    }
    
    guard let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
      XCTFail("Error fetching contents of SuccessfulMockResponse file.")
      return
    }
    
    let mockNetworkService = MockNetworkService(data: data, response: urlResponse, error: nil)
    let sut = DataService(networkService: mockNetworkService)
    let expectation = XCTestExpectation(description: "The request is expected to decode ResponseModel lists.")
    let expectedTitle = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
    
    // Act
    sut.fetchList(resource: MockAPIResource(path: "testDataService")) { (result: Result<[PostModel], AppError>) in
      // Assert
      guard let decodedObject = try? result.get() else {
        XCTFail("The request should decode response successfully.")
        return
      }
      XCTAssertEqual(decodedObject[0].title, expectedTitle)
      expectation.fulfill()
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testDataService_WhenDataIsNil_ReturnsError() {
    
    // Arrange
    let mockNetworkService = MockNetworkService(data: nil, response: urlResponse, error: nil)
    let sut = DataService(networkService: mockNetworkService)
    let expectation = XCTestExpectation(description: "The request is expected to throw void Response error.")
    
    // Act
    sut.fetchList(resource: MockAPIResource(path: "testDataService")) { (result: Result<[PostModel], AppError>) in
      // Assert
      do {
        let _ = try result.get()
        XCTFail("The request should throw void Response error.")
      }
      catch let error {
        guard case AppError.voidResponseError = error else {
          XCTFail("The request should throw void Response error.")
          return
        }
        expectation.fulfill()
      }
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  override func tearDownWithError() throws {
    urlResponse = nil
  }

}
