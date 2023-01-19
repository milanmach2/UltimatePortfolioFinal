//
//  PerformanceTest.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 17.01.2023.
//

import SwiftUI
import XCTest
@testable import UltimatePortfolioFinal

class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() throws {
        // create a significant amount of data
        for _ in 1 ... 100 {
            try dataController.createSampleData()
        }
        // simulate lots of awards to check
        let awards =  Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(
            awards.count,
            500,
            "checks if the number of awards is constant change this if you add new award."
        )
        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
