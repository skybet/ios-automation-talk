//
//  AnimalPassportSteps.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 15/09/2022.
//

import Foundation
import XCTest

extension AutomationAnimalsBaseClass {
    func thenICanSeeTheCrabImage() {
        XCTContext.runActivity(named: "Then I can see the Crab image") { _ in
            XCTAsyncAssert(CrabPassportScreen.image.element)
        }
    }

    func thenICanSeeTheCrabName() {
        XCTContext.runActivity(named: "Then I can see the Crab name") { _ in
            XCTAsyncAssert(CrabPassportScreen.name.element)
        }
    }

    func thenICanSeeTheCrabProperties() {
        XCTContext.runActivity(named: "Then I can see the Crab properties label") { _ in
            XCTAsyncAssert(CrabPassportScreen.properties.element)
        }
    }


    func thenICanSeeTheTurtleImage() {
        XCTContext.runActivity(named: "Then I can see the Turtle image") { _ in
            XCTAsyncAssert(TurtlePassportScreen.image.element)
        }
    }

    func thenICanSeeTheTurtleName() {
        XCTContext.runActivity(named: "Then I can see the Turtle name") { _ in
            XCTAsyncAssert(TurtlePassportScreen.name.element)
        }
    }

    func thenICanSeeTheTurtleProperties() {
        XCTContext.runActivity(named: "Then I can see the Turtle properties label") { _ in
            XCTAsyncAssert(TurtlePassportScreen.properties.element)
        }
    }

    func thenICanSeeTheFavouriteButton() {
        XCTContext.runActivity(named: "Then I can see the favourite button") { _ in
            XCTAsyncAssert(AnimalPassportScreen.favouriteButton.element)
        }
    }

    func givenIAmOnTheElephantPassport() {
        XCTContext.runActivity(named: "Given I am on the elephant passport") { _ in
            whenIAmOnTheAnimalGallery()
            whenITapOnAnAnimalInTheAnimalGallery(eachAnimal: AnimalGallery.elephant)
        }
    }

    func whenITapOnFavourite() {
        XCTContext.runActivity(named: "When I tap on the favourite button") { _ in
            XCTAsyncAssert(AnimalPassportScreen.favouriteButton.element)
            if(!(AnimalPassportScreen.favouriteButton.element.label.contains("Remove"))) {
                AnimalPassportScreen.favouriteButton.element.tap()
            }
            XCTAsyncAssert(AnimalPassportScreen.removeFavouriteButton.element)
            XCTAssertTrue(AnimalPassportScreen.favouriteButton.element.label.contains("Remove"))
        }
    }

    func thenElephantIsListedOnTheFavouritesScreen() {
        XCTContext.runActivity(named: "Then the elephant is listed on the favourites screen") { _ in
            whenITapReturnInTheNavigationArea()
            XCTAsyncAssert(NavigationItems.favorite.element)
            NavigationItems.favorite.element.tap()
            XCTAsyncAssert(AnimalGallery.elephant.animalElement)
        }
    }

}
