//
//  EditTaskViewModel.swift
//  TodoList
//
//  Created by alex.zarr on 3/4/21.
//

import Foundation
import Combine

protocol EditTaskViewModelProtocol {
    var title: String { get set }
}

final class EditTaskViewModel: ObservableObject {
    @Published var title = ""
    @Published var list: TLList?
    
    private var task: TLTask
    
    private let dataManager: TaskDataManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(task: TLTask, dataManager: TaskDataManagerProtocol = DataManager.shared) {
        self.task = task
        self.dataManager = dataManager
        title = task.title
        list = task.list
        
        subscribeToChanges()
    }
    
    private func subscribeToChanges() {
        $title
            .removeDuplicates()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] output in
                guard let self = self else { return }
                self.task.title = output
                self.dataManager.update(task: self.task)
            }
            .store(in: &cancellables)
    }
}

// MARK: - EditTaskViewModelProtocol
extension EditTaskViewModel: EditTaskViewModelProtocol { }
