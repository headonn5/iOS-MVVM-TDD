//
//  AlertProtocol.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation
import UIKit

protocol AlertProtocol where Self: UIViewController {}

extension AlertProtocol {
  
  func showAlert(title: String, message: String, alertStyle: UIAlertController.Style = .alert, completionHandler: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: completionHandler)
  }
}
