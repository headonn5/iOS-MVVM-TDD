//
//  AppError.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation

enum AppError: Error {
  case parseError
  case domainError
  case voidResponseError
  case invalidURL
  case networkRequestCancelled
  case responseError(error: Error)
}

extension AppError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .parseError:
      return Constants.parseError
    case .domainError:
      return Constants.domainError
    case .voidResponseError:
      return Constants.voidResponseError
    case .invalidURL:
      return Constants.invalidURL
    case .networkRequestCancelled:
      return Constants.networkRequestCancelled
    case .responseError(let error):
      return error.localizedDescription
    }
  }
}

