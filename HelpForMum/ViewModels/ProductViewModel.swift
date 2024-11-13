//
//  ProductViewModel.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//

// Класс взаимодействия с продуктами.
// Функции:
/*
 1. Выгрузка продуктов из базы данных.
 2. Добавление продукта в базу данных.
 3. Добавление продукта в определённый приём пищи.
 4. Добавление продукта в определённое блюдо.
 5. Удаление продукта из базы данных.
 6. Сортировка списка продуктов, входящих в определённый приём пищи.
 7. Удаление продукта из приёма пищи.
 8. Сортировка списка продуктов, входящих в определённое блюдо.
 9. Удаление продукта из блюда.
 10. Сохранение изменений продуктов в базу данных.
 */

import Foundation
import CoreData

@Observable class ProductViewModel {
    let manager = DataManager.instance
    var products: [ProductEntity] = []
    
    // Загрузка данных
    init() {
        getProducts()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Загрузка продуктов из базы данных, добавление их в список продуктов.
    func getProducts() {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        
        do {
            products = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching products. \(error)")
        }
    }
    
    ///  Добаление продукта в базу данных.
    /// - Parameter name: Название продукта.
    func addProduct(name: String) -> [ProductEntity] {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "name = %@", name)
        request.predicate = filter
        
        do {
            products = try manager.context.fetch(request)
            if products.isEmpty {
                let newProduct = ProductEntity(context: manager.context)
                newProduct.name = name
                newProduct.id = UUID().uuidString
                products.append(newProduct)
                save()
                print("Продукт добавлен")
                return [newProduct]
            }
        } catch let error {
            print("Ошибка добавления продукта в базу. \(error)")
        }
        return products
    }
    
    /// Добавление продукта в определённый приём пищи.
    /// - Parameters:
    ///   - product: Элемент базы данных (продукт), который  нужно добавить.
    ///   - foodIntake: Элемент базы данных (приём пищи), куда нужно добавить продукт.
    func addProductToFoodIntake(product: ProductEntity, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@ AND id == %@", foodIntake, product.id!)
        request.predicate = filter
        
        do {
            let productsForFoodIntake = try manager.context.fetch(request)
            if productsForFoodIntake.isEmpty {
                foodIntake.addToProducts(product)
                save()
            }
        } catch let error {
            print("Ошибка в добавлении продукта к приёму пищи. \(error)")
        }
    }
    
    /// Добавление продукта в определённое блюдо.
    /// - Parameters:
    ///   - product: Элемент базы данных (продукт), который  нужно добавить.
    ///   - meal: Элемент базы данных (блюдо), куда нужно добавить продукт.
    func addProductToMeal(product: ProductEntity, meal: MealEntity) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "meals CONTAINS %@ AND id == %@", meal, product.id!)
        request.predicate = filter
        
        do {
            let productsForMeal = try manager.context.fetch(request)
            if productsForMeal.isEmpty {
                meal.addToProducts(product)
                save()
            }
        } catch let error {
            print("Ошибка в добавлении продукта к приёму пищи. \(error)")
        }
    }
    
    /// Удаление продукта из базы данных.
    /// - Parameter product: Элемент базы данных (продукт), который  нужно добавить.
    func deleteFromBase(product: ProductEntity) {
        manager.context.delete(product)
        save()
    }
    
    /// Сортировка списка продуктов, входящих в определённый приём пищи.
    /// - Parameter foodIntake: Элемент базы данных (блюдо), продукты которого надо отсортировать.
    /// - Returns: Отсортированный список продуктов приёма пищи.
    func sortProductsForFoodIntake(foodIntake: FoodIntakeEntity) -> [ProductEntity] {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = filter
        request.sortDescriptors = [nameSortDescriptor]
        
        do {
            products = try manager.context.fetch(request)
            return products
        } catch let error {
            print("Ошибка сортировки списка продуктов. \(error)")
        }
        return []
    }
    
    /// Удаление продукта из приёма пищи.
    /// - Parameters:
    ///   - product: Элемент базы данных (продукт), который нужно удалить из приёма пищи.
    ///   - foodIntake: Элемент базы данных (приём пищи), откуда нужно удалить продукт.
    func deleteFromFoodIntake(product: ProductEntity, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        request.predicate = filter
        
        do {
            products = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка удаления продукта из приёма пищи. \(error)")
        }
        if products.contains(product) {
            foodIntake.removeFromProducts(product)
            save()
            print("Продукт удалён из приёма пищи. \(String(describing: product.name))")
        }
    }
    
    /// Сортировка списка продуктов, входящих в определённое блюдо.
    /// - Parameter meal: Элемент базы данных (блюдо), продукты которого надо отсортировать.
    /// - Returns: Отсортированный список продуктов блюда.
    func sortProductsForMeal(meal: MealEntity) -> [ProductEntity] {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "meals CONTAINS %@", meal)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = filter
        request.sortDescriptors = [nameSortDescriptor]
        
        do {
            products = try manager.context.fetch(request)
            return products
        } catch let error {
            print("Ошибка сортировки списка продуктов. \(error)")
        }
        return []
    }
    
    /// Удаление продукта из блюда.
    /// - Parameters:
    ///   - product: Элемент базы данных (продукт), который нужно удалить из блюда.
    ///   - meal: Элемент базы данных (блюдо), откуда нужно удалить продукт.
    func deleteFromMeal(product: ProductEntity, meal: MealEntity) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "meals CONTAINS %@", meal)
        request.predicate = filter
        
        do {
            products = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка удаления продукта из блюда. \(error)")
        }
        if products.contains(product) {
            meal.removeFromProducts(product)
            save()
            print("Продукт удалён из блюда. \(String(describing: product.name))")
        }
    }
    
    /// Сохранение изменений продуктов в базу данных
    func save() {
        products.removeAll()
        self.manager.save()
        self.getProducts()
    }
}
