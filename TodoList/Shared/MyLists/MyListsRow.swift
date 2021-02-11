//
//  MyListsRow.swift
//  TodoList
//
//  Created by alex.zarr on 2/11/21.
//

import SwiftUI

struct MyListsRow: View {
    var list: TLList
    
    var body: some View {
        HStack {
            Text(list.title)
            Spacer()
            Text("\(list.tasks.count)")
                .foregroundColor(.secondary)
        }
    }
}

struct MyListsRow_Previews: PreviewProvider {
    static var previews: some View {
        MyListsRow(list: TLList(title: "Groceries"))
            .previewLayout(.fixed(width: 300, height: 44))
    }
}
