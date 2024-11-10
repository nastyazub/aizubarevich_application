//
//  AddWeightView.swift
//  HelpForMum
//
//  Created by Настя on 04.11.2024.
//

// Страница добавления, удаления, изменения веса.

import SwiftUI

struct AddWeightView: View {
    
    // Среды
    @Environment(WeightViewModel.self) var weight_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    // Индикаторы появления сообщений о неправильном вводе.
    @State var showAlertNonMinus: Bool = false
    @State var showAlertNonEmpty: Bool = false
    
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
                
                
                Button(action: {
                    if textFieldText.count > 0 {
                        textFieldText = textFieldText.replacingOccurrences(of: ",", with: ".")
                        if let weight = Double(textFieldText) {
                            if weight >= 0 {
                                weight_vm.addWeight(weight: weight, date: date)
                                dismiss()
                            }
                        } else {
                            showAlertNonEmpty = true
                        }
                        
                    } else {
                        var flag = true
                        for weight in weight_vm.weights {
                            if weight.date == date {
                                flag = false
                                weight_vm.delete(weight: weight)
                                dismiss()
                            }
                        }
                        if flag {
                            showAlertNonEmpty = true
                        }
                    }
                    
                }, label: {
                    Text("Готово")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                
                .alert("Неверный ввод", isPresented: $showAlertNonMinus) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Нельзя ввести отрицательное значение. Введите вес в килограммах.")
                }
                
                .alert("Неверный ввод", isPresented: $showAlertNonEmpty) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Нельзя оставить поле пустым. Принимаются чиловые значения до трёх цифр после запятой. Введите вес в килограммах")
                }
                
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
