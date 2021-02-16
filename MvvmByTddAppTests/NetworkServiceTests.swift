//
//  NetworkServiceTests.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import XCTest
@testable import MvvmByTddApp

class NetworkServiceTests: XCTestCase {
  
  private var sut: NetworkService!
  
  override func setUpWithError() throws {
    
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession(configuration: configuration)
    sut = NetworkService(urlSession: urlSession)
  }
  
  func testNetworkService_WhenGivenIncorrectURL_ReturnFailure() {
    
    let expectation = XCTestExpectation(description: "The request is expected to return Invalid URL Error.")
    
    // Act
    sut.execute(resource: MockAPIResource(path: ";<>π")) { (result) in
      // Assert
      do {
        _ = try result.get()
        XCTFail("The request should throw Invalid URL Error.")
      }
      catch let error {
        
        //        switch error {
        //        case AppError.invalidURL:
        //          print("Test succeeds here")
        //        default:
        //          XCTFail("The request should throw Invalid URL Error.")
        //        }
        
        // Short-hand to achieve the above switch case result
        guard case AppError.invalidURL = error else {
          XCTFail("The request should throw Invalid URL Error.")
          return
        }
      }
      expectation.fulfill()
    }
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testNetworkService_WhenGiveSuccessfulMockData_ReturnSuccess() {
    // Arrange
    guard let bundlePath = Bundle(for: type(of: self)).path(forResource: "SuccessfulMockResponse", ofType: "json") else {
      XCTFail("SuccessfulMockResponse file not found.")
      return
    }
    
    guard let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
      XCTFail("Error fetching contents of SuccessfulMockResponse file.")
      return
    }
    
    // Add the stub data to the MockURLProtocol
    MockURLProtocol.stubData = jsonData
    let expectedResponseData = jsonData
    let expectation = XCTestExpectation(description: "The request is expected to return successful response.")
    
    // Act
    sut.execute(resource: MockAPIResource(path: "test")) { (result) in
      // Assert
      do {
        let responseData = try result.get()
        XCTAssertEqual(responseData, expectedResponseData)
        expectation.fulfill()
      }
      catch {
        XCTFail("The request should receive success response.")
      }
    }
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testNetworkService_WhenRequestCancelled_ReturnRequestCancelledError() {
    // Arrange
    MockURLProtocol.stubData = nil
    MockURLProtocol.error = NSError(domain: "Network", code: NSURLErrorCancelled, userInfo: nil)
    
    let expectation = XCTestExpectation(description: "The request is expected to return network request cancelled error.")
    
    // Act
    sut.execute(resource: MockAPIResource(path: "uwfdy")) { (result) in
      // Assert
      do {
        let _ = try result.get()
        XCTFail("The request should throw network request cancelled error.")
      }
      catch let error {
        guard case AppError.networkRequestCancelled = error else {
          XCTFail("The request should throw network request cancelled error.")
          return
        }
        expectation.fulfill()
      }
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  func testNetworkService_WhenRequestFails_ReturnResponseError() {
    // Arrange
    MockURLProtocol.stubData = nil
    MockURLProtocol.error = NSError(domain: "Network", code: NSURLErrorCannotFindHost, userInfo: nil)
    
    let expectation = XCTestExpectation(description: "The request is expected to return response error.")
    
    // Act
    sut.execute(resource: MockAPIResource(path: "uwfdy")) { (result) in
      // Assert
      do {
        let _ = try result.get()
        XCTFail("The request should throw response error.")
      }
      catch let error {
        guard case AppError.responseError(error: _) = error else {
          XCTFail("The request should throw response error.")
          return
        }
        expectation.fulfill()
      }
    }
    
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  override func tearDownWithError() throws {
    MockURLProtocol.stubData = nil
    MockURLProtocol.error = nil
    sut = nil
  }
  
}
