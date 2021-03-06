//
//  TaskListView.swift
//  TodoList
//
//  Created by alex.zarr on 1/25/21.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewModel
    
    @State private var isShowingAddNew = false
    
    var body: some View {
        Group {
            if viewModel.tasks.isEmpty {
                VStack(spacing: 12.0) {
                    Text("No Tasks")
                    Button(action: {
                        isShowingAddNew = true
                    }, label: {
                        Text("Start by adding a new task")
                    })
                }
            } else {
                List {
                    ForEach(viewModel.tasks) { task in
                        NavigationLink(
                            destination: EditTaskView(viewModel: EditTaskViewModel(task: task))) {
                            TaskRow(task: task) {
                                viewModel.toggleIsCompleted(for: task)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .animation(.easeIn)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarItems(leading: showCompletedButton, trailing: addNewButton)
        .sheet(isPresented: $isShowingAddNew, onDismiss: {
            viewModel.fetchTasks()
        }) {
            NewTaskView(viewModel: .init(list: viewModel.list))
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
    
    private func deleteItem(at indexSet: IndexSet) {
        viewModel.delete(at: indexSet)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var viewModel: TaskListViewModel {
        TaskListViewModel(list: TLList(title: "Groceries"), dataManager: MockDataManager())
    }
    static var previews: some View {
        NavigationView {
            TaskListView(viewModel: viewModel)
                .navigationTitle(Text("Tasks"))
        }
    }
}
