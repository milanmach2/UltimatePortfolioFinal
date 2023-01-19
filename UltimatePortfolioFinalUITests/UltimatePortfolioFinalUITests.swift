//
//  UltimatePortfolioFinalUITests.swift
//  UltimatePortfolioFinalUITests
//
//  Created by Milan Mach on 18.01.2023.
//

import XCTest

final class UltimatePortfolioFinalUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    func testHas4Tabs() throws {
        // UI tests must launch the application that they test.
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs in the app")
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testOpenTabsAddProjects() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.cells.count, 0, "There should be 0 cell rows initially")
        for tapCount in 1 ... 6 {
            let accordianButtonsQuery = self.app.buttons.matching(identifier: "Add Project")
                if accordianButtonsQuery.count > 0 {
                    let firstButton = accordianButtonsQuery.element(boundBy: 0)
                    firstButton.tap()
                }
            //app.buttons["Add Project"].tap()
            print("helooooooo\(tapCount)")
            XCTAssertEqual(app.cells.count, tapCount*2, "There should be \(tapCount*2) cell rows initially")
        }
    }
    func testAddingItemsInsertsRows() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.cells.count, 0, "There should be 0 cell rows initially")
        let accordianButtonsQuery = self.app.buttons.matching(identifier: "Open")
            if accordianButtonsQuery.count > 0 {
                let firstButton = accordianButtonsQuery.element(boundBy: 0)
                firstButton.tap()
            }
        app.buttons["Open"].tap()
        XCTAssertEqual(app.cells.count, 0, "There should be 0 cell rows initially")
        let accordianButtonsQuery2 = self.app.buttons.matching(identifier: "Add Project")
            if accordianButtonsQuery2.count > 0 {
                let firstButton2 = accordianButtonsQuery2.element(boundBy: 0)
                firstButton2.tap()
            }
        //app.buttons["add"].tap()
        XCTAssertEqual(app.cells.count, 2, "There should be 2 cell rows initially - one Project")
        let accordianButtonsQuery3 = self.app.buttons.matching(identifier: "COMPOSE22")
        if accordianButtonsQuery3.count > 0 {
            let firstButton3 = accordianButtonsQuery3.element(boundBy: 0)
            firstButton3.tap()
        }
        //app.buttons["COMPOSE"].tap()
        app.buttons["Add Item"].tap()
        XCTAssertEqual(app.cells.count, 3, "There should be 3 cell rows initially")
    }
    func testEditingItemUpdateCorrectly() {
        // Go to Open Projects and add a new one and add one item before the test
        testAddingItemsInsertsRows()
        app.buttons["New Item"].tap()
        app.textFields["New Item"].tap()
        app.keys["space"].tap()
        app.keys["more"].tap()
        app.keys["2"].tap()
        app.buttons["Return"].tap()
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.buttons["New Item 2"].exists, "The newv Project name should be visible on the list.")
    }
    func testEditingProjectUpdateCorrectly() {
        app.buttons["Open"].tap()
        XCTAssertEqual(app.cells.count, 0, "There should be 0 cell rows initially")
        app.buttons["Add Project"].tap()
        XCTAssertEqual(app.cells.count, 2, "There should be 2 cell rows initially - one Project")
        // app.buttons["Add New Item"].tap()
        app.buttons["COMPOSE"].tap()
        app.textFields["New Project"].tap()
        app.keys["space"].tap()
        app.keys["more"].tap()
        app.keys["3"].tap()
        app.buttons["Return"].tap()
        app.buttons["Open Projects"].tap()
        XCTAssertTrue(app.staticTexts["New Project 3"].exists, "The New Project name should be visible on the list.")
    }
    func testAllAwardsShowLockedAlert() {
        app.buttons["Awards"].tap()
        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be locked Alert for all awards")
            app.buttons["OK"].tap()
        }
    }

}
























