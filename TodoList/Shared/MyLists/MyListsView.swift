//
//  MyListsView.swift
//  TodoList
//
//  Created by alex.zarr on 2/11/21.
//

import SwiftUI

struct MyListsView: View {
    @StateObject var viewModel = MyListsViewModel()
    
    @State private var isShowingAddNew = false
    
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
            .navigationBarItems(trailing: addNewButton)
        }
        .sheet(isPresented: $isShowingAddNew, onDismiss: {
            viewModel.fetchLists()
        }) {
            NewListView()
        }
        .onAppear {
            viewModel.fetchLists()
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

struct MyListsView_Previews: PreviewProvider {
    static var viewModel: MyListsViewModel {
        MyListsViewModel(dataManager: MockDataManager())
    }
    static var previews: some View {
        MyListsView(viewModel: viewModel)
    }
}
