//
//  AddMealToBaseView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

import SwiftUI

struct AddMealToBaseView: View {
    
    @Environment(MealViewModel.self) var meal_vm
    @Environment(\.dismiss) var dismiss
    @State var textFieldText: String = ""
    
    @State var next: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !next {
                    TextField("Название блюда", text: $textFieldText)
                    Button("Готово") {
                        meal_vm.addMeal(name: textFieldText)
                        next = true
                    }
                }
                if next {
                    Text(textFieldText)
                    NavigationLink {
                        ForEach(meal_vm.meals) { meal in
                            if meal.name == textFieldText {
                                MealStructureView(meal: meal)
                            }
                        }
                    } label: {
                        Text("Далее ->")
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
