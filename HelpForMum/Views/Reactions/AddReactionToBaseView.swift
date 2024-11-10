//
//  AddReactionView.swift
//  HelpForMum
//
//  Created by Настя on 26.08.2024.
//

// Страница добавления реакции в базу данных.

import SwiftUI

struct AddReactionToBaseView: View {
    
    // Среды
    @Environment(ReactionViewModel.self) var reaction_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    @State var showAlertEmpty: Bool = false
    @State var showAlertSameName: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                TextField("Напишите название реакции...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    if textFieldText.count > 1 {
                        var flag = true
                        for reaction in reaction_vm.reactions {
                            if reaction.name == textFieldText {
                                flag = false
                            }
                        }
                        if flag {
                            reaction_vm.addReaction(name: textFieldText)
                            dismiss()
                        } else {
                            showAlertSameName = true
                        }
                        
                    } else {
                        showAlertEmpty = true
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
                .alert("Неправильный ввод", isPresented: $showAlertEmpty) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Нельзя оставить поле пустым. Введите название реакции")
                }
                
                .alert("Неверный ввод", isPresented: $showAlertSameName) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Реакция с таким названием уже существует.")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Добавление реакции")
        }
    }
}

#Preview {
    AddReactionToBaseView()
        .environment(ReactionViewModel())
}
