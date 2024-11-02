//
//  AnalyticsOfReactionsAndProductsViewModel.swift
//  HelpForMum
//
//  Created by Настя on 31.10.2024.
//

import Foundation
import CoreData

@Observable class Analytics {
    let manager = DataManager.instance
    
    func countAll(reaction: ReactionEntity) -> Int {
        var countAll = 0
        let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
        let filter = NSPredicate(format: "reactions CONTAINS %@", reaction)
        request.predicate = filter
        do {
            let foodIntakes = try manager.context.fetch(request)
            for foodIntake in foodIntakes {
                countAll += foodIntake.products!.count
            }
            
        } catch let error {
            print("Ошибка анализа при вычислении общего количества появлений реакции. \(error)")
        }
        return countAll
    }
    
    func countForProduct(reaction: ReactionEntity) -> [Dictionary<ProductEntity, Int>.Element] {
        var dict: [ProductEntity : Int] = [:]
        let requestFirst = NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
        do {
            let products = try manager.context.fetch(requestFirst)
            let request = NSFetchRequest<FoodIntakeEntity>(entityName: "FoodIntakeEntity")
            
            for product in products {
                let filter = NSPredicate(format: "reactions CONTAINS %@ AND products CONTAINS %@", reaction, product)
                request.predicate = filter
                do {
                    let foodIntakes = try manager.context.fetch(request)
                    let countForProduct = foodIntakes.count
                    dict.updateValue(countForProduct, forKey: product)
                } catch let error {
                    print("Ошибка анализа данных. \(error)")
                }
            }
        } catch let error {
            print("Ошибка анализа при вычислении количества появлений реакции вместе с продуктами. \(error)")
        }
        
        let otDict = dict.sorted(by: {$0.value > $1.value})
        return otDict
    }
}
