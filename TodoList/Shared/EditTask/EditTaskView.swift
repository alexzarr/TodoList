//
//  EditTaskView.swift
//  TodoList
//
//  Created by alex.zarr on 3/4/21.
//

import SwiftUI

struct EditTaskView: View {
    @StateObject var viewModel: EditTaskViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $viewModel.title)
                if let list = viewModel.list {
                    Text(list.title)
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
