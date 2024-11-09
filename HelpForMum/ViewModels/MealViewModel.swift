//
//  MealViewModel.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

// Класс взаимодействия с блюдами.
// Функции:
/*
 1. Выгрузка блюд из базы данных.
 2. Добавление блюда в базу данных.
 3. Добавление блюда в определённый приём пищи.
 4. Удаление блюда из базы данных.
 5. Сохранение изменений блюд в базу данных.
 */

import Foundation
import CoreData

@Observable class MealViewModel {
    let manager = DataManager.instance
    var meals: [MealEntity] = []
    
    // Загрузка данных
    init() {
        getMeals()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Загрузка блюд из базы данных, добавление их в список блюд.
    func getMeals() {
        let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
        
        do {
            meals = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга блюд. \(error)")
        }
    }
    
    /// Добавление блюда в базу данных.
    /// - Parameter name: Название блюда.
    func addMeal(name: String) {
        let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
        let filter = NSPredicate(format: "name == %@", name)
        request.predicate = filter
        
        do {
            meals = try manager.context.fetch(request)
            if meals.isEmpty {
                let newMeal = MealEntity(context: manager.context)
                newMeal.id = UUID().uuidString
                newMeal.name = name
                meals.append(newMeal)
                save()
            }
        } catch let error {
            print("Ошибка добавления блюда. \(error)")
        }
    }
    
    /// Добавление блюда в определённый приём пищи.
    ///  - Warning: В приём пищи добавляются продукты из блюда, само блюдо не добавляется в приём пищи.
    /// - Parameters:
    ///   - meal: Элемент базы данных (блюдо), которую нужно добавить.
    ///   - foodIntake:  Элемент базы данных (приём пищи), куда нужно добавить блюдо.
    func addMealToFoodIntake(meal: MealEntity, foodIntake: FoodIntakeEntity) {
        if let products = meal.products?.allObjects as? [ProductEntity] {
            for product in products {
                if !foodIntake.products!.contains(product) {
                    foodIntake.addToProducts(product)
                    save()
                }
            }
        }
    }
    
    /// Удаление блюда из базы данных.
    /// - Parameter meal: Элемент базы данных (блюдо), который нужно удалить.
    func deleteFromBase(meal: MealEntity) {
        manager.context.delete(meal)
        save()
    }
    
    /// Сохранение изменений блюд в базу данных.
    func save() {
        meals.removeAll()
        self.manager.save()
        self.getMeals()
    }
}
