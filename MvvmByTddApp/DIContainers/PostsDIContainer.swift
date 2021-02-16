//
//  PostsDIContainer.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation
import UIKit

class PostsDIContainer {
  
  let dataServiceDependency: DataServiceProtocol
  
  init(dependency: DataServiceProtocol) {
    self.dataServiceDependency = dependency
  }
  
  func makePostsFlowCoordinator(navigationController: UINavigationController) -> PostsFlowCoordinator {
    return PostsFlowCoordinator(navigationController: navigationController, di: self)
  }
}

extension PostsDIContainer: PostsFlowCoordinatorDependencyProtocol {
  
  func makePostsListViewController(actions: PostsViewModelActions) -> PostsContainerViewController {
    let vm = PostsViewModel(webService: self.dataServiceDependency, actions: actions)
    return PostsContainerViewController.create(with: vm)
  }
  
  func makePostDetailViewController(post: PostModel) -> PostDetailViewController {
    let vm = PostDetailViewModel(post: post)
    return PostDetailViewController.create(with: vm)
  }

}

