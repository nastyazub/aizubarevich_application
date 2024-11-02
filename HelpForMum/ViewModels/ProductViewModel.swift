//
//  ProductViewModel.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//
// Класс продуктов. Здесь описаны все функции, которые связаны с продуктами

import Foundation
import CoreData


@Observable class ProductViewModel {
    let manager = DataManager.instance
    var products: [ProductEntity] = []
    
    // Загрузка данных
    init() {
        getProducts()
    }
    
    // Загрузка продуктов, добавление их в список продуктов
    func getProducts() {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSortDescriptor]
        do {
            products = try manager.context.fetch(request)
        } 
        catch let error {
            print("Error fetching products. \(error)")
        }
                
    }
    
    // Добавление продуктов в базу данных
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
    
    // Добавление продукта
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
    
    func searchProductName(name: String) {
        let request = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        let filter = NSPredicate(format: "name = %@", name)
        request.predicate = filter
        
        do {
            products = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка в запросе продукта по имени. \(error)")
        }
        
    }
    
    func deleteFromBase(product: ProductEntity) {
        manager.context.delete(product)
        save()
    }
    
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
    
    // Сохранение изменений в базу данных
    func save() {
        products.removeAll()
        
        self.manager.save()
        self.getProducts()
    }
    
    func deleteAll() {
        for el in products {
            manager.context.delete(el)
            save()
        }
    }
}
