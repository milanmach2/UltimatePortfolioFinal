//
//  UltimatePortfolioFinalTests.swift
//  UltimatePortfolioFinalTests
//
//  Created by Milan Mach on 17.01.2023.
//

import CoreData
import XCTest
@testable import UltimatePortfolioFinal

class BaseTestCase: XCTestCase {

    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
