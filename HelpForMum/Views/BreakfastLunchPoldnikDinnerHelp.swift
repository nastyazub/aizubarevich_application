//
//  BreakfastLunchPoldnikDinnerHelp.swift
//  HelpForMum
//
//  Created by Настя on 12.08.2024.
//

import SwiftUI

struct BreakfastLunchPoldnikDinnerHelp: View {
    
    let title: String
    let textColor: Color
    let backgroundColor: Color
    let id: String
    let time: TimeOfFoodEntity
    
    let foodIntake: FoodIntakeEntity
    @Environment(FoodIntakeViewModel.self) var vm
    @Environment(\.colorScheme) var colorScheme
    
    let date: Date
    
    init(foodIntake: FoodIntakeEntity) {
        self.foodIntake = foodIntake
        self.title = (foodIntake.type_of_time?.name)!
        self.id = foodIntake.id!
        self.date = foodIntake.date!
        self.time = foodIntake.type_of_time!
        
        if title == "Завтрак" {
            self.textColor = Color("BreakfastTextColor") //Plum
            self.backgroundColor = Color("BreakfastBackgroundColor")
        }
        else if title == "Обед" {
            self.textColor = Color("LunchTextColor")//Moss
            self.backgroundColor = Color("LunchBackgroundColor")
        }
        else if title == "Перекус" {
            self.textColor = Color("PoldnikTextColor") //Tangerine
            self.backgroundColor = Color("PoldnikBackgroundColor")
        }
        else {
            self.textColor = Color("DinnerTextColor") //Maroon
            self.backgroundColor = Color("DinnerBackgroundColor")
        }
    }
    
    
    var body: some View {
        
        
        HStack {
            HStack {
                
                NavigationLink {
                    ContentOfFoodIntakeView(foodIntake: foodIntake)
                } label: {
                    Text(title)
                        .foregroundStyle(Color(textColor))
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                Menu {
                    NavigationLink {
                        AddReactionToFoodIntakeView(foodIntake: foodIntake)
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Реакция")
                        }
                    }
                    
                    NavigationLink {
                        AddProductToFoodIntakeView(foodIntake: foodIntake)
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Продукт")
                        }
                    }
                    
                    NavigationLink {
                        AddMealToFoodIntakeView(foodIntake: foodIntake)
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
            
            Button {
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
