//
//  TimeOfFoodViewModel.swift
//  HelpForMum
//
//  Created by Настя on 29.09.2024.
//
// Класс взаимодействия с типами приёмов пищи. 
// Функции:
/*
 1. Выгрузка типов приёмов пищи из базы данных.
 2. Добавление 4-х типов: Завтрак, Обед, Перекус, Ужин.
 3. Сохранение изменений типов приёмов пищи в базу данных.
*/

import Foundation
import CoreData

@Observable class TimeOfFoodViewModel {
    let manager = DataManager.instance
    var times: [TimeOfFoodEntity] = []
    
    //Загрузка данных
    init() {
        getTimes()
    }
    
    // MARK: ФУНКЦИИ
    
    /// Загрузка типов приёмов пищи из базы данных, добавление их в список типов приёмов пищи.
    func getTimes() {
        let request = NSFetchRequest<TimeOfFoodEntity>(entityName: "TimeOfFoodEntity")
        do {
            times = try manager.context.fetch(request)
        } catch let error {
            print("Ошибка фетчинга типов приёмов пищи. \(error)")
        }
    }
    
    /// Добавление типов приёмов пищи в базу данных.
    /// - Warning: Выполняется только один раз при первом открытии приложения
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
    
    /// Сохранение изменений типов приёмов пищи в базу данных.
    func save() {
        times.removeAll()
        self.manager.save()
        self.getTimes()
    }
}
