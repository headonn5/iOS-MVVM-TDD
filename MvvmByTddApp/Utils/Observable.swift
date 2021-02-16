//
//  Observable.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 16/02/21.
//

import Foundation

public final class Observable<T> {
  
  var value: T {
    didSet {
      notifyObserver()
    }
  }
  
  private var listener: ((T) -> Void)?
  
  init(value: T) {
    self.value = value
  }
  
  private func notifyObserver() {
    DispatchQueue.main.async {
      self.listener?(self.value)
    }
  }
  
  func bind(completionHandler: @escaping (T) -> Void) {
    // Store the completion handler in listener, so that
    // when notifyObserver() is called when value is updated later, then this completion handler can be executed via listener(value)
    listener = completionHandler
    listener?(value)
  }
}
