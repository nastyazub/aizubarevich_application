//
//  SwiftUIView.swift
//  HelpForMum
//
//  Created by Настя on 30.10.2024.
//

// Страница добавления реакций в приём пищи.

import SwiftUI

struct AddReactionToFoodIntakeView: View {
    
    // Среды
    @Environment(ReactionViewModel.self) var reaction_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText = ""
    
    let foodIntake: FoodIntakeEntity
    
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            if reaction_vm.reactions.isEmpty {
                Spacer()
                Text("Пока нет реакций")
                Spacer()
            } else {
                TextField("Поик...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                List {
                    ForEach(reaction_vm.reactions.sorted() {$0.name! < $1.name!}) { reaction in // Сортировка по алфавиту
                        if let name = reaction.name {
                            if name.lowercased().contains(textFieldText.lowercased()) || textFieldText == "" { // Проверка соответсвтвия значению в поиске
                                Text(name)
                                    .onTapGesture {
                                        prove(reaction: reaction) // Проверка, есть ли в приёме пищи продукт
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button("Удалить") {
                                            reaction_vm.deleteFromBase(reaction: reaction)
                                        }
                                        .tint(.red)
                                        
                                        NavigationLink {
                                            EditReactionView(reaction: reaction)
                                        } label: {
                                            Text("Изменить")
                                        }
                                    }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .alert("Нельзя", isPresented: $showAlert) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Сначала нужно добавить продукты.")
                }
            }
            AddReactionButton()
                .navigationTitle(foodIntake.type_of_time?.name ?? "")
        }
        .onAppear {
            textFieldText = ""
        }
    }
    
    func prove(reaction: ReactionEntity) {
        if let products = foodIntake.products?.allObjects as? [ProductEntity] {
            if products.isEmpty {
                showAlert.toggle()
            } else {
                reaction_vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake)
                dismiss()
            }
        }
    }
}

// Кнопка добавления реакции в базу данных
struct AddReactionButton: View {
    var body: some View {
        NavigationLink {
            AddReactionToBaseView() // Страница добавления реакции в базу данных
        } label: {
            Text("+ Добавить")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding()
        }
    }
}

// Дополнительный view, для того чтобы ввести значение из базы данных
struct SubViewForPreview_addReactionToFoodIntake: View {
    
    @Environment(FoodIntakeViewModel.self) var vm
    
    var body: some View {
        AddReactionToFoodIntakeView(foodIntake: vm.foodIntakes[0])
    }
}

#Preview {
    SubViewForPreview_addReactionToFoodIntake()
        .environment(ReactionViewModel())
        .environment(FoodIntakeViewModel())
}
