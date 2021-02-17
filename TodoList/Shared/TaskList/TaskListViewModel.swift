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
    func delete(at indexSet: IndexSet)
}

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TLTask] = []
    @Published var showCompleted = false {
        didSet {
            fetchTasks()
        }
    }
    var title: String { list.title }
    
    let list: TLList
    private let dataManager: TaskDataManagerProtocol
    
    init(list: TLList, dataManager: TaskDataManagerProtocol = DataManager.shared) {
        self.list = list
        self.dataManager = dataManager
        fetchTasks()
    }
}

// MARK: - TaskListViewModelProtocol
extension TaskListViewModel: TaskListViewModelProtocol {
    func fetchTasks() {
        tasks = dataManager.fetchTaskList(for: list, includingCompleted: showCompleted)
    }
    
    func toggleIsCompleted(for task: TLTask) {
        dataManager.toggleIsCompleted(for: task)
        fetchTasks()
    }
    
    func delete(at indexSet: IndexSet) {
        for index in indexSet {
            dataManager.delete(task: tasks[index])
        }
        fetchTasks()
    }
}
