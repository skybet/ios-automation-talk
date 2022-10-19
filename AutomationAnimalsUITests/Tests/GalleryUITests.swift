//
//  AutomationAnimalsUITests.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima & Sanaa on 22/07/2022.
//

import XCTest

class AutomationAnimalsUITests: AutomationAnimalsBaseClass {

    func testAnimalGalleryTitle() {
        givenAutomationAnimalsAppIsOpen()
        whenIAmOnTheAnimalGallery()
        thenICanSeeTheAnimalGalleryTitleAndFilterAndFavouritesItems()
    }

    func testAnimalsInAnimalGallery() {
        whenIAmOnTheAnimalGallery()
        for animal in AnimalGallery.allCases {
            whenITapOnAnAnimalInTheAnimalGallery(eachAnimal: animal)
            thenTheAnimalDetailsScreenIsDisplayed(eachAnimal: animal)
            whenITapReturnInTheNavigationArea()
            thenIAmReturnedToTheAnimalGallery()
        }
    }
}
