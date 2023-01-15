//
//  UltimatePortfolioFinalApp.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI

@main
struct UltimatePortfolioFinalApp: App {
    @StateObject var dataController: DataController
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)// for SwiftUI
                    .environmentObject(dataController)// our own code

        }
    }
}
