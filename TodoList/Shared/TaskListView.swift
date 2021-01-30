//
//  TaskListView.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskListViewModel()
    
    @State private var isShowingAddNew = false
    
    var body: some View {
        NavigationView {
            List(viewModel.tasks) { task in
                Text(task.title)
            }
            .navigationTitle(Text("Tasks"))
            .navigationBarItems(trailing: addNewButton)
        }
        .sheet(isPresented: $isShowingAddNew, onDismiss: {
            viewModel.fetchTasks()
        }) {
            NewTaskView()
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    private var addNewButton: some View {
        Button(action: {
            isShowingAddNew = true
        }, label: {
            Image(systemName: "plus")
        })
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
