//
//  MockNetworkService.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation
@testable import MvvmByTddApp

class MockNetworkService: NetworkServiceProtocol {
  
  var isExecuteMethodCalled: Bool = false
  var data: Data?
  var response: HTTPURLResponse?
  var error: AppError?
  
  init(data: Data?, response: HTTPURLResponse?, error: AppError?) {
    self.data = data
    self.response = response
    self.error = error
  }
  
  func execute(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler) {
    
    isExecuteMethodCalled = true
    
    if self.response?.statusCode == 200 {
      completionHandler(.success(data))
    }
    else {
      completionHandler(.failure(error!))
    }
  }
  
  
  
}

