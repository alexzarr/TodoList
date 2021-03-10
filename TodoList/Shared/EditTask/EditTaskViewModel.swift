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
    
    var lists: [TLList] = []
    var selectedListIndex = 0 {
        didSet {
            guard selectedListIndex < lists.count else { return }
            list = lists[selectedListIndex]
        }
    }
    
    private var task: TLTask
    
    private let dataManager: DataManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(task: TLTask, dataManager: DataManagerProtocol = DataManager.shared) {
        self.task = task
        self.dataManager = dataManager
        title = task.title
        list = task.list
        updateLists()
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
        $list
            .removeDuplicates()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .sink { [weak self] list in
                guard let self = self else { return }
                self.task.list = list
                self.dataManager.update(task: self.task)
            }
            .store(in: &cancellables)
    }
    
    private func updateLists() {
        lists = dataManager.fetchLists()
        if let index = lists.firstIndex(where: { $0.id == list?.id }) {
            selectedListIndex = index
        }
    }
}

// MARK: - EditTaskViewModelProtocol
extension EditTaskViewModel: EditTaskViewModelProtocol { }
