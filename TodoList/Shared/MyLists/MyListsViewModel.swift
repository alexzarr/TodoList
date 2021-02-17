//
//  MyListsViewModel.swift
//  TodoList
//
//  Created by alex.zarr on 2/11/21.
//

import Foundation
import Combine

protocol MyListsViewModelProtocol {
    var lists: [TLList] { get }
    func fetchLists()
    func delete(at indexSet: IndexSet)
}

final class MyListsViewModel: ObservableObject {
    @Published var lists: [TLList] = []
    
    private let dataManager: ListDataManagerProtocol
    
    init(dataManager: ListDataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

// MARK: - MyListsViewModelProtocol
extension MyListsViewModel: MyListsViewModelProtocol {
    func fetchLists() {
        lists = dataManager.fetchLists()
    }
    
    func delete(at indexSet: IndexSet) {
        for index in indexSet {
            dataManager.delete(list: lists[index])
        }
        fetchLists()
    }
}
