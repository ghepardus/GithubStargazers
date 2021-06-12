//
//  RepositorySelectionViewModel.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 08/06/21.
//

class RepositorySelectionViewModel: BaseViewModel {

    func validateForm(owner: String?, name: String?, validationHandler: @escaping (Result<(owner: String, name: String), ValidationError>) -> Void)  {
        
        guard let owner = owner else {
            validationHandler(.failure(.emptyOrNull(descripion: "Owner")))
            return
        }
        
        guard let name = name else {
            validationHandler(.failure(.emptyOrNull(descripion: "Owner")))
            return
        }
        
        validationHandler(.success((owner, name)))
        
    }
}
