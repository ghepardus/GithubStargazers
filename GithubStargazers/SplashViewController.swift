//
//  ViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.goToMainController()
    }
    
    //MARK: - Private functions
    private func goToMainController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RepositorySelectionViewController") as? RepositorySelectionViewController {
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

}

