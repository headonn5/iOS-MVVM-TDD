//
//  PostsDetailViewController.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import UIKit

class PostDetailViewController: UIViewController {
  
  private var postDetailVM: PostDetailViewModel!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = postDetailVM.title
    bodyLabel.text = postDetailVM.body
  }
  
  static func create(with postDetailVM: PostDetailViewModel) -> PostDetailViewController {
    let storyboard = UIStoryboard(name: "PostDetailViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
    vc.postDetailVM = postDetailVM
    return vc
  }
  
}
