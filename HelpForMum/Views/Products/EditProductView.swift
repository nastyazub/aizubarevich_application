//
//  EditProductView.swift
//  HelpForMum
//
//  Created by Настя on 09.11.2024.
//

import SwiftUI

struct EditProductView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let product: ProductEntity
    
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                TextField("Напишите название продукта...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button(action: {
                    if textFieldText.count > 1 {
                        product.name = textFieldText
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
                
                Spacer()
            }
            .padding()
            .navigationTitle("Изменение продукта")
        }
        .onAppear {
            textFieldText = product.name!
        }
    }
}

struct subViewForPreview_EditProduct: View {
    
    @Environment(ProductViewModel.self) var product_vm
    
    var body: some View {
        EditProductView(product: product_vm.products[0])
    }
}

#Preview {
    subViewForPreview_EditProduct()
        .environment(ProductViewModel())
}
