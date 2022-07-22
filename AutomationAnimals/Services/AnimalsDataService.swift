//
//  AnimalsDataService.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import Foundation

class AnimalsDataService {
    
    private(set) var animals: [Animal]!
    
    init() {
        animals = loadAnimals()
    }
    
    private func loadAnimals() -> [Animal] {
        return [
            Animal(id: UUID(uuidString: "e655225c-30b3-4f53-bdc5-b822d3b663c8")!, name: "Crab", size: .small, imageName: "crab", tags: ["Small", "Sea", "Shell"]),
            Animal(id: UUID(uuidString: "587a6c4c-35f4-438b-8884-87da0189c11a")!, name: "Elephant", size: .large, imageName: "elephant", tags: ["Large", "Land", "Hair"]),
            Animal(id: UUID(uuidString: "40ecda3a-7b64-49a8-b7e0-b26851e990e7")!, name: "Giraffe", size: .large, imageName: "giraffe", tags: ["Large", "Land", "Hair"]),
            Animal(id: UUID(uuidString: "a16a0d26-61eb-409b-a62a-9a83b0e0d416")!, name: "Horse", size: .large, imageName: "horse", tags: ["Large", "Land", "Hair"]),
            Animal(id: UUID(uuidString: "744b34da-9aba-4996-aec6-5a5214be13ce")!, name: "Lion", size: .large, imageName: "lion", tags: ["Large", "Land", "Hair"]),
            Animal(id: UUID(uuidString: "ad3e5b02-1404-48e8-be57-750c877e5dbc")!, name: "Octopus", size: .medium, imageName: "octopus", tags: ["Medium", "Sea", "Skin"]),
            Animal(id: UUID(uuidString: "f2cb8c6e-445b-4fbd-99c5-a2eb56728be0")!, name: "Polar Bear", size: .large, imageName: "polarBear", tags: ["Large", "Ice", "Fur"]),
            Animal(id: UUID(uuidString: "240be7d7-8ec1-4eca-baa4-2e00243dd520")!, name: "Seahorse", size: .small, imageName: "seahorse", tags:["Small", "Sea", "Skin"]),
            Animal(id: UUID(uuidString: "32740518-e523-4c1a-9516-5602664fc682")!, name: "Seal", size: .medium, imageName: "seal", tags: ["Medium", "Sea", "Shore", "Ice", "Fur"]),
            Animal(id: UUID(uuidString: "ed5dda17-3eb3-4e9c-ae21-30e0cd44e692")!, name: "Squirrel", size: .small, imageName: "squirrel", tags: ["Small", "Forest", "Fur"]),
            Animal(id: UUID(uuidString: "c7e9ef47-48d3-468d-b330-2bb67ff325d1")!, name: "Turtle", size: .small, imageName: "turtle", tags: ["Small", "Sea", "Shore", "Shell"]),
            Animal(id: UUID(uuidString: "53ab6341-96f0-412d-9651-b6e46c46cdba")!, name: "Whale", size: .large, imageName: "whale", tags: ["Large", "Sea", "Skin"])
        ]
    }
    
    var allTags: [String] {
        var tags: Set<String> = []
        for animal in animals {
            for animalTag in animal.tags {
                tags.insert(animalTag)
            }
        }
        return Array(tags).sorted()
    }
}
