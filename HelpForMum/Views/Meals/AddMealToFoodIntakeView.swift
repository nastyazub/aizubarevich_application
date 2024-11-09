//
//  AddMealToFoodIntakeView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

// Страница добаления блюда в приём пищи. Результат: в приём пищи добавляются продукты из блюда.

import SwiftUI

struct AddMealToFoodIntakeView: View {
    
    // Среды
    @Environment(MealViewModel.self) var meal_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    @State var showAddingView: Bool = false // Индикатор появления sheet - добавления блюда
    
    let foodIntake: FoodIntakeEntity // Приём пищи
    
    var body: some View {
        NavigationStack() {
            if meal_vm.meals.isEmpty {
                Spacer()
                Text("Пока нет блюд")
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            else {
                TextField("Напишите название блюда...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                List {
                    ForEach(meal_vm.meals) { meal in
                        if meal.name!.lowercased().contains(textFieldText.lowercased()) || textFieldText == "" {
                            HStack {
                                Text(meal.name!)
                                    .onTapGesture {
                                        meal_vm.addMealToFoodIntake(meal: meal, foodIntake: foodIntake)
                                        dismiss()
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        NavigationLink {
                                            MealStructureView(meal: meal) // Просмотр, изменение состава блюда
                                        } label: {
                                            Text("Состав")
                                        }

                                    }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            Button(action: {
                showAddingView.toggle()
            }, label: {
                AddMealButton()
            })
            .sheet(isPresented: $showAddingView, content: {
                AddMealToBaseView()
                    .presentationDetents([.large])
            })
            
            .navigationTitle(foodIntake.type_of_time?.name ?? "")
        }
    }
}

// MARK: КНОПКА ДОБАВЛЕНИЯ

// Кнопка добавления блюда в базу данных
struct AddMealButton: View {
    var body: some View {
            Text("+ Добавить")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding()
    }
}

// Дополнительный view для того, чтобы передать элемент базы данных
struct subViewForPreview_MealToFoodIntake: View {
    
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    
    var body: some View {
        AddMealToFoodIntakeView(foodIntake: foodIntake_vm.foodIntakes[0])
    }
}

#Preview {
    subViewForPreview_MealToFoodIntake()
        .environment(FoodIntakeViewModel())
        .environment(MealViewModel())
}
