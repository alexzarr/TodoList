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
    func delete(list: TLList)
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
    
    func delete(list: TLList) {
        dataManager.delete(list: list)
        fetchLists()
    }
}
