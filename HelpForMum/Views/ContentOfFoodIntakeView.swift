//
//  ContentOfFoodIntakeView.swift
//  HelpForMum
//
//  Created by Настя on 31.08.2024.
//

import SwiftUI

struct ContentOfFoodIntakeView: View {
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    @Environment(ProductViewModel.self) var product_vm
    let foodIntake: FoodIntakeEntity
    
    var body: some View {
        NavigationStack {
            if let products = foodIntake.products?.allObjects as? [ProductEntity] {
                if products.isEmpty {
                    Text("Продуктов и реакций нет")
                        .foregroundStyle(Color.gray)
                } else {
                    ProductsInFoodIntakeView(products: products, foodIntake: foodIntake)
                    ReactionsInFoodIntakeView(foodIntake: foodIntake)
                        .navigationTitle(foodIntake.type_of_time?.name ?? "")
                }
            }
        }
    }
}

#Preview {
    SubViewForPreview_ContentOfFoodIntake()
        .environment(FoodIntakeViewModel())
        .environment(ProductViewModel())
        .environment(ReactionViewModel())
}

struct SubViewForPreview_ContentOfFoodIntake: View {
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    var body: some View {
        ContentOfFoodIntakeView(foodIntake: foodIntake_vm.foodIntakes[0])
    }
}

struct ProductsInFoodIntakeView: View {
    
    let products: [ProductEntity]
    let foodIntake: FoodIntakeEntity
    @Environment(ProductViewModel.self) var product_vm
    
    var body: some View {
        let products = products.sorted() {$0.name! < $1.name!}
        Text("Продукты")
            .fontWeight(.bold)
        List {
            ForEach(products) { product in
                Text(product.name!)
            }
            .onDelete(perform: { indexSet in
                product_vm.deleteFromFoodIntake(at: indexSet, foodIntake: foodIntake)
            })
        }
        .listStyle(.grouped)
    }
}

struct ReactionsInFoodIntakeView: View {
    @Environment(FoodIntakeViewModel.self) var foodIntake_vm
    @Environment(ReactionViewModel.self) var reaction_vm
    let foodIntake: FoodIntakeEntity
    
    var body: some View {
        if let reactions = foodIntake.reactions?.allObjects as? [ReactionEntity] {
            if reactions.isEmpty {
                Text("Реакций нет")
                Spacer()
            } else {
                let reactions = reactions.sorted() {$0.name! < $1.name!}
                Text("Реакции")
                    .fontWeight(.bold)
                List {
                    ForEach(reactions) { reaction in
                        Text(reaction.name!)
                    }
                    .onDelete(perform: { indexSet in
                        reaction_vm.deleteFromFoodIntake(at: indexSet, foodIntake: foodIntake)
                    })
                }
                .listStyle(.grouped)
            }
        }
    }
}
