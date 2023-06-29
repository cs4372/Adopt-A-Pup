//
//  Endpoint.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

enum Endpoint {
    case getBearerToken(url: String = "/v2/oauth2/token")
    case fetchPuppies(page: Int, url: String = "/v2/animals")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchPuppies(_, let url):
            return url
        case .getBearerToken(url: let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchPuppies(let page, _):
            return [
                URLQueryItem(name: "type", value: "dog"),
                URLQueryItem(name: "page", value: String(page))
            ]
        default:
            return []
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchPuppies:
            return HTTP.Method.get.rawValue
        case .getBearerToken:
            return HTTP.Method.post.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchPuppies:
            return nil
        case .getBearerToken:
            return try? JSONSerialization.data(withJSONObject: Constants.bodyParams)
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        default:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
        }
    }
}
