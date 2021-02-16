//
//  APIEndpoint.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation

enum RequestType: String {
  case get = "GET"
  case post = "POST"
}

protocol APIResourceProtocol {
  var path: String { get }
  var httpMethod: RequestType { get }
  var headerParameters: [String: String] { get }
  var body: [String: String] { get }
  
  func fetchURLRequest() throws -> URLRequest
}

extension APIResourceProtocol {
  
  func fetchURLRequest() throws -> URLRequest {
    
    // Build URL
    let fullUrl = URL(string: Constants.urlString + self.path)
    guard let url = fullUrl else {
      // Handler incorrect url Error
      throw AppError.invalidURL
    }
    
    // Create Request
    var request = URLRequest(url: url)
    request.httpMethod = self.httpMethod.rawValue
    // Set Request headers
    for (key,val) in headerParameters {
      request.setValue(val, forHTTPHeaderField: key)
    }
    
    return request
  }
}

struct APIEndpoint {
  
  static func getPostsEndpoint() -> APIResource {
    let header = ["Content-Type": "application/json"]
    return APIResource(path: "posts", httpMethod: .get, headerParameters: header)
  }
}

struct APIResource: APIResourceProtocol {
  
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

