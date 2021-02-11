//
//  DataManager.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation
import CoreData

protocol TaskDataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool) -> [TLTask]
    func addTask(title: String)
    func toggleIsCompleted(for task: TLTask)
}

extension TaskDataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool = false) -> [TLTask] { fetchTaskList(includingCompleted: includingCompleted) }
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
}

// MARK: - TaskDataManagerProtocol
extension DataManager: TaskDataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool) -> [TLTask] {
        let predicate = includingCompleted ? nil : NSPredicate(format: "isCompleted == false")
        let result: Result<[TaskEntity], Error> = dbHelper.read(TaskEntity.self, predicate: predicate, limit: nil)
        switch result {
        case .success(let taskEntities):
            return taskEntities.map { $0.convertToTLTask() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func addTask(title: String) {
        let entity = TaskEntity.entity()
        let newTask = TaskEntity(entity: entity, insertInto: dbHelper.context)
        newTask.id = UUID()
        newTask.title = title
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
        []
    }
    
    func addList(title: String) {
        //
    }
}
