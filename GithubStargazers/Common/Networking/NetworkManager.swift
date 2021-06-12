//
//  NetworkManager.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation

let sharedNetworkManager = NetworkManager()

class NetworkManager {
    
    private let baseUrl: String = sharedPListResolver.baseUrl() ?? ""
    
    func loadStargazers(request: StargazersListRequest,
                        resultHandler: @escaping (Result<[Stargazer], StargazerError>) -> Void) {
        
        guard let url = URL(string: baseUrl)?
                .appendingPathComponent("\(request.repoName)/\(request.owner)/stargazers")
                else {
            resultHandler(.failure(.badUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError(type: .wrongResponseCode)))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                resultHandler(.failure(.serverError(type: .wrongMIMEType)))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            
            do {
                let stargazers = try JSONDecoder().decode([Stargazer].self, from: data)
                DispatchQueue.main.async {
                    resultHandler(.success(stargazers))
                }
                
            } catch {
                resultHandler(.failure(.dataDecodingError))
            }
        }
        
        task.resume()
    }

}
