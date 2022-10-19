//
//  FilterAnimalsTests.swift
//  AutomationAnimalsUITests
//
//  Created by Sanaa Shahzadi on 16/09/2022.
//

import Foundation

import XCTest

class FilterAnimalsTests: AutomationAnimalsBaseClass {
    func testFilterBottomSheet() {
        XCTExpectFailure("Intentional failure")
        givenAutomationAnimalsAppIsOpen()
        whenITapTheFilterButton()
        thenICanSeeTheFilterBottomSheet()
        whenITapDone()
        thenTheBottomSheetCloses()
    }

    func testFilterWithRockpoolAndSmall() {
        givenTheFilterBottomSheetIsOpen()
        whenIFilterOnRockpoolAndSmall()
        thenOnlyTheFilteredResultsAreDisplayed()
        andThenTheFilteredCountIsTwo()
    }

    func testFilterClearAll() {
        givenTheFilterBottomSheetIsOpen()
        whenNoFiltersAreAppliedTheClearAllButtonIsDisabled()
        whenAFilterIsAppliedTheClearAllButtonIsEnabled()
        whenClearAllButtonIsTapped()
        thenAllFiltersAreRemoved()
    }
}
