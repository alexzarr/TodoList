//
//  MockDataManager.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation

class MockDataManager {
    private var tasks: [TLTask] = []
    
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
    }
}

// MARK: - DataManagerProtocol
extension MockDataManager: DataManagerProtocol {
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
