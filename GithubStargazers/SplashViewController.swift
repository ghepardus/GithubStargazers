//
//  ViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let viewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RepositorySelectionViewController") as? RepositorySelectionViewController {
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
//        let request = StargazersListRequest(repoName: "octocat", owner: "hello-world")
//        sharedNetworkManager.loadStargazers(request: request) { result in
//            switch result {
//                case .success(let successValue):
//                    print(successValue)
//                case .failure(let error):
//                    print(error)
//                }
//        }
    }


}

