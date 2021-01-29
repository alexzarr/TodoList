//
//  TaskListView.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.tasks) { task in
                Text(task.title)
            }
            .navigationTitle(Text("Tasks"))
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var viewModel: TaskListViewModel {
        TaskListViewModel(dataManager: MockDataManager())
    }
    static var previews: some View {
        TaskListView(viewModel: viewModel)
    }
}
