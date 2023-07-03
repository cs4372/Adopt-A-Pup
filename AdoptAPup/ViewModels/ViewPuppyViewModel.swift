//
//  ViewPuppyViewModel.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/29/23.
//

import Foundation

class ViewPuppyViewModel  {
        
    // MARK: - Variables
    let puppy: Puppy
    
    // MARK: - Initializer

    init(_ puppy: Puppy) {
        self.puppy = puppy
    }
    
    var nameLabel: String {
        return "Name: \(self.puppy.name ?? "Unknown")"
    }
    
    var descriptionLabel: String {
        return "Description: \(self.puppy.description ?? "Unknown")"
    }
    
    var ageLabel: String {
        return "Age: \(self.puppy.age ?? "Unknown")"
    }
    
    var genderLabel: String {
        return "Gender: \(self.puppy.gender ?? "Unknown")"
    }
    
    var sizeLabel: String {
        return "Size: \(self.puppy.size ?? "Unknown")"
    }
    
    var primaryBreedLabel: String {
        return "Primary Breed: \(self.puppy.breeds.primary ?? "Unknown")"
    }
}

