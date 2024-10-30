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
    
    var body: some View {
        NavigationStack {
            if vm.reactions.isEmpty {
                Text("Реакций нет")
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
                                    vm.addReactionToTime(reaction: reaction, foodIntake: foodIntake)
                                    dismiss()
                                }
                        }
                    }
                }
                .listStyle(.plain)
            }
            AddReactionButton()
                .navigationTitle(foodIntake.type_of_time?.name ?? "")
        }
    }
}

#Preview {
    SubViewForPreview_addReactionToFoodIntake()
        .environment(ReactionViewModel())
        .environment(FoodIntakeViewModel())
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
