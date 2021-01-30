//
//  DataManager.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation

protocol DataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool) -> [TLTask]
    func addTask(title: String)
    func toggleIsCompleted(for task: TLTask)
}

extension DataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool = false) -> [TLTask] { fetchTaskList(includingCompleted: includingCompleted) }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    
    private var tasks: [TLTask] = []
    
    private init() { }
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func fetchTaskList(includingCompleted: Bool) -> [TLTask] {
        includingCompleted ? tasks : tasks.filter { !$0.isCompleted }
    }
    
    func addTask(title: String) {
        let task = TLTask(title: title)
        tasks.insert(task, at: 0)
    }
    
    func toggleIsCompleted(for task: TLTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}
