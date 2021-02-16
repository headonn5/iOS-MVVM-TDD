//
//  PostsFlowCoordinator.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation
import UIKit

protocol PostsFlowCoordinatorDependencyProtocol {
  func makePostsListViewController(actions: PostsViewModelActions) -> PostsContainerViewController
  func makePostDetailViewController(post: PostModel) -> PostDetailViewController
}

class PostsFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let di: PostsFlowCoordinatorDependencyProtocol
  
  init(navigationController: UINavigationController, di: PostsDIContainer) {
    self.navigationController = navigationController
    self.di = di
  }
  
  func startPostsFlow() {
    let actions = PostsViewModelActions(showPostDetails: showPostDetails)
    let vc = di.makePostsListViewController(actions: actions)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  // The following action function should be kept private
  // And should be called as a parameter reference from the view model.
  private func showPostDetails(post: PostModel) {
    let vc = di.makePostDetailViewController(post: post)
    navigationController?.pushViewController(vc, animated: true)
  }
}
