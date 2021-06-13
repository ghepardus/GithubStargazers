//
//  UIImageLaoder.swift
//  GithubStargazers
//
//  Created by Mario Severino on 13/06/21.
//

import UIKit
import Foundation

class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

  func load(_ url: URL, for imageView: UIImageView) {
    
    let token = imageLoader.loadImage(url) { [unowned self] result in
        
        defer {
            if self.uuidMap[imageView] != nil {
                self.uuidMap.removeValue(forKey: imageView)
            }
        }
        
        switch (result) {
        case .success(let image):
            DispatchQueue.main.async {
                imageView.image = image
            }
        case .failure(let error):
            print(error)
        }
        
    }
    
    if let token = token {
        uuidMap[imageView] = token
    }
    
  }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
    }
  }
}
