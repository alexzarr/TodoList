//
//  TLList.swift
//  TodoList
//
//  Created by alex.zarr on 2/11/21.
//

import Foundation

struct TLList {
    var id = UUID()
    var title: String
    var tasks: [TLTask] = []
    var addedOn = Date()
}

// MARK: - Identifiable
extension TLList: Identifiable { }
