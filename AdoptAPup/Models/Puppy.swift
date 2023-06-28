//
//  Puppy.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

struct PuppyArray: Decodable {
    let animals: [Puppy]
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
}

struct Breeds: Decodable {
    let primary: String
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
