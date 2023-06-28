//
//  ConstantsUtils.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import Foundation

func getValue(forKey key: String) -> String {
    if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") {
        if let keys = NSDictionary(contentsOfFile: path) as? [String: Any],
           let value = keys[key] as? String {
            return value
        }
    }
    return ""
}
