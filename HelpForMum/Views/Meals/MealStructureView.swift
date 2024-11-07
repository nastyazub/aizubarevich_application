//
//  MealStructureView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

import SwiftUI

struct MealStructureView: View {
    
    @Environment(ProductViewModel.self) var product_vm
    @Environment(\.dismiss) var dismiss
    let meal: MealEntity
    
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink ("Добавленные продукты") {
                    ProductsInMealView(meal: meal)
                }
                
                NavigationLink ("Добавить продукты") {
                    ProductForAdding(meal: meal)
                }
            }
            .navigationTitle(meal.name ?? "")
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.primary)
                })
            }
        }
    }
}

struct ProductsInMealView: View {
    
    @Environment(ProductViewModel.self) var product_vm
    let meal: MealEntity
    
    var body: some View {
        List {
            if let products = meal.products?.allObjects as? [ProductEntity] {
                let products = products.sorted() {$0.name! < $1.name!}
                ForEach(products) { product in
                    Text(product.name ?? "")
                }
                .onDelete(perform: { indexSet in
                    product_vm.deleteFromMeal(at: indexSet, meal: meal)
                })
            }
            
        }
    }
}

struct ProductForAdding: View {
    
    @Environment(ProductViewModel.self) var product_vm
    @State var textFieldText: String = ""
    let meal: MealEntity
    
    
    var body: some View {
        HStack {
            TextField("Название продукта", text: $textFieldText)
            
            Button(action: {
                let product = product_vm.addProduct(name: textFieldText)[0]
                product_vm.addProductToMeal(product: product, meal: meal)
                textFieldText = ""
            }, label: {
                Image(systemName: "plus.circle.fill")
            })
        }
        List {
            let products = meal.products?.allObjects as! [ProductEntity]
            ForEach(product_vm.products) { product in
                if !products.contains(product) && (product.name!.lowercased().contains(textFieldText.lowercased()) || textFieldText == "") {
                    Text(product.name!)
                        .onTapGesture {
                            product_vm.addProductToMeal(product: product, meal: meal)
                        }
                }
            }
        }
    }
}

struct subViewForPreview_MealStructure: View {
    @Environment(MealViewModel.self) var meal_vm
    @State var test: Bool = true
    
    var body: some View {
        MealStructureView(meal: meal_vm.meals[0])
    }
}

#Preview {
    subViewForPreview_MealStructure()
        .environment(ProductViewModel())
        .environment(MealViewModel())
}
