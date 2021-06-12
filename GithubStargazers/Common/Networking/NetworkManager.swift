//
//  NetworkManager.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation

let sharedNetworkManager = NetworkManager()

typealias StargazersHandler = (Result<[Stargazer], StargazerError>) -> Void

class NetworkManager {
    
    internal let baseUrl: String = sharedPListResolver.baseUrl() ?? ""

}
