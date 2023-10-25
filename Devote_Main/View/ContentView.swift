//
//  ContentView.swift
//  Devote_Main
//
//  Created by Arjun Prabhune on 10/25/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - Property
    
    // Fetching Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    // MARK: - Function
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            NavigationView {
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            Text(item.timestamp!, formatter: itemFormatter)
                        }
                    }
                    .onDelete(perform: deleteItems)
                } //: LIST
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
            } //: TOOLBAR
        } //: NAVIGATION
            Text("Select an item")
        }
    }

    
}




    // MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
