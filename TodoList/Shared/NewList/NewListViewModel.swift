//
//  NewListViewModel.swift
//  TodoList
//
//  Created by alex.zarr on 2/12/21.
//

import Foundation
import Combine

protocol NewListViewModelProtocol {
    func addNewList(title: String)
}

final class NewListViewModel: ObservableObject {
    private var dataManager: ListDataManagerProtocol
    
    init(dataManager: ListDataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

// MARK: - NewListViewModelProtocol
extension NewListViewModel: NewListViewModelProtocol {
    func addNewList(title: String) {
        dataManager.addList(title: title)
    }
}
