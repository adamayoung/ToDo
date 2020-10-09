//
//  ItemList.swift
//  ToDo
//
//  Created by Adam Young on 05/10/2020.
//

import CoreData
import SwiftUI

struct ItemList: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                ItemRow(item: item, onToggleCompleted: toggleCompleted, onEndEditing: save)
            }
            .onDelete(perform: deleteItems)
        }
        .disabled(items.isEmpty)
        .overlay(Group {
            if items.isEmpty {
                emptyListView
            }
        })
        .navigationTitle("To Do List")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus.circle")
                }
            }
        }
    }

    private var emptyListView: some View {
        VStack(spacing: 20) {
            Text("🎉")
                .font(.largeTitle)

            Text("You're all caught up!")
                .foregroundColor(.secondary)
        }
    }

}

extension ItemList {

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = "New item"
            newItem.timestamp = Date()
            save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            save()
        }
    }

    private func toggleCompleted(item: Item) {
        withAnimation {
            item.isComplete.toggle()
            save()
        }
    }

    private func save() {
        try? viewContext.save()
    }

}

struct ItemList_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ItemList()
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }

}
