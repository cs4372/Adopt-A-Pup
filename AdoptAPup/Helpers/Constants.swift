//
//  Constants.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

struct Constants {
    
    // MARK: - API

    static let scheme = "https"
    static let baseURL = "api.petfinder.com"
    static let port: Int? = nil
    static let fullURL = "https://api.petfinder.com"

    static var clientId: String {
        return getValue(forKey: "clientId")
    }
    
    static var clientSecret: String {
        return getValue(forKey: "clientSecret")
    }
    
    static let bodyParams = [
          "client_id": clientId,
          "client_secret": clientSecret,
          "grant_type": "client_credentials"
      ]
}
