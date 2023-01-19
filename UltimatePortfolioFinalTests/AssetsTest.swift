//
//  AssetsTest.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 18.01.2023.
//

import XCTest
@testable import UltimatePortfolioFinal
final class AssetsTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from Asset catalogue.")
        }
    }
    func testJsonLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from json.")
    }
}
