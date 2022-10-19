//
//  FilterAnimalsSteps.swift
//  AutomationAnimalsUITests
//
//  Created by Sanaa Shahzadi on 16/09/2022.
//

import Foundation
import XCTest

extension AutomationAnimalsBaseClass {
    func whenITapTheFilterButton() {
        XCTContext.runActivity(named: "When I tap the Filter button") { _ in
            XCTAsyncAssert(FilterAnimalsScreen.filterButton.element)
            FilterAnimalsScreen.filterButton.element.tap()
        }
    }

    func thenICanSeeTheFilterBottomSheet() {
        XCTContext.runActivity(named: "Then I can see the Clear All and Done button in the Filter bottom sheet and the Filter Property count is as expected") { _ in
            XCTAsyncAssert(FilterAnimalsScreen.clearAllButton.element)
            XCTAsyncAssert(FilterAnimalsScreen.doneButton.element)
            // MARK: Forced failure
            XCTAssertEqual(FilterAnimalsScreen.filterProperties.elementQuery.count, 10)
        }
    }

    func whenITapDone() {
        XCTContext.runActivity(named: "When I tap done") { _ in
            FilterAnimalsScreen.doneButton.element.tap()
        }
    }

    func thenTheBottomSheetCloses() {
        XCTContext.runActivity(named: "Then the bottom sheet closes and I am returned to the Gallery screen") { _ in
            XCTAssertFalse(FilterAnimalsScreen.doneButton.element.isHittable)
        }
    }

    func givenTheFilterBottomSheetIsOpen() {
        XCTContext.runActivity(named: "Given the Filter bottom sheet is open") { _ in
            givenAutomationAnimalsAppIsOpen()
            whenITapTheFilterButton()
            XCTAsyncAssert(FilterAnimalsScreen.clearAllButton.element)
        }
    }

    func whenIFilterOnRockpoolAndSmall() {
        XCTContext.runActivity(named: "When I filter on Rockpool and Small properties") { _ in
            XCTAsyncAssert(FilterAnimalsScreen.filterRockpool.element)
            FilterAnimalsScreen.filterRockpool.element.tap()
            XCTAsyncAssert(FilterAnimalsScreen.filterSmall.element)
            FilterAnimalsScreen.filterSmall.element.tap()
            whenITapDone()
        }
    }

    func thenOnlyTheFilteredResultsAreDisplayed() {
        XCTContext.runActivity(named: "Then only the filtered results are displayed") { _ in
            XCTAsyncAssert(AnimalGallery.crab.animalElement)
            XCTAsyncAssert(AnimalGallery.seahorse.animalElement)
            XCTAsyncAssert(AnimalGallery.squirrel.animalElement)
            XCTAsyncAssert(AnimalGallery.turtle.animalElement)
        }
    }

    func andThenTheFilteredCountIsTwo() {
        XCTContext.runActivity(named: "Then the filtered count is 2") { _ in
            XCTAssertTrue(FilterAnimalsScreen.filterButton.element.label.contains("2"))
        }
    }

    func whenNoFiltersAreAppliedTheClearAllButtonIsDisabled() {
        XCTContext.runActivity(named: "When no filters are applied the Clear All button is disabled") { _ in
            XCTAssertFalse(FilterAnimalsScreen.clearAllButton.element.isEnabled)
        }
    }

    func whenAFilterIsAppliedTheClearAllButtonIsEnabled() {
        XCTContext.runActivity(named: "When a filter is applied the Clear All button is enabled") { _ in
            XCTAsyncAssert(FilterAnimalsScreen.filterRockpool.element)
            FilterAnimalsScreen.filterRockpool.element.tap()
            XCTAssertTrue(FilterAnimalsScreen.clearAllButton.element.isEnabled)
        }
    }

    func whenClearAllButtonIsTapped() {
        XCTContext.runActivity(named: "When the Clear All button is tapped") { _ in
            FilterAnimalsScreen.clearAllButton.element.tap()
        }
    }

    func thenAllFiltersAreRemoved() {
        XCTContext.runActivity(named: "Then all filters are removed") { _ in
            let filterPropertiesList = XCUIApplication().tables.firstMatch.cells.allElementsBoundByIndex
            var selectedCount = 0
            for filterProperty in filterPropertiesList {
                if filterProperty.isSelected {
                    selectedCount += 1
                }
            }

            XCTAssertEqual(selectedCount, 0)
        }
    }
}
