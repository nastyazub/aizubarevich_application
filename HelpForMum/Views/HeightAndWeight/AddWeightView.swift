//
//  AddWeightView.swift
//  HelpForMum
//
//  Created by Настя on 04.11.2024.
//

import SwiftUI

struct AddWeightView: View {
    
    @Environment(WeightViewModel.self) var weight_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    let date: Date
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    TextField("Вес в килограммах...", text: $textFieldText)
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("кг")
                }
                
                
                Button("Готово") {
                    if textFieldText.count > 0{
                        textFieldText = textFieldText.replacingOccurrences(of: ",", with: ".")
                        if let weight = Double(textFieldText) {
                            if weight >= 0 {
                                weight_vm.addWeight(weight: weight, date: date)
                                dismiss()
                            }
                        }
                        
                    }
                    
                }
                .font(.title2)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("Добавление веса")
        }
    }
}

#Preview {
    AddWeightView(date: Date())
        .environment(WeightViewModel())
}
