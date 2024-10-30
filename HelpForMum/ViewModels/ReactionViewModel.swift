//
//  ReactionViewModel.swift
//  HelpForMum
//
//  Created by Настя on 29.10.2024.
//

import Foundation
import CoreData

@Observable class ReactionViewModel {
    let manager = DataManager.instance
    var reactions: [ReactionEntity] = []
    
    init() {
        getReactions()
    }
    
    func getReactions() {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        
        do {
            reactions = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга реакций. \(error)")
        }
    }
    
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
    
    func addReactionToTime(reaction: ReactionEntity, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@ AND id == %d", foodIntake, reaction.id!)
        request.predicate = filter
        
        do {
            reactions = try manager.context.fetch(request)
            if reactions.isEmpty {
                foodIntake.addToReactions(reaction)
                save()
            }
        } catch let error {
            print("Ошибка добавления реакции к приёму пищи")
        }
    }
    
    func deleteFromBase(reaction: ReactionEntity) {
        manager.context.delete(reaction)
        save()
    }
    
    func deleteFromFoodIntake(at offsets: IndexSet, foodIntake: FoodIntakeEntity) {
        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
        let filter = NSPredicate(format: "foodIntakes CONTAINS %@", foodIntake)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.predicate = filter
        request.sortDescriptors = [nameSortDescriptor]
        do {
            reactions = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка удаления продукта. \(error)")
        }
        for offset in offsets {
            let reaction = reactions[offset]
            foodIntake.removeFromReactions(reaction)
            save()
            print("product was deleted. \(String(describing: reaction.name))")
        }
    }
    
    func save() {
        reactions.removeAll()
        
        manager.save()
        self.getReactions()
    }
}

