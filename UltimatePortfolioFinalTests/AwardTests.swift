//
//  AwardTests.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 18.01.2023.
//

import CoreData
import XCTest
@testable import UltimatePortfolioFinal

final class AwardTests: BaseTestCase {
    let awards = Award.allAwards
    func testAwardIdMathesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award name should always match")
        }
    }
    func testNewUserHasNoAwards() {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "No award should be reached")
        }
    }
    func testItemAwards() throws {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                _ = Item(context: managedObjectContext)
            }
            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }
            XCTAssertEqual(matches.count, count + 1, "Adding \(value) items should unlock \(count + 1) awards.")
            dataController.deleteAll()
        }
    }
    func testCompletingItems() throws {
        let values = [1, 10, 20, 50, 100, 250, 500, 1000]
        for (count, value) in values.enumerated() {
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }
            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }
            XCTAssertEqual(matches.count, count + 1, "Completing \(value) items should unlock \(count + 1) awards.")
            dataController.deleteAll()
        }
    }
}
