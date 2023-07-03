//
//  HomeControllerViewModel.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit

class HomeControllerViewModel {
    
    private var accessToken: String?
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
        self.fetchAccessToken()
    }
    
    func fetchAccessToken() {
        guard !isLoading else {
            return
        }
        isLoading = true
        let tokenEndpoint = Endpoint.getBearerToken()
        
        if accessToken != nil {
            print("has access token")
            self.fetchPuppies()
            return
        }
        
        APIService.getAccessToken(with: tokenEndpoint) { [weak self] result in
            switch result {
              case .success(let accessToken):
                  self?.accessToken = accessToken
                  self?.fetchPuppies()
              case .failure(let error):
                print("failure getting token", error)
              }
          }
      }

    func fetchPuppies() {
        
        guard let accessToken = accessToken else {
            print("access token error")
            return
        }
        
        let endpoint = Endpoint.fetchPuppies(page: currentPage)

        APIService.fetchPuppies(with: endpoint, with: accessToken) { [weak self] result in
            switch result {
            case .success(let res):

                DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.puppies.append(contentsOf: res.puppies)
                }
                self?.currentPage += 1
                self?.totalPages = res.pagination.totalPages ?? 0
            case .failure(let error):
                print("Failed to fetch puppies:", error)
            }
            self?.isLoading = false
        }
    }
}
