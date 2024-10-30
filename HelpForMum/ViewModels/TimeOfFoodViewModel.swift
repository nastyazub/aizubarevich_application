//
//  TimeOfFoodViewModel.swift
//  HelpForMum
//
//  Created by Настя on 29.09.2024.
//

import Foundation
import CoreData

@Observable class TimeOfFoodViewModel {
    let manager = DataManager.instance
    var times: [TimeOfFoodEntity] = []
    
    init() {
        getTimes()
    }
    
    func getTimes() {
        let request = NSFetchRequest<TimeOfFoodEntity>(entityName: "TimeOfFoodEntity")
        do {
            times = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга типов приёмов пищи. \(error)")
        }
    }
    
    func addTimes() {
        let list = [
            "Завтрак", "Обед", "Перекус", "Ужин"
        ]
        if times.isEmpty {
            for i in 1...4 {
                let newTime = TimeOfFoodEntity(context: manager.context)
                newTime.name = list[i - 1]
                print(newTime.name ?? "")
                newTime.id = Int16(i)
                print(newTime.id)
                times.append(newTime)
                print("Возможное время пищи добавлено.")
            }
            save()
        }
    }
    
    func getTimeForFoodIntake(title: String) {
        let request = NSFetchRequest<TimeOfFoodEntity>(entityName: "TimeOfFoodEntity")
        let filter = NSPredicate(format: "name == %@", title)
        request.predicate = filter
        
        do {
            times = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка в присвоении типа приёму пищи. \(error)")
        }
    }
    
    func save() {
        times.removeAll()
        self.manager.save()
        self.getTimes()
    }
    
    func deleteAll() {
        for el in times {
            manager.context.delete(el)
            save()
        }
    }
}
