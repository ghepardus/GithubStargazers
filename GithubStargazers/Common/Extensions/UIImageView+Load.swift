//
//  UIImageView+Load.swift
//  GithubStargazers
//
//  Created by Mario Severino on 13/06/21.
//

import UIKit
import Foundation

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
