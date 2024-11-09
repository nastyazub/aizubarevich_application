//
//  WeightViewModel.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

// Класс взаимодействия со значениями веса.
// Функции:
/*
 1. Выгрузка значений веса из базы данных.
 2. Добавление значения веса в базу данных.
 3. Удаление значения веса из базы данных.
 4. Сохранение изменений значений веса в базу данных.
 */

import Foundation
import CoreData

@Observable class WeightViewModel {
    let manager = DataManager.instance
    var weights: [WeightEntity] = []
    
    // Загрузка данных
    init() {
        getWeights()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Выгрузка значений веса из базы данных.
    func getWeights() {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        
        do {
            weights = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга значений веса. \(error)")
        }
    }
    
    /// Добавление значения веса в базу данных.
    /// - Parameters:
    ///   - weight: Вес ребёнка в килограммах. Отображается с тремя цифрами после запятой.
    ///   - date: Дата измерения веса.
    func addWeight(weight: Double, date: Date) {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            weights = try manager.context.fetch(request)
            if weights.isEmpty {
                let newWeight = WeightEntity(context: manager.context)
                newWeight.id = UUID().uuidString
                newWeight.date = date
                newWeight.weight = Double(weight)
                weights.append(newWeight)
                save()
            } else {
                let prevWeight = weights[0].weight
                weights[0].weight = weight
                save()
                print("Вес изменён на \(String(format: "%.3f", weight)).")
            }
        } catch let error {
            print("Ошибка добавления веса. \(error)")
        }
    }
    
    // MARK: Надо ли?
    
    /// Удаление значения веса из базы данных.
    /// - Parameter weight: Элемент базы данных (вес), который нужно удалить.
    func delete(weight: WeightEntity) {
        manager.context.delete(weight)
        
        save()
    }
    
    func save() {
        weights.removeAll()
        
        self.manager.save()
        self.getWeights()
    }
}
