//
//  MockAPIResource.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation
@testable import MvvmByTddApp

struct MockAPIResource: APIResourceProtocol {
  
  var path: String
  var httpMethod: RequestType
  var headerParameters: [String : String]
  var body: [String: String]
  
  init(path: String,
       httpMethod: RequestType = .get,
       headerParameters: [String: String] = [:],
       body: [String: String] = [:]) {
    
    self.path = path
    self.httpMethod = httpMethod
    self.headerParameters = headerParameters
    self.body = body
  }
}
