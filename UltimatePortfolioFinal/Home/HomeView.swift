//
//  HomeView.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    static let tag: String? = "Home"
    @StateObject var viewModel: ViewModel
    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: projectRows) {
                            ForEach(viewModel.projects, content: ProjectSummaryView.init)
                        } // lazyhgrid
                        .padding([.horizontal, .top])
                        .fixedSize(horizontal: false, vertical: true)
                    } // scrollview
                    VStack(alignment: .leading) {
                        ItemListView(title: "Up next", items: viewModel.upNext)
                        ItemListView(title: "More to explore", items: viewModel.moreToExplore)
                    }
                    .padding(.horizontal)
                } // vstack
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("HomeFinal")
            .toolbar {
                Button("Add Data", action: viewModel.addSampleData)
                Button("Delete All", action: viewModel.dataController.deleteAll)
            }
        }
       }
   }
// Button("Add Data") {
//     dataController.deleteAll()
//     try? dataController.createSampleData()
// }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: .preview)
    }
}
