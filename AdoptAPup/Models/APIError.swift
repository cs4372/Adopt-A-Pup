//
//  APIError.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

struct APIError: Decodable {
    let status: Int
    let title: String
    let detail: String
}
