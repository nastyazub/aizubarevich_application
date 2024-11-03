//
//  Home.swift
//  HelpForMum
//
//  Created by Настя on 12.08.2024.
//

import SwiftUI

struct Home: View {
    @State var food: [FoodIntakeEntity] = []
    
    //Цвета приёмов пищи
    let myColor1 = #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1) // Plum
    let myColor2 = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1) //Moss
    let myColor3 = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1) //Tangerine
    let myColor4 = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1) //Maroon
    
    //Календарь
    let calendar = Calendar.current
    
    @State var showCalendar: Bool = false
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate: Date = Date()
    
    @Environment(FoodIntakeViewModel.self) var vm
    
    @State var dateComponents = DateComponents()
    @State var selectedDate = Date()
    
    @State var showAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                        Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                        ForEach(vm.foodIntakes) { foodIntake in
                            if foodIntake.date == selectedDate {
                                BreakfastLunchPoldnikDinnerHelp(foodIntake: foodIntake, showAlert: $showAlert)
                            }
                        }
                        
                        NavigationLink {
                            AddFoodIntakeView(date: selectedDate)
                        } label: {
                            Text("+")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .padding()
                        }
                    }
                }
                .navigationTitle("Календарь")
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            self.showCalendar.toggle()
                        }, label: {
                            Image(systemName: "calendar")
                                .font(.title2)
                        })
                        .popover(isPresented: $showCalendar, content: {
                            DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: .date)
                                .padding()
                                .presentationCompactAdaptation(.popover)
                        })
                    }
            }
        }
        .onAppear {
            let simpleDate = calendar.dateComponents([.day, .month, .year], from: selectedDate)
            selectedDate = calendar.date(from: simpleDate)!
        }
    }
}

#Preview {
    Home()
        .environment(FoodIntakeViewModel())
        .environment(TimeOfFoodViewModel())
        .environment(ProductViewModel())
        .environment(ReactionViewModel())
}
