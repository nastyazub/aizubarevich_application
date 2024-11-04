//
//  Manager.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//
// Осуществляет связь с контейнером(базой данных): сохранение, изменение, выгрузка данных.
// Функции:
/*
 1. Сохранение изменений в базе данных.
 */

import Foundation
import CoreData

class DataManager {
    
    static let instance = DataManager() //Синглтон
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    //Загрузка данных из базы
    init() {
        container = NSPersistentContainer(name: "DataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Ошибка загрузки Core Data. \(error)")
            }
        }
        
        context = container.viewContext
    }
    
    /// Сохранение изменения в базе данных
    func save() {
        do {
            try context.save()
            print("Успешно сохранено в контекст.")
        }
        catch let error {
            print("Ошибка сохранения Core Data. \(error.localizedDescription)")
        }
    }
    
}
