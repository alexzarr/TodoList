//
//  TLTask.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation

struct TLTask {
    var id = UUID()
    var title: String
    var isCompleted = false
    var list: TLList?
    var addedOn = Date()
}

// MARK: - Identifiable
extension TLTask: Identifiable { }

// MARK: - Hashable
extension TLTask: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
