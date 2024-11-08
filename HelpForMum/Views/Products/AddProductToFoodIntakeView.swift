//
//  AddProductToFoodIntake.swift
//  HelpForMum
//
//  Created by Настя on 19.10.2024.
//

import SwiftUI

struct AddProductToFoodIntakeView: View {
    
    @Environment(ProductViewModel.self) var product_vm
    @Environment(\.dismiss) var dismiss
    let foodIntake: FoodIntakeEntity
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack() {
            if product_vm.products.isEmpty {
                Spacer()
                Text("Пока нет продуктов")
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            else {
                TextField("Напишите название продукта...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                List {
                    ForEach(product_vm.products) { product in
                        if let name = product.name {
                            if name.lowercased().contains(textFieldText.lowercased()) || textFieldText == "" {
                                Text(name)
                                    .onTapGesture {
                                        product_vm.addProductToFoodIntake(product: product, foodIntake: foodIntake)
                                        dismiss()
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button("Удалить") {
                                            product_vm.deleteFromBase(product: product)
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            AddProductButton()
                .navigationTitle(foodIntake.type_of_time?.name ?? "")
        }
    }
}

struct AddProductButton: View {
    var body: some View {
        NavigationLink {
            AddProductToBaseView()
        } label: {
            Text("+ Добавить")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding()
        }
    }
}

struct SubViewForPreview_addProductToFoodIntake: View {
    @Environment(FoodIntakeViewModel.self) var vm
    var body: some View {
        AddProductToFoodIntakeView(foodIntake: vm.foodIntakes[0])
    }
}

#Preview {
    SubViewForPreview_addProductToFoodIntake()
        .environment(ProductViewModel())
        .environment(FoodIntakeViewModel())
}
