//
//  RepositorySelectionViewController.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 08/06/21.
//

import UIKit

class RepositorySelectionViewController: BaseViewController<RepositorySelectionViewModel> {
    
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
        
        repoTF.placeholder = NSLocalizedString("repository.name", comment: "Repository name placeholder")
        ownerTF.placeholder = NSLocalizedString("repository.owner", comment: "Repository owner placeholder")
        
        confirmButton.setTitle(title: NSLocalizedString("confirm", comment: "confirm"))
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    //MARK: - Selectors
    @objc func confirmAction(sender: UIButton) {
        
        viewModel?.validateForm(owner: ownerTF.text, name: repoTF.text) {
            [unowned self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StargazerListViewController") as? StargazerListViewController {
                    vc.viewModel = StargazerListViewModel(owner: success.owner, name: success.name)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            
        }
        
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}
