//
//  AddProductToFoodIntake.swift
//  HelpForMum
//
//  Created by Настя on 19.10.2024.
//

import SwiftUI

struct AddProductToFoodIntakeView: View {
    
    @Environment(ProductViewModel.self) var vm
    @Environment(\.dismiss) var dismiss
    let foodIntake: FoodIntakeEntity
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack() {
            if vm.products.isEmpty {
                Text("No products yet")
            }
            else {
                    TextField("Напишите название продукта...", text: $textFieldText)
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                List {
                    ForEach(vm.products) { product in
                        if product.name!.contains(textFieldText) || textFieldText == "" {
                            Text(product.name!)
                                .onTapGesture {
                                    vm.addProductToTime(product: product, foodIntake: foodIntake)
                                    dismiss()
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

#Preview {
    SubViewForPreview_addProductToFoodIntake()
        .environment(ProductViewModel())
        .environment(FoodIntakeViewModel())
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
                .background(Color.purple)
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
