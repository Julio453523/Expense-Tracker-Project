//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by Ricky Truckner on 11/22/23.
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
