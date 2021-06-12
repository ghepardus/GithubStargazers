//
//  NetworkManager+StargazersList.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation

extension NetworkManager {
    
    func loadStargazers(request: StargazersListRequest,
                        resultHandler: @escaping StargazersHandler) {
        
        guard let initialURL = URL(string: baseUrl)?
                .appendingPathComponent("\(request.owner)/\(request.repoName)/stargazers")
                else {
            resultHandler(.failure(.badUrl))
            return
        }
        
        let queryItems = [URLQueryItem(name: "per_page", value: "\(request.itemsPerPage)"),
                          URLQueryItem(name: "page", value: "\(request.pageNumber)")]
        var urlComps = URLComponents(string: initialURL.absoluteString)
        urlComps?.queryItems = queryItems
        
        guard let url = urlComps?.url else {
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
