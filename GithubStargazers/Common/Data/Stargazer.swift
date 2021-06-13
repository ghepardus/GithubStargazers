//
//  Stargazer.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 08/06/21.
//

import Foundation
import UIKit

struct Stargazer {
    let name: String?
    let identifier: Int?
    let profileImageURL: URL?
}
 
extension Stargazer: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "login"
        case profileImageURL = "avatar_url"
    }
}
