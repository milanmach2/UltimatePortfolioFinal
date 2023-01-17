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
                .environment(\.managedObjectContext, dataController.container.viewContext) // for SwiftUI
                    .environmentObject(dataController) // for us - our own code
                    .onReceive(
                        // Automatically save when we detect that we are
                        // no longer the foreground app. Use this rather than
                        // scene phase so we can port to macOS, where scene
                        // phase won't detect our app losing focus.
                        NotificationCenter.default.publisher(
                        for: UIApplication.willResignActiveNotification),
                               perform: save) // trggered by Notification
        }
    }
    func save(_ note: Notification) {
        dataController.save() // our own code changes All Data in Store - Hard Disc
    }
}
