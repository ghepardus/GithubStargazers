//
//  StargazerListViewModel.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerListViewModel: BaseViewModel {
    
    private let repositoryOwner: String
    private let repositoryName: String
    
    private var pageNumber = sharedPListResolver.defaultInitialPage()
    
    init(owner: String, name: String) {
        self.repositoryOwner = owner
        self.repositoryName = name
    }
    
    func fetchInitialData(resultHandler: @escaping StargazersHandler) {
        let request = StargazersListRequest(repoName: self.repositoryName, owner: self.repositoryOwner)
        sharedNetworkManager.loadStargazers(request: request) { result in
            resultHandler(result)
        }
    }
    
    func fetchNextPage(resultHandler: @escaping StargazersHandler) {
        self.pageNumber += 1
        let request = StargazersListRequest(repoName: self.repositoryName, owner: self.repositoryOwner, pageNumber: self.pageNumber)
        sharedNetworkManager.loadStargazers(request: request) { result in
            resultHandler(result)
        }
    }
}
