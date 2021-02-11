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
        List(viewModel.tasks) { task in
            Button(action: {
                viewModel.toggleIsCompleted(for: task)
            }) {
                TaskRow(task: task)
            }
        }
        .animation(.easeIn)
        .navigationTitle(Text("Tasks"))
        .navigationBarItems(leading: showCompletedButton, trailing: addNewButton)
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
    
    private var showCompletedButton: some View {
        Button (action: {
            viewModel.showCompleted.toggle()
        }) {
            Image(systemName: viewModel.showCompleted ? "text.justify" : "text.badge.checkmark")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var viewModel: TaskListViewModel {
        TaskListViewModel(dataManager: MockDataManager())
    }
    static var previews: some View {
        NavigationView {
            TaskListView(viewModel: viewModel)
                .navigationTitle(Text("Tasks"))
        }
    }
}
