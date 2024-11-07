//
//  AddReactionView.swift
//  HelpForMum
//
//  Created by Настя on 26.08.2024.
//

import SwiftUI

struct AddReactionToBaseView: View {
    
    @Environment(ReactionViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                TextField("Напишите название реакции...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Button("Готово") {
                    if textFieldText.count > 1 {
                        vm.addReaction(name: textFieldText)
                        dismiss()
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
            .navigationTitle("Добавление реакции")
        }
    }
}

#Preview {
    AddReactionToBaseView()
        .environment(ReactionViewModel())
}
