//
//  PersistantStorage.swift
//  Pokemon
//
//  Created by Rahul Mayani on 13/07/21.
//

import Foundation
import CoreData

//SingleTon pattern
final class PersistantStorage {
    
    static let shared = PersistantStorage()
    
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
