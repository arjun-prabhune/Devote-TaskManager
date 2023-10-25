//
//  Persistence.swift
//  Devote_Main
//
//  Created by Arjun Prabhune on 10/25/23.
//

import CoreData

struct PersistenceController {
    
    // MARK: - 1. Persistent Controller
    static let shared = PersistenceController()
    
    // MARK: - 2. Persistent Container
    let container: NSPersistentContainer

    
    // MARK: - 3. Initialization (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote_Main")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - 4. Preview
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
