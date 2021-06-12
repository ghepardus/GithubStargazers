//
//  StargazersListRequest.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

struct StargazersListRequest {
    let repoName: String
    let owner: String
    var itemsPerPage: Int = sharedPListResolver.defaultItemsPerPage()
    var pageNumber: Int = sharedPListResolver.defaultInitialPage()
}
