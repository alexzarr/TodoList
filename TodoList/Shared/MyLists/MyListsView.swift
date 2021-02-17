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
    
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.lists) { list in
                    NavigationLink(
                        destination: TaskListView(viewModel: .init(list: list)),
                        label: {
                            MyListsRow(list: list)
                        })
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle(Text("Lists"))
            .navigationBarItems(trailing: addNewButton)
            .alert(item: $indexSetToDelete) { indexSet in
                Alert(title: Text("Are you sure want to remove this list?"),
                      primaryButton: .destructive(Text("Delete"), action: {
                        viewModel.delete(at: indexSet)
                      }),
                      secondaryButton: .cancel())
            }
            .onAppear {
                viewModel.fetchLists()
            }
        }
        .sheet(isPresented: $isShowingAddNew, onDismiss: {
            viewModel.fetchLists()
        }) {
            NewListView()
        }
    }
    
    private var addNewButton: some View {
        Button(action: {
            isShowingAddNew = true
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        indexSetToDelete = indexSet
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
