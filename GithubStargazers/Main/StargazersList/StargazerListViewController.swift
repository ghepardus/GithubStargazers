//
//  StargazerListViewController.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerListViewController: BaseViewController<StargazerListViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var messageViewContainer: UIView!
    @IBOutlet var messageLabel: UILabel!
    
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
        
        self.tableView.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.messageViewContainer.isHidden = true
    }
    
    private func getData() {
        
        self.viewModel?.fetchInitialData() {
            [unowned self] result in
            
            switch result {
            case .success(_):
                self.tableView.isHidden = false
                self.tableView.reloadData()
            case .failure(let error):
                switch error {
                case .emptyData:
                    self.showNoDataMessage()
                default:
                    self.showError()
                }
            }
        }
    }
    
    private func getMoreData() {
        self.viewModel?.fetchNextPage {
            [unowned self] result in
            
            switch result {
            case .success(_):
                self.tableView.isHidden = false
                self.tableView.reloadData()
            case .failure(let error):
                switch error {
                case .emptyData:
                    self.showNoDataMessage()
                default:
                    self.showError()
                }
            }
        }
    }
    
    private func showError() {
        self.tableView.isHidden = true
        self.messageLabel.text = NSLocalizedString("fetch.error.message", comment: "error message")
        self.messageViewContainer.isHidden = false
    }
    
    private func showNoDataMessage() {
        self.tableView.isHidden = true
        self.messageLabel.text = NSLocalizedString("fetch.nodata.message", comment: "error message")
        self.messageViewContainer.isHidden = false
    }
    
    //MARK: - UITableView delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.viewModel?.stargazersList.count ?? 0
        } else if section == 1 {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1) {
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell") as! LoadingTableViewCell
            cell.spinner.startAnimating()
            self.getMoreData()
            return cell
        } else {
            let cell: StargazerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StargazerTableViewCell") as! StargazerTableViewCell
            
            if let viewModel = self.viewModel,
               let profileImageUrl = viewModel.stargazersList[indexPath.row].profileImageURL {
                cell.userNameLabel.text = viewModel.stargazersList[indexPath.row].name
                cell.userImage?.loadImage(at: profileImageUrl)
            }
            return cell
        }
        
    }

}
