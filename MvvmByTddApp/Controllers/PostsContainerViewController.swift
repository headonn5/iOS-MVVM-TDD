//
//  PostsContainerViewController.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import UIKit

class PostsContainerViewController: UIViewController, AlertProtocol {
  
  private var postsVM: PostsViewModel!
  private var postsListTableViewController: PostsListTableViewController?

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var getPostsButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Bind views to view model
    postsVM.responseList.bind { [unowned self] (responseList) in
      // Reload Posts list table view
      self.postsListTableViewController?.reloadView()
      // Update views
      self.updateVisibilityOfViews()
    }
    
    postsVM.responseError.bind { [unowned self] (appError) in
      guard let error = appError else {return}
      self.updateVisibilityOfViews()
      self.showErrorFailure(error: error)
    }
    
  }
  
  static func create(with vm: PostsViewModel) -> PostsContainerViewController {
    let storyboard = UIStoryboard(name: "PostsContainerViewController", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "PostsContainerViewController") as! PostsContainerViewController
    vc.postsVM = vm
    return vc
  }
  
  @IBAction func getPostsClicked(_ sender: UIButton) {
    SpinnerView.showSpinner()
    postsVM.callApi()
  }
  
  private func showErrorFailure(error: AppError) {
    showAlert(title: Constants.errorAlertTitle, message: error.localizedDescription)
  }
  
  private func updateVisibilityOfViews() {
    
    // Should Posts list view be shown
    let shouldShowPosts = !self.postsVM.responseList.value.isEmpty && (postsVM.responseError.value == nil)
    self.containerView.isHidden = !shouldShowPosts
    self.getPostsButton.isHidden = shouldShowPosts
    SpinnerView.hideSpinner()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if segue.identifier == String(describing: PostsListTableViewController.self),
        let destinationVC = segue.destination as? PostsListTableViewController {
        postsListTableViewController = destinationVC
        postsListTableViewController?.responseVM = postsVM
    }
  }


}
