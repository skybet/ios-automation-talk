//
//  Animal.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import Foundation

enum AnimalSize {
    case small
    case medium
    case large
}

struct Animal: Identifiable, Hashable {
    var id: UUID
    var name: String
    var size: AnimalSize
    var imageName: String
    var tags: [String]
}
