//
//  HomeControllerViewModel.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit

class HomeControllerViewModel {
    
    init() {
        self.fetchPuppies()
    }
    
    public func fetchPuppies() {
        let endpoint = Endpoint.getBearerToken()

        APIService.getAccessToken(with: endpoint) { [weak self] result in
            switch result {
            case .success(let accessToken):
                self?.fetchPuppiesWithToken(accessToken: accessToken)
            case .failure(let error):
                print("Failed to get access token:", error)
            }
        }
    }

    private func fetchPuppiesWithToken(accessToken: String) {
        let endpoint = Endpoint.fetchPuppies()

        APIService.fetchPuppies(with: endpoint, with: accessToken) { [weak self] result in
            switch result {
            case .success(let puppies):
                print("Puppies:", puppies)
            case .failure(let error):
                print("Failed to fetch puppies:", error)
            }
        }
    }
}

