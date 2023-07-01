//
//  Puppy.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

struct PuppyArray: Decodable {
    let animals: [Puppy]
    let pagination: Pagination
}

struct Puppy: Decodable {
    let id: Int
    let name: String?
    let url: String?
    let breeds: Breeds
    let colors: Colors
    let age: String?
    let gender: String?
    let size: String?
    let primaryPhotoCropped: Photo?
    let contact: Contact
    
    enum CodingKeys: String, CodingKey {
         case id, name, url, breeds, colors, age, gender, size, contact
         case primaryPhotoCropped = "primary_photo_cropped"
     }
}

struct Breeds: Decodable {
    let primary: String?
    let secondary: String?
    let mixed, unknown: Bool
}

struct Colors: Decodable {
    let primary, secondary, tertiary: String?
}

struct Photo: Decodable {
    let small, medium, large, full: String
}

struct Contact: Decodable {
    let email: String?
    let phone: String?
    let address: Address
}

struct Address: Decodable {
    let address1: String?
    let address2: String?
    let city, state, postcode: String?
    let country: String?
}

struct Pagination: Decodable {
    let countPerPage: Int?
    let totalCount: Int?
    let currentPage: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case countPerPage = "count_per_page"
        case totalCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}
