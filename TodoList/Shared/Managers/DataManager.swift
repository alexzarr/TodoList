//
//  DataManager.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation
import CoreData

protocol TaskDataManagerProtocol {
    func fetchTaskList(for list: TLList?, includingCompleted: Bool) -> [TLTask]
    func addTask(title: String, to list: TLList?)
    func toggleIsCompleted(for task: TLTask)
}

extension TaskDataManagerProtocol {
    func fetchTaskList(for list: TLList? = nil, includingCompleted: Bool = false) -> [TLTask] { fetchTaskList(for: list, includingCompleted: includingCompleted) }
    func addTask(title: String, to list: TLList? = nil) { addTask(title: title, to: list) }
}

protocol ListDataManagerProtocol {
    func fetchLists() -> [TLList]
    func addList(title: String)
}

typealias DataManagerProtocol = TaskDataManagerProtocol & ListDataManagerProtocol

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    
    private var dbHelper: CoreDataHelper = .shared
    
    private init() { }
    
    private func fetchTaskEntity(for task: TLTask) -> TaskEntity? {
        let predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        let result = dbHelper.readFirst(TaskEntity.self, predicate: predicate)
        switch result {
        case .success(let taskEntity):
            return taskEntity
        case .failure:
            return nil
        }
    }
    
    private func fetchListEntity(for list: TLList) -> ListEntity? {
        let predicate = NSPredicate(format: "id == %@", argumentArray: [list.id])
        let result = dbHelper.readFirst(ListEntity.self, predicate: predicate)
        switch result {
        case .success(let entity):
            return entity
        case .failure:
            return nil
        }
    }
}

// MARK: - TaskDataManagerProtocol
extension DataManager: TaskDataManagerProtocol {
    func fetchTaskList(for list: TLList? = nil, includingCompleted: Bool = false) -> [TLTask] {
        var predicates: [NSPredicate] = []
        if let listId = list?.id {
            predicates.append(NSPredicate(format: "list.id == %@", argumentArray: [listId]))
        }
        if !includingCompleted {
            predicates.append(NSPredicate(format: "isCompleted == false"))
        }
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let result: Result<[TaskEntity], Error> = dbHelper.read(TaskEntity.self, predicate: predicate, limit: nil)
        switch result {
        case .success(let taskEntities):
            return taskEntities.map { $0.convertToTLTask() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addTask(title: String, to list: TLList? = nil) {
        let entity = TaskEntity.entity()
        let newTask = TaskEntity(entity: entity, insertInto: dbHelper.context)
        newTask.id = UUID()
        newTask.title = title
        newTask.addedOn = Date()
        if let list = list, let listEntity = fetchListEntity(for: list) {
            newTask.list = listEntity
        }
        dbHelper.create(newTask)
    }
    
    func toggleIsCompleted(for task: TLTask) {
        guard let taskEntity = fetchTaskEntity(for: task) else { return }
        taskEntity.isCompleted.toggle()
        dbHelper.update(taskEntity)
    }
}

// MARK: - ListDataManagerProtocol
extension DataManager: ListDataManagerProtocol {
    func fetchLists() -> [TLList] {
        let result: Result<[ListEntity], Error> = dbHelper.read(ListEntity.self, predicate: nil, limit: nil)
        switch result {
        case .success(let listEntities):
            return listEntities.map { $0.convertToTLList() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addList(title: String) {
        let entity = ListEntity.entity()
        let newList = ListEntity(entity: entity, insertInto: dbHelper.context)
        newList.id = UUID()
        newList.title = title
        newList.addedOn = Date()
        newList.tasks = Set()
        dbHelper.create(newList)
    }
}
