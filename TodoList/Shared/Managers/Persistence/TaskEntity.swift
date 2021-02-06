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
}

extension TaskEntity {
    func convertToTLTask() -> TLTask {
        TLTask(id: id ?? UUID(), title: title, isCompleted: isCompleted)
    }
}
