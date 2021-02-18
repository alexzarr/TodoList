//
//  MyListsItem.swift
//  TodoList
//
//  Created by alex.zarr on 2/18/21.
//

import SwiftUI

struct MyListsItem: View {
    var list: TLList
    
    private var shadowColor: Color { Color(.gray) }
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(list.tasks.count)")
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            Text(list.title)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .topTrailing)
        .padding(.vertical, 12.0)
        .padding(.horizontal)
        .background(Color(.systemBackground))
        .cornerRadius(8.0)
        .shadow(color: shadowColor, radius: 3.0, x: 0.0, y: 0.0)
    }
}

struct MyListsItem_Previews: PreviewProvider {
    static var previews: some View {
        MyListsItem(list: TLList(title: "Groceries"))
    }
}
