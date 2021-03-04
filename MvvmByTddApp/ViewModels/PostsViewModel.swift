//
//  ResponseViewModel.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation

struct PostsViewModelActions {
  let showPostDetails: (PostModel) -> Void
}

class PostsViewModel {
  
  private var webService: DataServiceProtocol
  private var actions: PostsViewModelActions?
  
  private (set) var responseList: Observable<[PostModel]> = Observable(value: [])
  private (set) var responseError: Observable<AppError?> = Observable(value: nil)
  
  init(webService: DataServiceProtocol, actions: PostsViewModelActions?) {
    self.webService = webService
    self.actions = actions
  }
  
  func callApi() {
    // Make api call
    webService.fetchList(resource: APIEndpoint.getPostsEndpoint()) { (result: Result<[PostModel], AppError>) in
      switch result {
      case .success(let data):
        self.responseList.value = data
        self.responseError.value = nil
      case .failure(let error):
        self.responseError.value = error
      }
    }
    
  }
  
}

extension PostsViewModel {
  
  func didSelectItem(at indexPath: IndexPath) {
    let selectedPost = responseList.value[indexPath.row]
    // This should invoke the show post detail action wherever it is defined.
    actions?.showPostDetails(selectedPost)
  }
}
