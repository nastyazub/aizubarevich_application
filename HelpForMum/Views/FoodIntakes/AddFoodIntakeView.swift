//
//  AddFoodIntakeView.swift
//  HelpForMum
//
//  Created by Настя on 26.10.2024.
//

// Страница выбора типа приёма пищи и одновременно добавление приёма пищи.

import SwiftUI

struct AddFoodIntakeView: View {
    
    // Среды
    @Environment(\.dismiss) var dismiss
    @Environment(TimeOfFoodViewModel.self) var time_vm
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    
    @State var date: Date
    
    var body: some View {
        let times = time_vm.times.sorted() {$0.id < $1.id}
            NavigationStack {
                List {
                    ForEach(times) { time in
                        Text(time.name ?? "")
                            .onTapGesture {
                                foodIntake_vm.addFoodIntake(id: UUID().uuidString, time: time, date: date)
                                dismiss()
                            }
                    }
                }
                .navigationTitle("Выберите тип")
            }
            .onAppear {
                time_vm.addTimes()
            }
        
    }
}

#Preview {
    AddFoodIntakeView(date: Date())
        .environment(TimeOfFoodViewModel())
        .environment(FoodIntakeViewModel())
}
