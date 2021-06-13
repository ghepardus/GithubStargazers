//
//  StargazerListViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerListViewController: BaseViewController<StargazerListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    let loader = ImageLoader()
    
    //MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.getData()
    }
    
    //MARK: - Private functions
    private func setupUI() {
        self.title = NSLocalizedString("stargazers.list.title", comment: "title")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func getData() {
        
        self.viewModel?.fetchInitialData() {
            [unowned self] result in
            
            switch result {
            case .success(_):
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - UITableView delegate & datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.stargazersList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StargazerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StargazerTableViewCell") as! StargazerTableViewCell
        
        if let viewModel = self.viewModel,
           let profileImageUrl = viewModel.stargazersList[indexPath.row].profileImageURL {
            cell.userNameLabel.text = viewModel.stargazersList[indexPath.row].name
            cell.userImage?.loadImage(at: profileImageUrl)
        }
        return cell
    }

}
