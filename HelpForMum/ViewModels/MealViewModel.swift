//
//  MealViewModel.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

import Foundation
import CoreData


@Observable class MealViewModel {
    let manager = DataManager.instance
    var meals: [MealEntity] = []
    
    init() {
        getMeals()
    }
    
    func getMeals() {
        let request = NSFetchRequest<MealEntity>(entityName: "MealEntity")
        
        do {
            meals = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга блюд. \(error)")
        }
    }
    
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
    
    func addMealToFoodIntake(meal: MealEntity, foodIntake: FoodIntakeEntity) {
        if let products = meal.products?.allObjects as? [ProductEntity] {
            for product in products {
                let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
                let filter = NSPredicate(format: "products CONTAINS %@", product)
                request.predicate = filter
                
                do {
                    let foodIntakes = try manager.context.fetch(request)
                    if foodIntakes.isEmpty {
                        foodIntake.addToProducts(product)
                        save()
                    }
                } catch let error {
                    print("Ошибка добавления блюда в приём пищи. \(error)")
                }
            }
        }
    }
    
    func deleteFromBase(meal: MealEntity) {
        manager.context.delete(meal)
        save()
    }
    
    func save() {
        meals.removeAll()
        self.manager.save()
        self.getMeals()
    }
}
