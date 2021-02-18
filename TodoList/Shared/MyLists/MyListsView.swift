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
    
    @AppStorage("hasGridAppearance") private var hasGridAppearance = true
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.lists.isEmpty {
                    VStack(spacing: 12.0) {
                        Text("No Lists")
                        Button(action: {
                            isShowingAddNew = true
                        }, label: {
                            Text("Start by adding a new list")
                        })
                    }
                } else {
                    if hasGridAppearance {
                        gridView
                    } else {
                        listView
                    }
                }
            }
            .navigationTitle(Text("Lists"))
            .navigationBarItems(leading: toggleAppearanceButton, trailing: addNewButton)
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
    
    private var listView: some View {
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
    }
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.0) {
                ForEach(viewModel.lists) { list in
                    NavigationLink(
                        destination: TaskListView(viewModel: .init(list: list)),
                        label: {
                            MyListsItem(list: list)
                        })
                }
            }
            .padding()
        }
    }
    
    private var addNewButton: some View {
        Button(action: {
            isShowingAddNew = true
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private var toggleAppearanceButton: some View {
        Button(action: {
            hasGridAppearance.toggle()
        }, label: {
            Image(systemName: hasGridAppearance ? "text.justify" : "rectangle.grid.2x2.fill")
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
