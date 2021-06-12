//
//  Button+Utils.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation
import UIKit

extension UIButton {
    
    func setTitle(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .focused)
        self.setTitle(title, for: .disabled)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .reserved)
        self.setTitle(title, for: .selected)
    }
}


