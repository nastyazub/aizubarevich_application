//
//  ReactionViewModel.swift
//  HelpForMum
//
//  Created by Настя on 29.10.2024.
//

// Класс взаимодействия с реакциями.
// Функции:
/*
 1. Выгрузка реакций из базы данных.
 2. Добавление реакции в базу данных.
 3. Добавление реакции в определённый приём пищи.
 4. Удаление реакции из базы данных.
 5. Сортировка списка реакций, входящих в определённый приём пищи.
 6. Удаление реакции из приёма пищи.
 7. Сохранение изменений реакций в базу данных.
 */

import Foundation
import CoreData

@Observable class ReactionViewModel {
    let manager = DataManager.instance
    var reactions: [ReactionEntity] = []
    
    // Загрузка данных
    init() {
        getReactions()
    }
    
    // MARK: ФУНКЦИИ
    
    ///  Загрузка реакций из базы данных, добавление их в список реакций.
    func getReactions() {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        
        do {
            reactions = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга реакций. \(error)")
        }
    }
    
    /// Добавление реакции в базу данных.
    /// - Parameter name: Название реакции.
    func addReaction(name: String) {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "name == %@", name)
        request.predicate = filter
        
        
        do {
            reactions = try manager.context.fetch(request)
            if reactions.isEmpty {
                let newReaction = ReactionEntity(context: manager.context)
                newReaction.id = UUID().uuidString
                newReaction.name = name
                reactions.append(newReaction)
                save()
            }
        } catch let error {
            print("Ошибка добавления реакции. \(error)")
        }
    }
    
    /// Добавление реакции в определённый приём пищи.
    /// - Parameters:
    ///   - reaction: Элемент базы данных (реакция), которую нужно добавить.
    ///   - foodIntake: Элемент базы данных (приём пищи), куда нужно добавить реакцию.
    func addReactionToFoodIntake(reaction: ReactionEntity, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@ AND id == %@", foodIntake, reaction.id!)
        request.predicate = filter
        
        do {
            let reactionsForFoodIntake = try manager.context.fetch(request)
            if reactionsForFoodIntake.isEmpty {
                foodIntake.addToReactions(reaction)
                save()
            }
        } catch let error {
            print("Ошибка добавления реакции к приёму пищи. \(error)")
        }
    }
    
    /// Удаление реакции из базы данных.
    /// - Parameter reaction: Элемент базы данных (реакция), который нужно удалить.
    func deleteFromBase(reaction: ReactionEntity) {
        manager.context.delete(reaction)
        save()
    }
    
    /// Сортировка списка реакций, входящих в определённый приём пищи.
    /// - Parameter foodIntake: Элемент базы данных (продукт), который нужно удалить из блюда.
    /// - Returns: Элемент базы данных (блюдо), откуда нужно удалить продукт.
    func sortReactionsForFoodIntake(foodIntake: FoodIntakeEntity) -> [ReactionEntity] {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = filter
        request.sortDescriptors = [nameSortDescriptor]
        
        do {
            reactions = try manager.context.fetch(request)
            return reactions
        } catch let error {
            print("Ошибка сортировки списка реакций. \(error)")
        }
        return []
    }
    
    
    /// Удаление реакции из приёма пищи.
    /// - Parameters:
    ///   - reaction: Элемент базы данных (реакция), который нужно удалить из приёма пищи.
    ///   - foodIntake: Элемент базы данных (приём пищи), из которого нужно удалить реакцию.
    func deleteFromFoodIntake(reaction: ReactionEntity, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        request.predicate = filter
        
        do {
            reactions = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка удаления реакции из приёма пищи. \(error)")
        }
        if reactions.contains(reaction) {
            foodIntake.removeFromReactions(reaction)
            save()
            print("Реакция удалена из приёма пищи. \(String(describing: reaction.name))")
        }
    }
    
    /// Сохранение изменений реакций в базу данных.
    func save() {
        reactions.removeAll()
        manager.save()
        self.getReactions()
    }
}

