//
//  Errors.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

enum StargazerError: Error {
    case badUrl
    case clientError
    case serverError(type: ServerError)
    case noData
    case dataDecodingError
}

enum ServerError {
    case wrongResponseCode
    case wrongMIMEType
}

enum ValidationError: Error {
    case emptyOrNull(descripion: String)
}
