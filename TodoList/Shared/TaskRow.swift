//
//  TaskRow.swift
//  TodoList
//
//  Created by alex.zarr on 2/3/21.
//

import SwiftUI

struct TaskRow: View {
    var task: TLTask
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(task.isCompleted ? .blue : .primary)
            Text(task.title)
                .foregroundColor(task.isCompleted ? .secondary : .primary)
            Spacer()
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRow(task: TLTask(title: "Buy groceries"))
                .preferredColorScheme(.dark)
            TaskRow(task: TLTask(title: "Check emails", isCompleted: true))
        }
        .previewLayout(.fixed(width: 300, height: 44))
    }
}
