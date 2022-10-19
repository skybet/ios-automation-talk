//
//  AutomationAnimalsBaseClass.swift
//  AutomationAnimalsUITests
//
//  Created by Poornima Suraj on 09/09/2022.
//

import XCTest

class AutomationAnimalsBaseClass: XCTestCase {

    let app = XCUIApplication()
    let timeOut = 2.0

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func XCTAsyncAssert(_ element: XCUIElement?) {
        guard let element = element else {
            XCTFail("Element is nil")
            return
        }
        let isElementExist = element.waitForExistence(timeout: timeOut)
        XCTAssertTrue(isElementExist)
    }

    func XCTWaitUntil_EitherElementPresent(_ element: XCUIElement?, _ element2: XCUIElement?) {
        guard let element = element, let element2 = element2 else {
            XCTFail("Element is nil")
            return
        }
        for _ in 1...10 {
            if ((element.exists) || (element2.exists)) {
                return
            }
        }
        XCTFail("App did not load as expected")
    }

    func XCTAsyncAssertElementDoesNotExist(_ element: XCUIElement?) {
        guard let element = element else {
            return
        }
        let isElementExist = element.waitForExistence(timeout: timeOut)
        XCTAssertFalse(isElementExist)
    }

}
