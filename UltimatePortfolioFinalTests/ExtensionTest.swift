//
//  ExtensionTest.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 17.01.2023.
//

import SwiftUI
import XCTest
@testable import UltimatePortfolioFinal

final class ExtensionTest: XCTestCase {
    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "the sorting items should be assending")
    }
    func testSequenceKeyPathSortingComparable() {
        struct Example: Equatable {
        let value: String
        }
        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        let array = [example1, example2, example3]
        let sortedArray = array.sorted(by: \.value) {
            $0 > $1
        }
        XCTAssertEqual(sortedArray, [example3, example2, example1], "Should be Reversed Order")
    }
    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }
    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTest.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards.",
                       "The string must match the content of DecodableString.json.")
    }
    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTest.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, " There should be 3")
        XCTAssertEqual(data["one"], 1, " There should be data mapping")
    }
    func testBindingOnChangeCallsFunction_Example() {
        // Given
        var onChangeFunctionRun = false
        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }
        var storedValue = ""
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )
        let changeBinding = binding.onChange(exampleFunctionToCall)
        // When
        changeBinding.wrappedValue = "Test"
        // Then
        XCTAssertTrue(onChangeFunctionRun, "the onChange() must run when the binding is changed")
    }
}
