//
//  HomeViewModel.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 20.01.2023.
//

import CoreData
import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        private let projectsController: NSFetchedResultsController<Project>
        private let itemsController: NSFetchedResultsController<Item>
        @Published var projects = [Project]()
        @Published var items = [Item]()
        var upNext: ArraySlice<Item> {
            items.prefix(3)
        }
        var moreToExplore: ArraySlice<Item> {
            items.dropFirst(3)
        }
        var dataController: DataController
        init(dataController: DataController) {
            self.dataController = dataController
            // construct a fetchRequest to show all closed projects
            let projectRequest: NSFetchRequest<Project> = Project.fetchRequest()
            projectRequest.predicate = NSPredicate(format: "closed = false")
            projectRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Project.title, ascending: true)]
            projectsController = NSFetchedResultsController(
                fetchRequest: projectRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            // construct a fetchRequest to show 10 highest priority incomplete items
            let itemsRequest: NSFetchRequest<Item> = Item.fetchRequest()
            let completedPredicate = NSPredicate(format: "completed = false")
            let openPredicate = NSPredicate(format: "project.closed = false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [completedPredicate, openPredicate])
            itemsRequest.predicate = compoundPredicate
            itemsRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \Item.priority, ascending: false)
            ]
            itemsRequest.fetchLimit = 10
            itemsController = NSFetchedResultsController(
                fetchRequest: itemsRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            super.init()
            projectsController.delegate = self
            itemsController.delegate = self
            do {
                try itemsController.performFetch()
                try projectsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
                items = itemsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch initial data")
            }
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newItems = controller.fetchedObjects as? [Item] {
                items = newItems
            } else if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
        func addSampleData() {
            dataController.deleteAll()
            try? dataController.createSampleData()
        }
    }
}
