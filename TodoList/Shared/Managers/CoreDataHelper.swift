//
//  CoreDataHelper.swift
//  TodoList
//
//  Created by alex.zarr on 2/3/21.
//

import Foundation
import CoreData

final class CoreDataHelper {
    typealias DBObject = NSManagedObject
    typealias DBPredicate = NSPredicate
    
    static let shared = CoreDataHelper()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "TodoList")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataHelper: DBHelper {
    func create(_ object: NSManagedObject) {
        <#code#>
    }
    
    func read(_ objectType: NSManagedObject.Type, predicate: NSPredicate?, limit: Int?) -> Result<[NSManagedObject], Error> {
        <#code#>
    }
    
    func readFirst(_ objectType: NSManagedObject.Type, predicate: NSPredicate?) -> Result<NSManagedObject?, Error> {
        <#code#>
    }
    
    func update(_ object: NSManagedObject) {
        <#code#>
    }
    
    func delete(_ object: NSManagedObject) {
        <#code#>
    }
}
