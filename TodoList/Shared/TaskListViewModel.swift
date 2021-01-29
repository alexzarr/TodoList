//
//  TaskListViewModel.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation
import Combine

protocol TaskListViewModelProtocol {
    var tasks: [TLTask] { get }
    var showCompleted: Bool { get set }
    func fetchTasks()
    func toggleIsCompleted(for task: TLTask)
}

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TLTask] = []
    @Published var showCompleted = false
    
    private let dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
        fetchTasks()
    }
}

// MARK: - TaskListViewModelProtocol
extension TaskListViewModel: TaskListViewModelProtocol {
    func fetchTasks() {
        tasks = dataManager.fetchTaskList(includingCompleted: showCompleted)
    }
    
    func toggleIsCompleted(for task: TLTask) {
        dataManager.toggleIsCompleted(for: task)
    }
}
