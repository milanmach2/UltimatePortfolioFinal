//
//  DevelopementTest.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 17.01.2023.
//

import CoreData
import SwiftUI
import XCTest
@testable import UltimatePortfolioFinal

final class DevelopementTest: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "there should be 5 sample projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "there should be 50 sample items")
    }
    func testDeleteAllClearsEverything() throws {
        //try dataController.createSampleData()
        dataController.deleteAll()
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "there should be 0 sample projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "there should be 0 sample items")
    }
    func testExampleProjectIsClosed() {
        let project = Project.example
        XCTAssertTrue(project.closed, "example is closed by default")
    }
    func testExampleItemPriorityIsHigh() {
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "example priority is 3 by default")
    }
}
