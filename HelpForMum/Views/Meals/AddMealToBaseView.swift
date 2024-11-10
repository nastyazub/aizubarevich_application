//
//  AddMealToBaseView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

// Страница добавления блюда в базу данных

import SwiftUI

struct AddMealToBaseView: View {
    // MARK: СВОЙСТВА
    
    // Среды
    @Environment(MealViewModel.self) var meal_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    @State var next: Bool = false // ИНдикатор перехода на следующий шаг
    
    @State var showAlertEmpty: Bool = false
    @State var showAlertSameName: Bool = false
    
    // MARK: ТЕЛО
    
    var body: some View {
        NavigationStack {
            VStack {
                if !next {
                    TextField("Название блюда...", text: $textFieldText)
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    
                    
                    Button(action: {
                        if !textFieldText.isEmpty {
                            var flag = true
                            for meal in meal_vm.meals {
                                if meal.name == textFieldText {
                                    flag = false
                                    break
                                }
                            }
                            if flag {
                                meal_vm.addMeal(name: textFieldText)
                                next = true
                            } else {
                                showAlertSameName = true
                            }
                        } else {
                            showAlertEmpty = true
                        }
                        
                    }, label: {
                        Text("Готово")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                    })
                    .alert("Неверный ввод", isPresented: $showAlertEmpty) {
                        Button("Ок", role: .cancel) { }
                    } message: {
                        Text("Нельзя оставить поле пустым. Введите название блюда.")
                    }
                    
                    .alert("Неверный ввод", isPresented: $showAlertSameName) {
                        Button("Ок", role: .cancel) { }
                    } message: {
                        Text("Блюдо с таким названием уже существует.")
                    }
                }
                if next {
                    Text(textFieldText)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    NavigationLink {
                        ForEach(meal_vm.meals) { meal in
                            if meal.name == textFieldText {
                                MealStructureView(meal: meal)
                            }
                        }
                    } label: {
                        Text("Далее ->")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
            }
            .navigationTitle("Добавление блюда")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.primary)
                    })
                }
            }
            
        }
    }
}

#Preview {
    AddMealToBaseView()
        .environment(MealViewModel())
        .environment(ProductViewModel())
}
