//
//  NotePresistentManager.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/12.
//

import Foundation
import CoreData

class NotePersistentManager {
    let persistentContainer: NSPersistentContainer
    static let shared: NotePersistentManager = NotePersistentManager()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NoteDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Initial core data failed \(error)")
            }
            
            
        }
    }
    
}
