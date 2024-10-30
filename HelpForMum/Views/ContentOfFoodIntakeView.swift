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
                    Text("Продуктов нет")
                } else {
                    ProductsInFoodIntakeView(products: products, foodIntake: foodIntake)
                }
            }
        }
    }
}

#Preview {
    SubViewForPreview_ContentOfFoodIntake()
        .environment(FoodIntakeViewModel())
        .environment(ProductViewModel())
}

struct SubViewForPreview_ContentOfFoodIntake: View {
    @Environment(FoodIntakeViewModel.self) var vm
    var body: some View {
        ContentOfFoodIntakeView(foodIntake: vm.foodIntakes[0])
    }
}

struct ProductsInFoodIntakeView: View {
    
    let products: [ProductEntity]
    let foodIntake: FoodIntakeEntity
    @Environment(ProductViewModel.self) var product_vm
    
    var body: some View {
        let products = products.sorted() {$0.name! < $1.name!}
        List {
            ForEach(products) { product in
                Text(product.name ?? "")
            }
            .onDelete(perform: { indexSet in
                product_vm.deleteFromFoodIntake(at: indexSet, foodIntake: foodIntake)
            })
        }
    }
}
