//
//  NewListView.swift
//  TodoList
//
//  Created by alex.zarr on 2/12/21.
//

import SwiftUI

struct NewListView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel = NewListViewModel()
    
    @State private var title = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("List Name", text: $title)
                .padding(.vertical)
            Spacer()
            HStack(spacing: 10.0) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .padding(.vertical, 8.0)
                        .padding(.horizontal, 16.0)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(8.0)
                        .shadow(color: .secondary, radius: 3, x: 0.0, y: 0.0)
                }
                
                Button(action: {
                    if !title.isEmpty {
                        viewModel.addNewList(title: title)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add")
                        .padding(.vertical, 8.0)
                        .padding(.horizontal, 16.0)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(8.0)
                        .shadow(color: .secondary, radius: 3, x: 0.0, y: 0.0)
                }
                
            }
        }
        .padding()
    }
}

struct NewListView_Previews: PreviewProvider {
    static var viewModel: NewListViewModel {
        NewListViewModel(dataManager: MockDataManager())
    }
    static var previews: some View {
        NewListView(viewModel: viewModel)
    }
}
