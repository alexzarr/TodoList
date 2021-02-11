//
//  NewTaskViewModel.swift
//  TodoList
//
//  Created by alex.zarr on 1/30/21.
//

import Foundation
import Combine

protocol NewTaskViewModelProtocol {
    func addNewTask(title: String)
}

final class NewTaskViewModel: ObservableObject {
    private var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

// MARK: - NewTaskViewModelProtocol
extension NewTaskViewModel: NewTaskViewModelProtocol {
    func addNewTask(title: String) {
        dataManager.addTask(title: title)
    }
}
