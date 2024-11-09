//
//  HeightViewModel.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

// Класс взаимодействия со значениями роста.
// Функции:
/*
 1. Выгрузка значений роста из базы данных.
 2. Добавление значения роста в базу данных.
 3. Удаление значения роста из базы данных.
 4. Сохранение изменений значений роста в базу данных.
 */


import Foundation
import CoreData

@Observable class HeightViewModel {
    let manager = DataManager.instance
    var heights: [HeightEntity] = []
    
    //Загрузка данных
    init() {
        self.getHeights()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Выгрузка значений роста из базы данных.
    func getHeights() {
        let request = NSFetchRequest<HeightEntity>(entityName: "HeightEntity")
        
        do {
            heights = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга значений роста. \(error)")
        }
    }
    
    /// Добавление значения роста в базу данных.
    /// - Parameters:
    ///   - height: Рост ребёнка в сантиметрах.
    ///   - date: Дата измерения роста.
    func addHeight(height: Int, date: Date) {
        let request = NSFetchRequest<HeightEntity>(entityName: "HeightEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            heights = try manager.context.fetch(request)
            if heights.isEmpty {
                let newHeight = HeightEntity(context: manager.context)
                newHeight.id = UUID().uuidString
                newHeight.date = date
                newHeight.height = Int64(height)
                heights.append(newHeight)
                save()
            } else {
                heights[0].height = Int64(height)
                save()
                print("Рост изменён на \(height)")
            }
        } catch let error {
            print("Ошибка добавления роста. \(error)")
        }
    }
    
    // MARK: ПОКА УТОЧНЯЮ НЕОБХОДИМОСТЬ
    
    /// Удаление значения роста из базы данных.
    /// - Parameter height: Элемент базы данных (рост), который нужно удалить.
    func delete(height: HeightEntity) {
        manager.context.delete(height)
        save()
    }
    
    /// Сохранение изменений значений роста в базу данных.
    func save() {
        heights.removeAll()
        
        self.manager.save()
        self.getHeights()
    }
}
