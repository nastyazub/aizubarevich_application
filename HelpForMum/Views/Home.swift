//
//  Home.swift
//  HelpForMum
//
//  Created by Настя on 12.08.2024.
//

// Страница Home. Здесь ведётся календарь.

import SwiftUI

struct Home: View {
    
    // MARK: СВОЙСТВА
    
    // Среды
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    @Environment(HeightViewModel.self) var height_vm
    
    //Календарь
    let calendar = Calendar.current
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023)) ?? Date()
    let endingDate: Date = Date()
    
    @State var showCalendar: Bool = false
    @State var dateComponents = DateComponents()
    @State var selectedDate = Date()
    
    // MARK: ТЕЛО
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                        Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                        
                        HeightAndWeightView(selectedDate: selectedDate) // Показывабтся рост и вес
                        
                        ForEach(foodIntake_vm.foodIntakes) { foodIntake in
                            if foodIntake.date == selectedDate {
                                BreakfastLunchPoldnikDinnerHelp(foodIntake: foodIntake) // Дизайн приёма пищи
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
                                .frame(width: 80)
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
            let simpleDate = calendar.dateComponents([.day, .month, .year], from: selectedDate) // Сделано, чтобы дата была без привязке к времени.
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
        .environment(HeightViewModel())
        .environment(WeightViewModel())
}
