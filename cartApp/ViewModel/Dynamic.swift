//
//  Dynamic.swift
//  cartApp
//
//  Created by Payal Kandlur on 06/10/21.
//

import Foundation

/**
 Class to to handle bind and fire listeners
 */

class Dynamic<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?
  
  func bind(listener: Listener?) {
    self.listener = listener
  }
  
  func bindAndFire(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ v: T) {
    value = v
  }
}

