//
//  EditReactionView.swift
//  HelpForMum
//
//  Created by Настя on 09.11.2024.
//

import SwiftUI

struct EditReactionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let reaction: ReactionEntity
    
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
                        reaction.name = textFieldText
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
                    Text("Нельзя оставить поле пустым. Введите название реакции")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Изменение реакции")
        }
        .onAppear {
            textFieldText = reaction.name!
        }
    }
}

struct subViewForPreview_EditReaction: View {
    
    @Environment(ReactionViewModel.self) var reaction_vm
    
    var body: some View {
        EditReactionView(reaction: reaction_vm.reactions[0])
    }
}

#Preview {
    subViewForPreview_EditReaction()
        .environment(ReactionViewModel())
}
