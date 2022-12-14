//
//  ZhaoCiApp.swift
//  Shared
//
//  Created by Jiaxiang Li on 2022/7/22.
//

import SwiftUI

@main
struct ZhaoCiApp: App {
    
    let persistentContainer = NotePersistentManager.shared.persistentContainer
    var body: some Scene {
        WindowGroup {
            HomeView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
