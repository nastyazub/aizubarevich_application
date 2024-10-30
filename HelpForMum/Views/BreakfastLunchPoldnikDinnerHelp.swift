//
//  BreakfastLunchPoldnikDinnerHelp.swift
//  HelpForMum
//
//  Created by Настя on 12.08.2024.
//

import SwiftUI

struct BreakfastLunchPoldnikDinnerHelp: View {
    
    let title: String
    let textColor: UIColor
    let backgroundColor: Color
    let id: String
    let time: TimeOfFoodEntity
    
    let foodIntake: FoodIntakeEntity
    
    @State var showAddMealView: Bool = false
    
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    @Environment(TimeOfFoodViewModel.self) var time_vm
    
    let date: Date
    
    init(foodIntake: FoodIntakeEntity) {
        self.foodIntake = foodIntake
        self.title = (foodIntake.type_of_time?.name)!
        self.id = foodIntake.id!
        self.date = foodIntake.date!
        self.time = foodIntake.type_of_time!
        
        if title == "Завтрак" {
            self.textColor = #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1) //Plum
            self.backgroundColor = .purple
        }
        else if title == "Обед" {
            self.textColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1) //Moss
            self.backgroundColor = .green
        }
        else if title == "Перекус" {
            self.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1) //Tangerine
            self.backgroundColor = .yellow
        }
        else {
            self.textColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1) //Maroon
            self.backgroundColor = .pink
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
                        AddMealView()
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
            .background(Color(backgroundColor).opacity(0.6).clipShape(RoundedRectangle(cornerRadius: 10)))
        .padding(8)
            
            Button {
                foodIntake_vm.delete(foodIntake: foodIntake)
            } label: {
                Image(systemName: "trash")
                    .font(.subheadline)
                    .foregroundStyle(Color(textColor))
            }
            .padding(.trailing)

        }
    }
}

#Preview {
    SubViewForPreview()
        .environment(FoodIntakeViewModel())
        .environment(TimeOfFoodViewModel())
}

struct SubViewForPreview: View {
    @Environment(FoodIntakeViewModel.self) var vm
    
    var body: some View {
            BreakfastLunchPoldnikDinnerHelp(foodIntake: vm.foodIntakes[0])
    }
}
