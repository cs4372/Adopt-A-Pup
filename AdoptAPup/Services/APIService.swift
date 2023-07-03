//
//  APIService.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

enum APIServiceError: Error {
    case serverError(APIError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

struct PuppiesResponse {
    let puppies: [Puppy]
    let pagination: Pagination
}

class APIService {
    
    static func getAccessToken(with endpoint: Endpoint, completion: @escaping (Result<String, APIServiceError>) -> Void) {

        guard let request = endpoint.request else { return }
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                
                do {
                    let apiError = try JSONDecoder().decode(APIError.self, from: data ?? Data())
                    
                } catch _ {
                    completion(.failure(.unknown()))
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let tokenData = try decoder.decode(Token.self, from: data)
                    completion(.success(tokenData.accessToken))
                    
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
    
    static func fetchPuppies(with endpoint: Endpoint, with accessToken: String, completion: @escaping (Result<PuppiesResponse, APIServiceError>) -> Void) {
        
        guard var request = endpoint.request else { return }

           request.addValue("Bearer \(accessToken)", forHTTPHeaderField: HTTP.HttpHeaderField.authorization.rawValue)
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(.unknown(error.localizedDescription)))
                   return
               }
               
               if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                   do {
                       let apiError = try JSONDecoder().decode(APIError.self, from: data ?? Data())
                       completion(.failure(.serverError(apiError)))
                   } catch _ {
                       completion(.failure(.unknown()))
                   }
                   return
               }
               
               if let data = data {
                   do {
                       let puppyArray = try JSONDecoder().decode(PuppyArray.self, from: data)
                       let puppiesResponse = PuppiesResponse(puppies: puppyArray.animals, pagination: puppyArray.pagination)
                       completion(.success(puppiesResponse))
                   } catch _ {
                       completion(.failure(.decodingError()))
                   }
               } else {
                   completion(.failure(.unknown()))
               }
               
           }.resume()
       }
}
