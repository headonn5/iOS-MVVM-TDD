//
//  MockURLProtocol.swift
//  MvvmByTddAppTests
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation

class MockURLProtocol: URLProtocol {
  
  static var stubData: Data?
  static var error: Error?
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override func startLoading() {
    
    if let mockError = MockURLProtocol.error {
      // Show Error response if the error var is not nil
      self.client?.urlProtocol(self, didFailWithError: mockError)
    }
    else {
      // Show Data if error var is nil
      self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubData ?? Data())
    }
    
    self.client?.urlProtocolDidFinishLoading(self)
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func stopLoading() {
    // Nothing to do here
  }
  
}

