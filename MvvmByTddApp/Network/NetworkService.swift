//
//  NetworkService.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation

protocol NetworkServiceProtocol {
  typealias CompletionHandler = (Result<Data?, AppError>) -> Void
  func execute(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler)
}

class NetworkService: NetworkServiceProtocol {
  
  private var urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func execute(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler) {
    // Check url
    do {
      let request = try resource.fetchURLRequest()
      serve(request: request, completionHandler: completionHandler)
    }
    catch {
      completionHandler(.failure(.invalidURL))
    }
    
  }
  
//  private func fetchURLRequest() throws -> URLRequest {
//
//    // Build URL
//    let fullUrl = URL(string: Constants.urlString + resource.path)
//    guard let url = fullUrl else {
//      // Handler incorrect url Error
//      throw AppError.invalidURL
//    }
//
//    // Create Request
//    var request = URLRequest(url: url)
//    request.httpMethod = resource.httpMethod.rawValue
//    // TODO: Set headers dynamically according to different urls via a config object may be
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    return request
//  }
  
  private func serve(request: URLRequest, completionHandler: @escaping CompletionHandler) {
    urlSession.dataTask(with: request) { (data, response, error) in
      // Handle Errors
      if let error = error {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .cancelled:
          completionHandler(.failure(.networkRequestCancelled))
        default:
          completionHandler(.failure(.responseError(error: error)))
        }
      }
      else {
        // Handle success
        completionHandler(.success(data))
      }
    }.resume()
  }
}
