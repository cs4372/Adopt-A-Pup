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

class APIService {
    
    static func getAccessToken(with endpoint: Endpoint, completion: @escaping (Result<String, APIServiceError>) -> Void) {

        guard let request = endpoint.request else { return }
        
        print("request ==>", request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                
                do {
                    let apiError = try JSONDecoder().decode(APIError.self, from: data ?? Data())
                    completion(.failure(.serverError(apiError)))
                    
                } catch let err {
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(Token.self, from: data)
                    completion(.success(coinData.accessToken))
                    
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
                
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
    
    static func fetchPuppies(with endpoint: Endpoint, with accessToken: String, completion: @escaping (Result<PuppyArray, APIServiceError>) -> Void) {
        
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
                   } catch let err {
                       completion(.failure(.unknown()))
                       print("inside catch 1", err.localizedDescription)
                   }
                   return
               }
               
               if let data = data {
                   do {
                       let decoder = JSONDecoder()
                       let puppies = try decoder.decode(PuppyArray.self, from: data)
                       print("puppies", puppies)
                       completion(.success(puppies))
                   } catch let err {
                       completion(.failure(.decodingError()))
                       print("inside catch 2", err.localizedDescription)
                   }
               } else {
                   completion(.failure(.unknown()))
               }
               
           }.resume()
       }
}
