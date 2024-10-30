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
    
//    func addReactionToTime(reaction: ReactionEntity, foodIntake: FoodIntakeEntity) {
//        let request = NSFetchRequest<ReactionEntity>(entityName: "ReactionEntity")
//        let filter = NSPredicate(format: "foodIntakes CONTAINS %@ AND id == %d", foodIntake, reaction.id!)
//        request.predicate = filter
//        
//        do {
//            react
//        }
//    }
    
    func save() {
        reactions.removeAll()
        
        manager.save()
        self.getReactions()
    }
}

