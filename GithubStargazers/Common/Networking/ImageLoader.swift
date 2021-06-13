//
//  ImageLoader.swift
//  GithubStargazers
//
//  Created by Mario Severino on 13/06/21.
//

import UIKit
import Foundation

class ImageLoader {
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ resultHandler: @escaping (Result<UIImage, StargazerError>) -> Void) -> UUID? {
        

        if let image = loadedImages[url] {
            resultHandler(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
            defer {self.runningRequests.removeValue(forKey: uuid) }

            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError(type: .wrongResponseCode)))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
        
            if let image = UIImage(data: data) {
                self.loadedImages[url] = image
                resultHandler(.success(image))
            }

        }
        
        task.resume()

        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
