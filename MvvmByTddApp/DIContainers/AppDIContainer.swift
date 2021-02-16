//
//  AppDIContainer.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation
import UIKit

final class AppDIContainer {
  
  // Do lazy initialization of all screen dependencies to be used in the app
  // In this case, we have just one dependency for Posts screen
  lazy var dataService: DataServiceProtocol = {
    
    let networkService = NetworkService()
    return DataService(networkService: networkService)
  }()
  
  func makePostsDIContainer() -> PostsDIContainer {
    return PostsDIContainer(dependency: dataService)
  }
  
}
