//
//  HeightViewModel.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

import Foundation
import CoreData

@Observable class HeightViewModel {
    let manager = DataManager.instance
    var heights: [HeightEntity] = []
    
    init() {
        self.getHeights()
    }
    
    func getHeights() {
        let request = NSFetchRequest<HeightEntity>(entityName: "HeightEntity")
        
        do {
            heights = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга значений роста. \(error)")
        }
    }
    
    func addHeight(height: Int, date: Date) {
        let request = NSFetchRequest<HeightEntity>(entityName: "HeightEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            heights = try manager.context.fetch(request)
            if heights.isEmpty {
                let newHeight = HeightEntity(context: manager.context)
                newHeight.id = UUID().uuidString
                newHeight.date = date
                newHeight.height = Int64(height)
                heights.append(newHeight)
                save()
            } else {
                let prevHeight = heights[0].height
                heights[0].height = Int64(height)
                save()
                print("Рост изменён на \(height) у \(String(describing: heights[0].date)) c \(prevHeight)")
            }
            
            print("Длина ростов: \(heights.count)")
            
        } catch let error {
            print("Ошибка добавления роста. \(error)")
        }
    }
    
    func searchHeightByDate(date: Date) -> [HeightEntity] {
        let request = NSFetchRequest<HeightEntity>(entityName: "HeightEntity")
        let filter = NSPredicate(format: "date == %@", date as NSDate)
        request.predicate = filter
        
        do {
            heights = try manager.context.fetch(request)
            if !heights.isEmpty && heights.count == 1 {
                return heights
            } else if heights.count > 1 {
                print("2 значения")
            }
        } catch let error {
            print("Ошибка поиска роста по дате. \(error)")
        }
        
        return []
    }
    
    func delete(height: HeightEntity) {
        manager.context.delete(height)
        save()
    }
    
    func save() {
        heights.removeAll()
        
        self.manager.save()
        self.getHeights()
    }
}
