//
//  ContentOfFoodIntakeView.swift
//  HelpForMum
//
//  Created by Настя on 31.08.2024.
//

// Страница отображения продуктов и реакций приёма пищи

import SwiftUI

struct ContentOfFoodIntakeView: View {
    
    // Среды
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    @Environment(ProductViewModel.self) var product_vm
    
    let foodIntake: FoodIntakeEntity
    
    var body: some View {
        NavigationStack {
            if let products = foodIntake.products?.allObjects as? [ProductEntity] {
                if products.isEmpty {
                    Text("Продуктов и реакций нет")
                        .foregroundStyle(Color.secondary)
                } else {
                    HStack {
                        ProductsAndReactionsInFoodIntakeView(products: products, foodIntake: foodIntake)
                            .padding(.top)
                    }
                    .navigationTitle(foodIntake.type_of_time?.name ?? "")
                }
            }
        }
    }
}

// MARK: ПРОДУКТЫ И РЕАКЦИИ
// Список продуктов и реакций
struct ProductsAndReactionsInFoodIntakeView: View {
    
    // Среды
    @Environment(ProductViewModel.self) var product_vm
    @Environment(ReactionViewModel.self) var reaction_vm
    
    let products: [ProductEntity]
    let foodIntake: FoodIntakeEntity
    
    var body: some View {
        let products = products.sorted() {$0.name! < $1.name!}
        VStack {
            List {
                Section {
                    ForEach(products) { product in
                        Text(product.name!)
                    }
                    .onDelete(perform: { indexSet in
                        product_vm.deleteFromFoodIntake(at: indexSet, foodIntake: foodIntake)
                    })
                } header: {
                    Text("Продукты")
                }
                
                Section {
                    if let reactions = foodIntake.reactions?.allObjects as? [ReactionEntity] {
                        let reactions = reactions.sorted() {$0.name! < $1.name!}
                        ForEach(reactions) { reaction in
                            Text(reaction.name!)
                        }
                        .onDelete(perform: { indexSet in
                            reaction_vm.deleteFromFoodIntake(at: indexSet, foodIntake: foodIntake)
                        })
                    }
                } header: {
                    Text("Реакции")
                }
            }
            .listStyle(.inset)
        }
    }
}

// Дополнительый view для того, чтобы передать элемент базы данных.
struct SubViewForPreview_ContentOfFoodIntake: View {
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    var body: some View {
        ContentOfFoodIntakeView(foodIntake: foodIntake_vm.foodIntakes[0])
    }
}

#Preview {
    SubViewForPreview_ContentOfFoodIntake()
        .environment(FoodIntakeViewModel())
        .environment(ProductViewModel())
        .environment(ReactionViewModel())
}
