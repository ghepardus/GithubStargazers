//
//  PListResolver.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation

let sharedPListResolver = PListResolver(plistName: "Config")

class PListResolver {
    
    private let plistName: String

    init(plistName: String) {
        self.plistName = plistName
    }
    
    func baseUrl()-> String? {
        
        if let url = Bundle.main.url(forResource: plistName, withExtension: "plist") {
           do {
             let data = try Data(contentsOf:url)
             let swiftDictionary = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            if let baseUrl = swiftDictionary[ConfigPListIdentifier.baseURL.rawValue] as? String {
                return baseUrl
            }
           } catch {
              print(error)
           }
        }
        
        return nil
    }
    
}

public enum ConfigPListIdentifier: String {
    case baseURL = "baseUrl"
}
