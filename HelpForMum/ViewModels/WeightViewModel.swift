//
//  WeightViewModel.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

import Foundation
import CoreData

@Observable class WeightViewModel {
    let manager = DataManager.instance
    var weights: [WeightEntity] = []
    
    init() {
        getWeights()
    }
    
    func getWeights() {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        
        do {
            weights = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга значений веса. \(error)")
        }
    }
    
    func addWeight(weight: Double, date: Date) {
        let request = NSFetchRequest<WeightEntity>(entityName: "WeightEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            weights = try manager.context.fetch(request)
            if weights.isEmpty {
                let newWeight = WeightEntity(context: manager.context)
                newWeight.id = UUID().uuidString
                newWeight.date = date
                newWeight.weight = Double(weight)
                weights.append(newWeight)
                save()
            } else {
                let prevWeight = weights[0].weight
                weights[0].weight = weight
                save()
                print("Вес изменён на \(String(format: "%.3f", weight)) у \(String(describing: weights[0].date)) c \(prevWeight)")
            }
        } catch let error {
            print("Ошибка добавления веса. \(error)")
        }
    }
    
    
    
    func delete(weight: WeightEntity) {
        manager.context.delete(weight)
        
        save()
    }
    
    func save() {
        weights.removeAll()
        
        self.manager.save()
        self.getWeights()
    }
}
