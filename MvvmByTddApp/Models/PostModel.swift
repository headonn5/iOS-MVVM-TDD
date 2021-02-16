//
//  PostModel.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation

struct PostModel: Decodable {
  let body : String
  let id : Int
  let title : String
  let userId : Int
}
