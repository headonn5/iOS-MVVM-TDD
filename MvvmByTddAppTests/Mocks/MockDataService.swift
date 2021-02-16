//
//  MockDataServi e.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation
import XCTest
@testable import MvvmByTddApp

class MockDataService: DataServiceProtocol {
  
  var error: AppError?
  var expectation: XCTestExpectation?
  
  func fetchList<T>(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler<T>) where T : Decodable {
        if let error = self.error {
      completionHandler(.failure(error))
    }
    else {
      let responseModel = PostModel(body: "test body", id: 1, title: "test title", userId: 1)
      let result: Result<T, AppError> = .success([responseModel] as! T)
      completionHandler(result)
    }
    
    expectation?.fulfill()
  }
  
}
