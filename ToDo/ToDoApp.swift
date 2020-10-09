//
//  ToDoApp.swift
//  ToDo
//
//  Created by Adam Young on 05/10/2020.
//

import SwiftUI

@main
struct ToDoApp: App {

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ItemList()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
