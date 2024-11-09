//
//  AddProductView.swift
//  HelpForMum
//
//  Created by Настя on 26.08.2024.
//

// Страница добавления продуктов в базу данных.

import SwiftUI

struct AddProductToBaseView: View {
    
    //Среды
    @Environment(ProductViewModel.self) var products_vm
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                TextField("Напишите название продукта...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("Готово") {
                    if textFieldText.count > 1 {
                        _ = products_vm.addProduct(name: textFieldText)[0]
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
            .navigationTitle("Добавление продукта")
        }
    }
}

#Preview {
    AddProductToBaseView()
        .environment(ProductViewModel())
}
