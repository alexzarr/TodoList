//
//  MockDataManager.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation

class MockDataManager {
    private var tasks: [TLTask] = []
    
    private var lists: [TLList] = []
    
    init() {
        tasks = [
            TLTask(id: UUID(), title: "Morning workout", isCompleted: false),
            TLTask(id: UUID(), title: "Sign documents", isCompleted: false),
            TLTask(id: UUID(), title: "Check email", isCompleted: true),
            TLTask(id: UUID(), title: "Call boss", isCompleted: false),
            TLTask(id: UUID(), title: "Buy groceries", isCompleted: false),
            TLTask(id: UUID(), title: "Finish article", isCompleted: true),
            TLTask(id: UUID(), title: "Pay bills", isCompleted: true),
        ]
        
        let listNames = ["Groceries", "Things To Do", "Vacation Plans"]
        for name in listNames {
            let listTasks = Array(tasks.prefix((0...tasks.count).randomElement()!))
            lists.append(TLList(title: name, tasks: listTasks))
        }
    }
}

// MARK: - TaskDataManagerProtocol
extension MockDataManager: TaskDataManagerProtocol {
    func fetchTaskList(for list: TLList? = nil, includingCompleted: Bool) -> [TLTask] {
        includingCompleted ? tasks : tasks.filter { !$0.isCompleted }
    }
    
    func addTask(title: String, to list: TLList? = nil) {
        let task = TLTask(title: title)
        tasks.insert(task, at: 0)
    }
    
    func toggleIsCompleted(for task: TLTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func delete(task: TLTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    func update(task: TLTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
}

extension MockDataManager: ListDataManagerProtocol {
    func fetchLists() -> [TLList] {
        lists
    }
    
    func addList(title: String) {
        let list = TLList(title: title)
        lists.insert(list, at: 0)
    }
    
    func delete(list: TLList) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists.remove(at: index)
        }
    }
}
