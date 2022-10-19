//
//  AnimalPassportElements.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 15/09/2022.
//

import Foundation
import XCTest

enum CrabPassportScreen: String {
    case image
    case name = "Crab"
    case properties = "Small, Sea, Shore, Rockpool, Shell"

    var element: XCUIElement {
        switch self {
        case .image:
            return XCUIApplication().images.firstMatch
        case .name, .properties:
            return XCUIApplication().staticTexts[rawValue]
        }
    }
}

enum TurtlePassportScreen: String {
    case image
    case name = "Turtle"
    case properties = "Small, Sea, Shore, Shell"

    var element: XCUIElement {
        switch self {
        case .image:
            return XCUIApplication().images.firstMatch
        case .name, .properties:
            return XCUIApplication().staticTexts[rawValue]
        }
    }
}

enum AnimalPassportScreen: String {
    case favouriteButton = "Favourite"
    case removeFavouriteButton = "Remove Favourite"

    var element: XCUIElement {
        switch self {
        case .favouriteButton, .removeFavouriteButton:
            return XCUIApplication().buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", rawValue)).element
        }
    }
}
