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
    
    func downloadImage(url: String, resultHandler: @escaping (Result<Data, StargazerError>) -> Void) {
        
        guard let url = URL(string: url) else {
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
            
            resultHandler(.success(data))
        }
        
        task.resume()
        
    }

}
