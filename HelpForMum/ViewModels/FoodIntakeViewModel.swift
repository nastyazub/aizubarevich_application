//
//  FoodIntakeViewModel.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//

// Класс взаимодействия с приёмами пищи.
// Функции:
/*
 1. Выгрузка приёмов пищи из базы данных.
 2. Добавление приёма пищи в базу данных.
 3. Удаление приёма пищи из базы данных.
 4. Сохранение изменений приёмов пищи в базу данных.
 */

import Foundation
import CoreData

@Observable class FoodIntakeViewModel {
    let manager = DataManager.instance
    var foodIntakes: [FoodIntakeEntity] = []
    
    //Загрузка данных
    init() {
        getFoodIntakes()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Загрузка приёмов пищи из базы данных, добавление их в список приёмов пищи.
    func getFoodIntakes() {
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        
        do {
            foodIntakes = try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching food intakes. \(error)")
        }
    }
    
    /// Добавление приёма пищи в базу данных в базу данных.
    /// - Parameters:
    ///   - id: Строковое значение id добавляемого приёма пищи. Передаётся для проверки на дубликаты.
    ///   - time: Тип времени приёма пищи (Завтрак, Обед, Перекус, Ужин).
    ///   - date: Дата приёма пищи.
    func addFoodIntake(id: String, time: TimeOfFoodEntity, date: Date) {
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        let filter = NSPredicate(format: "id == %@", id)
        request.predicate = filter
        
        do {
            let existing_FoodIntake = try manager.context.fetch(request)
            if existing_FoodIntake.isEmpty {
                let newFoodIntake = FoodIntakeEntity(context: manager.context)
                newFoodIntake.id = id
                newFoodIntake.date = date
                newFoodIntake.type_of_time = time
                foodIntakes.append(newFoodIntake)
                print("Приём пищи добавлен")
                save()
            }
        } catch let error {
            print("Ошибка в чтении данных о приёме пищи. \(error)")
        }
    }
    
    /// Удаление определённого приёма пищи.
    /// - Parameter foodIntake: Элемент базы данных (приём пищи), который нужно удалить.
    func delete(foodIntake: FoodIntakeEntity) {
        manager.context.delete(foodIntake)
        save()
    }
    
    /// Сохранение изменений приёмов пищи в базу данных.
    func save() {
        foodIntakes.removeAll()
        self.manager.save()
        self.getFoodIntakes()
    }
}
