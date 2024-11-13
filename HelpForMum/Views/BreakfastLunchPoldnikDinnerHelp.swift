//
//  BreakfastLunchPoldnikDinnerHelp.swift
//  HelpForMum
//
//  Created by Настя on 12.08.2024.
//

// Дизайн приёмов пищи. Через него происходит добавление, удаление, просмотр продуктов и реакций, относящихся к определённому приёму пищи.

import SwiftUI

struct BreakfastLunchPoldnikDinnerHelp: View {
    
    // MARK: СВОЙСТВА
    
    // Среды
    @Environment(FoodIntakeViewModel.self) var vm
    @Environment(\.colorScheme) var colorScheme
    
    // Приём пищи
    let foodIntake: FoodIntakeEntity
    
    // Элементы приёма пищи
    let title: String
    let id: String
    let time: TimeOfFoodEntity
    let date: Date
    let textColor: Color
    let backgroundColor: Color
    
    // Инициализация приёма пищи, чтобы присвоить элементам приёма пищи их значения
    init(foodIntake: FoodIntakeEntity) {
        self.foodIntake = foodIntake
        self.title = (foodIntake.type_of_time?.name)!
        self.id = foodIntake.id!
        self.date = foodIntake.date!
        self.time = foodIntake.type_of_time!
        
        if title == "Завтрак" {
            self.textColor = Color("BreakfastTextColor")
            self.backgroundColor = Color("BreakfastBackgroundColor")
        }
        else if title == "Обед" {
            self.textColor = Color("LunchTextColor")
            self.backgroundColor = Color("LunchBackgroundColor")
        }
        else if title == "Перекус" {
            self.textColor = Color("PoldnikTextColor")
            self.backgroundColor = Color("PoldnikBackgroundColor")
        }
        else {
            self.textColor = Color("DinnerTextColor")
            self.backgroundColor = Color("DinnerBackgroundColor")
        }
    }
    
    // MARK: ТЕЛО
    
    var body: some View {
        HStack {
            HStack {
                
                NavigationLink {
                    ContentOfFoodIntakeView(foodIntake: foodIntake) // Страница, где показываются продукты и реакции приёма пищи
                } label: {
                    Text(title)
                        .foregroundStyle(Color(textColor))
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Menu {
                    NavigationLink {
                        AddProductToFoodIntakeView(foodIntake: foodIntake) // Добавление продукта
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Продукт")
                        }
                    }
                    
                    NavigationLink {
                        AddReactionToFoodIntakeView(foodIntake: foodIntake) // Добавление реакции
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Реакция")
                        }
                    }
                    
                    NavigationLink {
                        AddMealToFoodIntakeView(foodIntake: foodIntake) // Добавление блюда
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Блюдо")
                        }
                    }
                    
                } label: {
                    Image(systemName: "plus.app")
                        .foregroundStyle(Color(textColor))
                        .font(.title)
                }
            }
            .padding()
            .background (
                Color(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .shadow(color: .secondary,radius: colorScheme == .dark ? 10 : 0)
            .padding(8)
            
            Button { // Кнопка удаления приёма пищи
                vm.delete(foodIntake: foodIntake)
            } label: {
                Image(systemName: "trash")
                    .font(.subheadline)
                    .foregroundStyle(Color(textColor))
            }
            .padding(.trailing)
            
        }
    }
}

// Так как надо передавать элемент базы данных, делаю отдельный Вью, где создаю его.
struct SubViewForPreview: View {
    @Environment(FoodIntakeViewModel.self) var vm
    
    var body: some View {
        BreakfastLunchPoldnikDinnerHelp(foodIntake: vm.foodIntakes[0])
    }
}

#Preview {
    SubViewForPreview()
        .environment(FoodIntakeViewModel())
}
