//
//  RepositorySelectionViewModel.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 08/06/21.
//

import Foundation

class RepositorySelectionViewModel: BaseViewModel {

    func validateForm(owner: String?, name: String?, validationHandler: @escaping (Result<(owner: String, name: String), ValidationError>) -> Void)  {
        
        guard let name = name,
              !name.isEmpty else {
            let description = NSLocalizedString("repository.name", comment: "name nil or empty")
            validationHandler(.failure(.emptyOrNull(descripion: description)))
            return
        }
        
        guard let owner = owner,
              !owner.isEmpty else {
            let description = NSLocalizedString("repository.owner", comment: "name nil or empty")
            validationHandler(.failure(.emptyOrNull(descripion: description)))
            return
        }
        
        validationHandler(.success((owner, name)))
        
    }
}
