//
//  BaseViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

// MARK: - ViewModelable
public protocol ViewModelable {
    associatedtype ViewModelType
    var viewModel: ViewModelType? { get set }
}

class BaseViewController<ViewModelType: BaseViewModel>: UIViewController, ViewModelable  {
    public var viewModel: ViewModelType?
}
