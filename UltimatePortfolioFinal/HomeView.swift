//
//  HomeView.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"
    @EnvironmentObject var dataController: DataController
    var body: some View {
           NavigationView {
               VStack {
                   Button("Add Data") {
                       dataController.deleteAll()
                       try? dataController.createSampleData()
                   }
               }
               .navigationTitle("HomeFinal")
           }
       }
   }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
