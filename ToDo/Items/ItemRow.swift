//
//  ItemRow.swift
//  ToDo
//
//  Created by Adam Young on 05/10/2020.
//

import SwiftUI

struct ItemRow: View {

    var item: Item
    var onToggleCompleted: (Item) -> Void
    var onEndEditing: () -> Void

    @State private var title = ""

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: item.isComplete ? "checkmark.circle.fill" : "circle")
                .renderingMode(.template)
                .imageScale(.large)
                .foregroundColor(item.isComplete ? .accentColor : .gray)
                .onTapGesture {
                    onToggleCompleted(item)
                }

            TextField("Title", text: $title, onCommit: onCommit)
                .font(.body)
        }
        .onAppear {
            title = item.title ?? ""
        }
    }

}

extension ItemRow {

    private func onCommit() {
        item.title = title
        onEndEditing()
    }

}

struct ItemRow_Previews: PreviewProvider {

    static var previews: some View {
        let item1 = Item(context: PersistenceController.preview.container.viewContext)
        item1.title = "Item Title"
        item1.timestamp = Date()

        let item2 = Item(context: PersistenceController.preview.container.viewContext)
        item2.title = "Item Title"
        item2.isComplete = true
        item2.timestamp = Date()


        return List {
            ItemRow(item: item1, onToggleCompleted: { _ in }, onEndEditing: { })
            ItemRow(item: item2, onToggleCompleted: { _ in }, onEndEditing: { })
        }
    }

}
