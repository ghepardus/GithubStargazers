//
//  RepositorySelectionViewController.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 08/06/21.
//

import UIKit

class RepositorySelectionViewController: BaseViewController {
    
    @IBOutlet var ownerTF: UITextField!
    @IBOutlet var repoTF: UITextField!
    @IBOutlet var confirmButton: UIButton!

    //MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add gesture to dismiss keyboard on tap outside
        self.setupDismissGesture()
        self.setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Dismiss keyboard on disappear
        self.view.endEditing(true)
    }
    
    //MARK: - Private functions
    private func setupDismissGesture() {
        let tap = UITapGestureRecognizer(target: self,
                                          action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    @objc func confirmAction(sender: UIButton) {
            
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}
