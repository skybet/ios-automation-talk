//
//  AutomationAnimalsUIElements.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 09/09/2022.
//

import XCTest

enum NavigationItems: String {
    case animalGalleryTitle = "Animal Gallery"
    case navigationBar
    case filter = "Filter"
    case favorite = "favorite"
    case backArrow


    var element: XCUIElement {
        switch self {
        case .animalGalleryTitle:
            return XCUIApplication().staticTexts[rawValue]
        case .navigationBar:
            return XCUIApplication().navigationBars[NavigationItems.animalGalleryTitle.rawValue]
        case .filter, .favorite:
            return XCUIApplication().buttons[rawValue]
        case .backArrow:
            return XCUIApplication().buttons[NavigationItems.animalGalleryTitle.rawValue]
        }
    }
}

enum AnimalGallery: String, CaseIterable {
    case crab = "Crab"
    case elephant = "Elephant"
    case giraffe = "Giraffe"
    case horse = "Horse"
    case lion = "Lion"
    case octopus = "Octopus"
    case polarBear = "Polar Bear"
    case seahorse = "Seahorse"
    case seal = "Seal"
    case squirrel = "Squirrel"
    case turtle = "Turtle"
    case whale = "Whale"

    var animalElement: XCUIElement {
        return XCUIApplication().staticTexts[rawValue]
    }

    var animalDetailsScreenElement: XCUIElement {
        return XCUIApplication().navigationBars[rawValue]
    }
}
