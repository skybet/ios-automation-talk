//
//  AnimalPassportTests.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 15/09/2022.
//

import Foundation
import XCTest

class AnimalPassportTests: AutomationAnimalsBaseClass {

    func testCrabPassport() {
        whenIAmOnTheAnimalGallery()
        whenITapOnAnAnimalInTheAnimalGallery(eachAnimal: AnimalGallery.crab)
        thenICanSeeTheCrabImage()
        thenICanSeeTheCrabName()
        thenICanSeeTheCrabProperties()
        thenICanSeeTheFavouriteButton()
    }

    func testTurtlePassport() {
        whenIAmOnTheAnimalGallery()
        whenITapOnAnAnimalInTheAnimalGallery(eachAnimal: AnimalGallery.turtle)
        thenICanSeeTheTurtleImage()
        thenICanSeeTheTurtleName()
        thenICanSeeTheTurtleProperties()
        thenICanSeeTheFavouriteButton()
    }

    func testFavourite_Elephant() {
        givenIAmOnTheElephantPassport()
        whenITapOnFavourite()
        thenElephantIsListedOnTheFavouritesScreen()
    }

}
