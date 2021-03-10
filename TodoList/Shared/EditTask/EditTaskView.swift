//
//  EditTaskView.swift
//  TodoList
//
//  Created by alex.zarr on 3/4/21.
//

import SwiftUI

struct EditTaskView: View {
    @StateObject var viewModel: EditTaskViewModel
    
    @State private var showingListPicker = false
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $viewModel.title)
                Button {
                    showingListPicker.toggle()
                } label: {
                    HStack {
                        Text("List")
                        Spacer()
                        if let list = viewModel.list {
                            Text(list.title)
                        } else {
                            Text("No list")
                                .foregroundColor(.secondary)
                        }
                    }
                    .foregroundColor(.primary)
                }
                if showingListPicker {
                    Picker("Select a List", selection: $viewModel.selectedListIndex) {
                        ForEach(0..<viewModel.lists.count) { i in
                            Text(viewModel.lists[i].title)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
        }
        .navigationTitle("Details")
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var list: TLList {
        TLList(title: "Plan")
    }
    static var previews: some View {
        NavigationView {
            EditTaskView(viewModel: EditTaskViewModel(task: TLTask(title: "Buy groceries", list: list)))
        }
    }
}
