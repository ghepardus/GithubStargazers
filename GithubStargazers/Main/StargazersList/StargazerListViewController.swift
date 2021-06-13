//
//  StargazerListViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerListViewController: BaseViewController<StargazerListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        viewModel?.fetchInitialData() {
            [unowned self] result in
            
            switch result {
            case .success(_):
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.stargazersList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StargazerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StargazerTableViewCell") as! StargazerTableViewCell
        if let viewModel = self.viewModel {
            cell.userNameLabel.text = viewModel.stargazersList[indexPath.row].name
        }
        return cell
    }

}
