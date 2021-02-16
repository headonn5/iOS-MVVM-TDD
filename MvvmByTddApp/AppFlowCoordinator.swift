//
//  AppFlowCoordinator.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation
import UIKit

class AppFlowCoordinator {
  
  private let navController: UINavigationController
  private let diContainer: AppDIContainer
  
  init(navController: UINavigationController, diContainer: AppDIContainer) {
    self.navController = navController
    self.diContainer = diContainer
  }
  
  func startAppFlow() {
    // Create Post DIContainer object
    let postsDIContainer = diContainer.makePostsDIContainer()
    // Create postsFlowCoordinator object from postsDIContainer
    let postsFlowCoordinator = postsDIContainer.makePostsFlowCoordinator(navigationController: navController)
    // Start Posts flow
    postsFlowCoordinator.startPostsFlow()
  }
}
