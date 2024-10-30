//
//  FoodIntakeViewModel.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//

import Foundation
import CoreData

@Observable class FoodIntakeViewModel {
    let manager = DataManager.instance
    var foodIntakes: [FoodIntakeEntity] = []
    
    //Загрузка данных
    init() {
        getFoodIntakes()
    }
    
    // Загрузка приёмов пищи, добавление их в список приёмов пищи
    func getFoodIntakes() {
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        
        do {
            foodIntakes = try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching food intakes. \(error)")
        }
        
    }
    
    // Добавление приёмов пищи (добавляются при загрузке на экран)
    func addFoodIntake(id: String, time: TimeOfFoodEntity, date: Date) {
        //let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        //let filter = NSPredicate(format: "type_of_time == %@ AND date == %@", time, date as NSDate)
        //request.predicate = filter
        
        //do {
            //let existing_FoodIntake = try manager.context.fetch(request)
            //if existing_FoodIntake.isEmpty {
                let newFoodIntake = FoodIntakeEntity(context: manager.context)
                newFoodIntake.id = id
                newFoodIntake.date = date
                newFoodIntake.type_of_time = time
                foodIntakes.append(newFoodIntake)
                print("Приём пищи добавлен")
                save()
            //}
            
//        } catch let error {
//            print("Ошибка в чтении данных о приёме пищи. \(error)")
//        }
    }
    
    // Поиск приёма пищи по id
    func searchFoodIntakeId(id: String) {
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        let filter = NSPredicate(format: "id == %@", id)
        request.predicate = filter
        
        do {
            foodIntakes = try manager.context.fetch(request)
            
        } catch let error {
            print("Ошибка поиска приёма пищи по ID. \(error)")
        }
    }
    
    func searchFoodIntakeDate(date: Date) {
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            foodIntakes = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка поиска приёма пищи по дате. \(error)")
        }
        
    }
    
    //Сохранение изменений в базу данных
    func save() {
        foodIntakes.removeAll()
        
        self.manager.save()
        self.getFoodIntakes()
    }
    
    func delete(foodIntake: FoodIntakeEntity) {
        manager.context.delete(foodIntake)
        save()
    }
    
    func deleteAll() {
        for el in foodIntakes {
            manager.context.delete(el)
            save()
        }
    }
}
