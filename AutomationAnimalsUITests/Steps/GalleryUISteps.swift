//
//  AutomationAnimalsUISteps.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 09/09/2022.
//

import XCTest

extension AutomationAnimalsBaseClass {

    func givenAutomationAnimalsAppIsOpen() {
        XCTContext.runActivity(named: "Given the Automation Animals app is open") { _ in
            XCTAsyncAssert(NavigationItems.navigationBar.element)
        }
    }

    func whenIAmOnTheAnimalGallery() {
        XCTContext.runActivity(named: "When I am on the Animal Gallery screen") { _ in
            XCTAsyncAssert(NavigationItems.animalGalleryTitle.element)
        }
    }

    func thenICanSeeTheAnimalGalleryTitleAndFilterAndFavouritesItems() {
        XCTContext.runActivity(named: "Then I can see the Animal Gallery title, filter and favourites items") { _ in
            XCTAsyncAssert(NavigationItems.animalGalleryTitle.element)
            XCTAsyncAssert(NavigationItems.filter.element)
            XCTAsyncAssert(NavigationItems.favorite.element)
        }
    }

    func whenITapOnAnAnimalInTheAnimalGallery(eachAnimal: AnimalGallery) {
        XCTContext.runActivity(named: "When I tap on \(eachAnimal.rawValue) in the Animal Gallery") { _ in
            if (!(eachAnimal.animalElement.isHittable)) {
                XCUIApplication().swipeUp()
            }
            XCTAsyncAssert(eachAnimal.animalElement)
            eachAnimal.animalElement.tap()
        }
    }

    func thenTheAnimalDetailsScreenIsDisplayed(eachAnimal: AnimalGallery) {
        XCTContext.runActivity(named: "Then the \(eachAnimal.rawValue) detail screen is displayed") { _ in
            XCTAsyncAssert(eachAnimal.animalDetailsScreenElement)
        }
    }

    func whenITapReturnInTheNavigationArea() {
        XCTContext.runActivity(named: "When I tap the return button in the navigation bar") { _ in
            XCTAsyncAssert(NavigationItems.backArrow.element)
            NavigationItems.backArrow.element.tap()
        }
    }

    func thenIAmReturnedToTheAnimalGallery() {
        whenIAmOnTheAnimalGallery()
    }
}
