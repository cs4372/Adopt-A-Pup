//
//  HomeControllerViewModel.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit

class HomeControllerViewModel {
    
    var currentPage = 1
    var totalPages = 0
    
    var onPuppiesUpdated: (()->Void)?
    var onLoading: ((Bool) -> Void)?
    
    private(set) var puppies: [Puppy] = [] {
        didSet {
            self.onPuppiesUpdated?()
        }
    }
    
    var isLoading = false {
        didSet {
            self.onLoading?(isLoading)
        }
    }
    
    init() {
        self.fetchPuppies()
    }
    
    public func fetchPuppies() {
        guard !isLoading else {
            return
        }
        
        isLoading = true

        let endpoint = Endpoint.getBearerToken()

        APIService.getAccessToken(with: endpoint) { [weak self] result in
            switch result {
            case .success(let accessToken):
                self?.fetchPuppiesWithToken(accessToken: accessToken, completion: { _ in })
            case .failure(let error):
                print("Failed to get access token:", error)
                self?.isLoading = false
            }
        }
    }

    func fetchPuppiesWithToken(accessToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = Endpoint.fetchPuppies(page: currentPage)

        APIService.fetchPuppies(with: endpoint, with: accessToken) { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
                    self?.puppies.append(contentsOf: res.puppies)
                }
                completion(.success(()))
                self?.currentPage += 1
                self?.totalPages = res.pagination.totalPages ?? 0
            case .failure(let error):
                print("Failed to fetch puppies:", error)
            }
            self?.isLoading = false
        }
    }
}

