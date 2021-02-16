//
//  AppErrorTests.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import XCTest
@testable import MvvmByTddApp

class AppErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testAppError_WhenCorrectDescriptionProvided_NoErrorOccurs() {
    
    var sut = AppError.parseError
    XCTAssertEqual(sut.localizedDescription, Constants.parseError)
    
    sut = AppError.domainError
    XCTAssertEqual(sut.localizedDescription, Constants.domainError)
    
    sut = AppError.voidResponseError
    XCTAssertEqual(sut.localizedDescription, Constants.voidResponseError)
    
    sut = AppError.invalidURL
    XCTAssertEqual(sut.localizedDescription, Constants.invalidURL)
    
    sut = AppError.networkRequestCancelled
    XCTAssertEqual(sut.localizedDescription, Constants.networkRequestCancelled)
    
    sut = AppError.responseError(error: NSError(domain: "ResponseError", code: NSURLErrorCannotFindHost, userInfo: nil))
    XCTAssertEqual(sut.localizedDescription, "The operation couldn’t be completed. (ResponseError error -1003.)")
  }

}
