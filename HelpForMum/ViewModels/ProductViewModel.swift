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
 4. Удаление продукта из базы данных.
 5. Удаление продукта из приёма пищи.
 6. Сохранение изменений продуктов в базу данных.
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
    func addProduct(name: String) {
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
            }
        } catch let error {
            print("Ошибка добавления продукта в базу. \(error)")
        }
    }
    
    /// Добавление продукта в определённый приём пищи.
    /// - Parameters:
    ///   - product: Элемент базы данных (продукт), который  нужно добавить.
    ///   - foodIntake: Элемент базы данных (приём пищи), куда нужно добавить продукт.
    func addProductToTime(product: ProductEntity, foodIntake: FoodIntakeEntity) { // ДОДЕЛАТЬ!!!!
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@ AND id == %d", foodIntake, product.id!)
        request.predicate = filter
        
        do {
            products = try manager.context.fetch(request)
            if products.isEmpty {
                foodIntake.addToProducts(product)
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
    
    /// Удаление продукта из приёма пищи.
    /// - Warning: offses - множество с одним значением, так для удаления продукта пользователю нужно свайпнуть.
    /// - Parameters:
    ///   - offsets: Множество целочисленных значений, равное положению с списке продуктов, которые нужно удалить.
    ///   - foodIntake: Элемент базы данных (приём пищи), откуда нужно удалить продукт.
    func deleteFromFoodIntake(at offsets: IndexSet, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = filter
        request.sortDescriptors = [nameSortDescriptor]
        
        do {
            products = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка удаления продукта. \(error)")
        }
        for offset in offsets {
            let product = products[offset]
            foodIntake.removeFromProducts(product)
            save()
            print("Продукт удалён из приёма пищи. \(String(describing: product.name))")
        }
    }
    
    /// Сохранение изменений продуктов в базу данных
    func save() {
        products.removeAll()
        self.manager.save()
        self.getProducts()
    }
    
    //MARK: УДАЛИТЬ
    
    func deleteAll() {
        for el in products {
            manager.context.delete(el)
            save()
        }
    }
}
