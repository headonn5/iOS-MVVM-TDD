//
//  PostDetailViewModel.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation

class PostDetailViewModel {
  
  let post: PostModel
  let title: String
  let body: String
  
  init(post: PostModel) {
    self.post = post
    self.title = post.title
    self.body = post.body
  }
}
