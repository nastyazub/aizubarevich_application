//
//  MealsView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

import SwiftUI

struct MealsView: View {
    
    @Environment(MealViewModel.self) var meal_vm
    @State var meals: [MealEntity] = []
    
    @State var showAddingView: Bool = false
    @State var showEditingView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if meal_vm.meals.isEmpty {
                    Spacer()
                    Text("Пока нет блюд")
                        .foregroundStyle(Color.secondary)
                    Spacer()
                } else {
                    ForEach(meal_vm.meals) { meal in
                        
                        HStack {
                            NavigationLink {
                                MealStructureView(meal: meal)
                            } label: {
                                RectangleForMealView(meal: meal)
                            }

                            Button(action: {
                                meal_vm.deleteFromBase(meal: meal)
                            }, label: {
                                Image(systemName: "trash")
                                    .padding(.trailing)
                            })
                        }
                    }
                }
            }
            .navigationTitle("Блюда")
            
            Button(action: {
                showAddingView.toggle()
            }, label: {
                AddMealButton()
            })
            .popover(isPresented: $showAddingView, content: {
                AddMealToBaseView()
                    .presentationCompactAdaptation(.sheet)
            })
        }
    }
}

struct RectangleForMealView: View {
    
    let meal: MealEntity
    
    var body: some View {
        ZStack {
            Text(meal.name ?? "")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal)
        }
        .frame(height: 100)
        .background(Color("BlackOrWhiteColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .secondary, radius: 10)
        .padding()
        
    }
}

#Preview {
    MealsView()
        .environment(MealViewModel())
}
