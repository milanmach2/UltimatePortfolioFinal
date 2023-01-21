//
//  ProjectHeaderView.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)

                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }

            Spacer()

            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)

            }
        }
        .padding(.bottom, 10)
        .accessibilityElement(children: .combine)
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}

// Paul Hudson doesnt recommend this approach
extension ProjectHeaderView {
    class ViewModel: ObservableObject {
        private let project: Project

        var title: String {
            project.projectTitle
        }

        var completionAmount: Double {
            project.completionAmount
        }

        var color: String {
            project.projectColor
        }

        init(project: Project) {
            self.project = project
        }
    }
}
