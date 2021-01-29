//
//  TLTask.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import Foundation

struct TLTask: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted = false
}
