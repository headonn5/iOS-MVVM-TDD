//
//  SpinnerView.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 04/03/21.
//

import UIKit

class SpinnerView {
  
  private static var spinner: UIActivityIndicatorView?
  
  public static func showSpinner() {
    DispatchQueue.main.async {
      // If spinner is nil, create one and attach it on the main window
      if spinner == nil, let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
        let frame = UIScreen.main.bounds
        let spinner = UIActivityIndicatorView(frame: frame)
        spinner.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        spinner.style = .large
        window.addSubview(spinner)
        
        spinner.startAnimating()
        
        // Store the local spinner in the static var
        self.spinner = spinner
      }
    }
  }
  
  public static func hideSpinner() {
    DispatchQueue.main.async {
      guard let spinner = self.spinner else {
        return
      }
      spinner.stopAnimating()
      spinner.removeFromSuperview()
      
      self.spinner = nil
    }
  }

}
