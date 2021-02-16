//
//  PostsListTableViewController.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import Foundation
import UIKit

class PostsListTableViewController: UITableViewController {
  
  var responseVM: PostsViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func reloadView() {
    tableView.reloadData()
  }
  
}

extension PostsListTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return responseVM.responseList.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell
    
    let post = responseVM.responseList.value[indexPath.row]
    cell.titleLabel.text = post.title
    cell.bodyLabel.text = post.body
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    responseVM.didSelectItem(at: indexPath)
  }
}

