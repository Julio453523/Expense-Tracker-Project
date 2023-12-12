//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//

import SwiftUI

@main
struct BudgetTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
