//
//  Devote_MainApp.swift
//  Devote_Main
//
//  Created by Arjun Prabhune on 10/25/23.
//

import SwiftUI

@main
struct Devote_MainApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
