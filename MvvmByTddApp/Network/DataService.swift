//
//  DataService.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation

protocol DataServiceProtocol {
  
  typealias CompletionHandler<T> = (Result<T, AppError>) -> Void
  
  func fetchList<T: Decodable>(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler<T>)
}

class DataService: DataServiceProtocol {
  
  private var networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
  func fetchList<T>(resource: APIResourceProtocol, completionHandler: @escaping CompletionHandler<T>) where T : Decodable {
   
    networkService.execute(resource: resource) { (result) in
      switch result {
      case .success(let data):
        // TODO: Decode data here and cast to [ResponseModel]
        let result: Result<T, AppError> = self.decode(data: data)
        completionHandler(result)
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  private func decode<T: Decodable>(data: Data?) -> Result<T, AppError> {
    do {
      guard let data = data else {
        return .failure(.voidResponseError)
      }
      let parsedObject: T = try JSONDecoder().decode(T.self, from: data)
      return .success(parsedObject)
    }
    catch {
      return .failure(.parseError)
    }
  }
}

