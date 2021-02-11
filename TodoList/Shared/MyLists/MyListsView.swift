//
//  MyListsView.swift
//  TodoList
//
//  Created by alex.zarr on 2/11/21.
//

import SwiftUI

struct MyListsView: View {
    @StateObject var viewModel = MyListsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.lists) { list in
                NavigationLink(
                    destination: TaskListView(),
                    label: {
                        MyListsRow(list: list)
                    })
            }
            .navigationTitle(Text("Lists"))
        }
        .onAppear {
            viewModel.fetchLists()
        }
    }
}

struct MyListsView_Previews: PreviewProvider {
    static var viewModel: MyListsViewModel {
        MyListsViewModel(dataManager: MockDataManager())
    }
    static var previews: some View {
        MyListsView(viewModel: viewModel)
    }
}
