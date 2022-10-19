//
//  FilterAnimalsElements.swift
//  AutomationAnimalsUITests
//
//  Created by Sanaa Shahzadi on 16/09/2022.
//

import Foundation
import XCTest

enum FilterAnimalsScreen: String {
    case filterButton = "Filter"
    case doneButton = "Done"
    case clearAllButton = "Clear All"
    case filterProperties
    case filterRockpool = "Rockpool"
    case filterSmall = "Small"

    var element: XCUIElement {
        switch self {
        case .doneButton, .clearAllButton:
            return XCUIApplication().buttons[rawValue]
        case .filterButton:
            return XCUIApplication().buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", rawValue)).element
        case .filterRockpool, .filterSmall:
            return XCUIApplication().tables.firstMatch.cells.staticTexts[rawValue]
        default:
            return XCUIApplication().buttons[rawValue]
        }
    }

    var elementQuery: XCUIElementQuery {
        return XCUIApplication().tables.firstMatch.cells.staticTexts
    }
}
