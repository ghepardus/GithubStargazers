//
//  StargazerListViewModel.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerListViewModel: BaseViewModel {
    
    typealias StargazersListHandler = (Result<Bool, StargazerError>) -> Void
    
    private let repositoryOwner: String
    private let repositoryName: String
    
    private var pageNumber = sharedPListResolver.defaultInitialPage()
    
    private(set) var stargazersList: [Stargazer] = []
    
    init(owner: String, name: String) {
        self.repositoryOwner = owner
        self.repositoryName = name
    }
    
    func fetchInitialData(resultHandler: @escaping StargazersListHandler) {
        let request = StargazersListRequest(repoName: self.repositoryName, owner: self.repositoryOwner)
        sharedNetworkManager.loadStargazers(request: request) { [unowned self] result in
            switch result {
            case .failure(let error):
                resultHandler(.failure(error))
            case.success(let stargasers):
                self.stargazersList = stargasers
                resultHandler(.success(true))
            }
        }
    }
    
    func fetchNextPage(resultHandler: @escaping StargazersListHandler) {
        self.pageNumber += 1
        let request = StargazersListRequest(repoName: self.repositoryName, owner: self.repositoryOwner, pageNumber: self.pageNumber)
        sharedNetworkManager.loadStargazers(request: request) { result in
            switch result {
            case .failure(let error):
                resultHandler(.failure(error))
            case.success(let stargasers):
                self.stargazersList = stargasers
                resultHandler(.success(true))
            }
        }
    }
}
