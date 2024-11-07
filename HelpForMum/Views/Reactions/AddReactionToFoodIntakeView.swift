//
//  SwiftUIView.swift
//  HelpForMum
//
//  Created by Настя on 30.10.2024.
//

import SwiftUI

struct AddReactionToFoodIntakeView: View {
    @Environment(ReactionViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText = ""
    
    let foodIntake: FoodIntakeEntity
    
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            if vm.reactions.isEmpty {
                Spacer()
                Text("Пока нет реакций")
                Spacer()
            } else {
                TextField("Напишите название реакции...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                List {
                    ForEach(vm.reactions) { reaction in
                        if reaction.name!.contains(textFieldText) || textFieldText == "" {
                            Text(reaction.name!)
                                .onTapGesture {
                                    prove(reaction: reaction)
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
    }
    
    func prove(reaction: ReactionEntity) {
        if let products = foodIntake.products?.allObjects as? [ProductEntity] {
            if products.isEmpty {
                showAlert.toggle()
            } else {
                vm.addReactionToFoodIntake(reaction: reaction, foodIntake: foodIntake)
                dismiss()
            }
        }
    }
}

struct AddReactionButton: View {
    var body: some View {
        NavigationLink {
            AddReactionToBaseView()
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
