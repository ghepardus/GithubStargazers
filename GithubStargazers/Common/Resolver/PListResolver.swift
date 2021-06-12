//
//  PListResolver.swift
//  GithubStargazers (iOS)
//
//  Created by Mario Severino on 12/06/21.
//

import Foundation

let sharedPListResolver = PListResolver()

class PListResolver {
    
    private let plistName: String = "Config"
    
    private func getPlistDictionary() -> [String:Any] {
        
        if let url = Bundle.main.url(forResource: plistName, withExtension: "plist") {
           do {
             let data = try Data(contentsOf:url)
             let swiftDictionary = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            return swiftDictionary
           } catch {
              print(error)
           }
        }
        
        return ["":""]
    }
    
    func baseUrl() -> String? {
        
        if let baseUrl = getPlistDictionary()[ConfigPListIdentifier.baseURL.rawValue] as? String {
            return baseUrl
        }
        
        return nil
    }
    
    func defaultItemsPerPage() -> Int {
        if let defaultItemsPerPage = getPlistDictionary()[ConfigPListIdentifier.defaultItemsPerPage.rawValue] as? Int {
            return defaultItemsPerPage
        }
        
        return 0
    }
    
    func defaultInitialPage() -> Int {
        
        if let defaultItemsPerPage = getPlistDictionary()[ConfigPListIdentifier.defaultInitialPage.rawValue] as? Int {
            return defaultItemsPerPage
        }
        
        return 0
    }
    
}

public enum ConfigPListIdentifier: String {
    case baseURL = "baseUrl"
    case defaultItemsPerPage
    case defaultInitialPage
}
