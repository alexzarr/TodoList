//
//  TaskEntity.swift
//  TodoList
//
//  Created by alex.zarr on 2/4/21.
//

import Foundation
import CoreData

@objc(TaskEntity)
final class TaskEntity: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var title: String
    @NSManaged var isCompleted: Bool
    @NSManaged var addedOn: Date
    @NSManaged var list: ListEntity?
}

extension TaskEntity {
    func convertToTLTask(list: TLList?) -> TLTask {
        TLTask(id: id ?? UUID(), title: title, isCompleted: isCompleted, list: list, addedOn: addedOn)
    }
}
