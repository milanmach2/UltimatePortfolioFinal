//
//  AwardsView.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject var dataController: DataController
    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false
    static let tag: String? = "Awards"
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(
                                    dataController.hasEarned(
                                        award: award
                                    ) ? Color(
                                        award.color
                                    ) : Color.secondary.opacity(0.5)
                                )
                        }
                        .accessibilityLabel(
                            Text(dataController.hasEarned(award: award) ? "Unlocked: \(award.name)" : "Locked")
                        )
                        .accessibilityHint(Text(award.description))
                    }
                }
            }
            .navigationTitle("Awards")
        }
        .alert(isPresented: $showingAwardDetails) {
            if dataController.hasEarned(award: selectedAward) {
                return Alert(
                    title: Text(
                        "Unlocked: \(selectedAward.name)"),
                    message: Text(
                        selectedAward.description),
                    dismissButton: .default(Text("OK")))
            } else {
                return Alert(
                    title: Text("Locked"),
                    message: Text(selectedAward.description),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}

// Paul Hudson doesnt recommend this approach
extension AwardsView {
    class ViewModel: ObservableObject {
        let dataController: DataController

        init(dataController: DataController) {
            self.dataController = dataController
        }

        func color(for award: Award) -> String? {
            dataController.hasEarned(award: award) ? award.color : nil
        }

        func label(for award: Award) -> String {
            dataController.hasEarned(award: award) ? "Unlocked: \(award.name)" : "Locked"
        }

        func hasEarned(award: Award) -> Bool {
            dataController.hasEarned(award: award)
        }
    }
}
