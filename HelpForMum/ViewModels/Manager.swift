//
//  Manager.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//
// Это класс, который работает напрямую с CoreData

import Foundation
import CoreData

class DataManager {
    static let instance = DataManager() //Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() { // загрузка данных из базы
        container = NSPersistentContainer(name: "DataContainer3")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    func search() {
    }
    
    func save() { // Сохранение изменений в базе данных
        do {
            try context.save()
            print("Saved succesfully!!")
        }
        catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
    
}
