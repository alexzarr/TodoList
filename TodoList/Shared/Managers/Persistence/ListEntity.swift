//
//  ListEntity.swift
//  TodoList
//
//  Created by alex.zarr on 2/12/21.
//

import Foundation
import CoreData

@objc(ListEntity)
final class ListEntity: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var title: String
    @NSManaged var addedOn: Date
    @NSManaged var tasks: Set<TaskEntity>
}

extension ListEntity {
    func convertToTLList() -> TLList {
        var list = TLList(id: id ?? UUID(), title: title, tasks: [], addedOn: addedOn)
        let tasks = Array(self.tasks.map { $0.convertToTLTask(list: list) })
        list.tasks = tasks
        return list
    }
}
