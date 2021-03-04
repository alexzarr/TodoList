//
//  TaskRow.swift
//  TodoList
//
//  Created by alex.zarr on 2/3/21.
//

import SwiftUI

struct TaskRow: View {
    let task: TLTask
    let checkmarkAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: checkmarkAction) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(task.isCompleted ? .blue : .primary)
            }
            .buttonStyle(PlainButtonStyle())
            Text(task.title)
                .foregroundColor(task.isCompleted ? .secondary : .primary)
            Spacer()
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRow(task: TLTask(title: "Buy groceries"), checkmarkAction: { })
                .preferredColorScheme(.dark)
            TaskRow(task: TLTask(title: "Check emails", isCompleted: true), checkmarkAction: { })
        }
        .previewLayout(.fixed(width: 300, height: 44))
    }
}
