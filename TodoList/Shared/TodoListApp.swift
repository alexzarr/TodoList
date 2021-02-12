//
//  TodoListApp.swift
//  Shared
//
//  Created by alex.zarr on 1/25/21.
//

import SwiftUI

@main
struct TodoListApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var coreDataHelper = CoreDataHelper.shared
    
    var body: some Scene {
        WindowGroup {
            MyListsView()
                .environment(\.managedObjectContext, coreDataHelper.persistentContainer.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                coreDataHelper.saveContext()
            default: break
            }
        }
    }
}
