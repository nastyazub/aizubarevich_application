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
    
    @State var showAlert: Bool = false
    
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
                        reaction_vm.addReaction(name: textFieldText)
                        dismiss()
                    } else {
                        showAlert = true
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
                .alert("Неправильный ввод", isPresented: $showAlert) {
                    Button("Ок", role: .cancel) { }
                } message: {
                    Text("Нельзя оставить поле пустым. Введите название продукта")
                }
                
                
//                Button("Готово") {
//                    if textFieldText.count > 1 {
//                        reaction_vm.addReaction(name: textFieldText)
//                        dismiss()
//                    }
//                }
//                .font(.title2)
//                .foregroundStyle(Color.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
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
