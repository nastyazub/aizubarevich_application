//
//  AddHeightView.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

// Страница добавления, удаления, изменения роста.

import SwiftUI

struct AddHeightView: View {
    
    // Среды
    @Environment(HeightViewModel.self) var height_vm
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
                    TextField("Рост в сантиметрах...", text: $textFieldText)
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("см")
                }
                
                Button(action: {
                    if textFieldText.count > 0 {
                        if let height = Int(textFieldText) {
                            if height >= 0 {
                                height_vm.addHeight(height: height, date: date)
                                dismiss()
                            } else {
                                showAlertNonMinus = true
                            }
                        } else {
                            showAlertNonEmpty = true
                        }
                        
                    } else {
                        var flag = true
                        for height in height_vm.heights {
                            if height.date == date {
                                flag = false
                                height_vm.delete(height: height)
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
                    Text("Нельзя ввести отрицательное значение. Введите рост в сантиметрах")
                }
                
                .alert("Неверный ввод", isPresented: $showAlertNonEmpty) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Нельзя оставить поле пустым. Принимаются только целочисленные значения. Введите рост в сантиметрах")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Добавление роста")
        }
    }
}

#Preview {
    AddHeightView(date: Date())
        .environment(HeightViewModel())
}
