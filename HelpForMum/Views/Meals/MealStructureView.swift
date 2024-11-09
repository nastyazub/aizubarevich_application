//
//  MealStructureView.swift
//  HelpForMum
//
//  Created by Настя on 06.11.2024.
//

// Страница просмотра, изменение, добавления состава блюда.

import SwiftUI

struct MealStructureView: View {
    
    // Среды
    @Environment(ProductViewModel.self) var product_vm
    @Environment(\.dismiss) var dismiss
    
    let meal: MealEntity // Блюдо
    
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

// MARK: ДОБАВЛЕННЫЕ ПРОДУКТЫ
// Список добавленнных в блюдо продуктов
struct ProductsInMealView: View {
    
    @Environment(ProductViewModel.self) var product_vm
    let meal: MealEntity
    
    var body: some View {
        NavigationStack {
            if let products = meal.products?.allObjects as? [ProductEntity] {
                if products.isEmpty {
                    Text("Пока нет добавленных в состав продуктов.")
                        .foregroundStyle(Color.secondary)
                        .navigationTitle("Состав")
                } else {
                    List {
                        let products = products.sorted() {$0.name! < $1.name!} // сортировка по алфавиту
                        ForEach(products) { product in
                            Text(product.name ?? "")
                        }
                        .onDelete(perform: { indexSet in
                            for offset in indexSet {
                                let productsSorted = product_vm.sortProductsForMeal(meal: meal)
                                let product = productsSorted[offset]
                                product_vm.deleteFromMeal(product: product, meal: meal)
                            }
                        })
                    }
                    .listStyle(.plain)
                    .navigationTitle("Состав")
                }
            }
        }
    }
}

// MARK: ПРОДУКТЫ ДОБАВЛЕНИЯ
// Список продуктов, которых можно добавить в блюдо.
struct ProductForAdding: View {
    
    // Среда
    @Environment(ProductViewModel.self) var product_vm
    
    @State var textFieldText: String = ""
    let meal: MealEntity
    
    
    var body: some View {
        NavigationStack {
            // Поле поиска
            HStack {
                TextField("Название продукта...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                Button(action: {
                    if !textFieldText.isEmpty {
                        let product = product_vm.addProduct(name: textFieldText)[0]
                        product_vm.addProductToMeal(product: product, meal: meal)
                        textFieldText = ""
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .padding(.trailing)
                })
            }
            .navigationTitle("Добавление в состав")
            
            // Список
            List {
                let products = meal.products?.allObjects as! [ProductEntity]
                ForEach(product_vm.products.sorted() {$0.name! < $1.name!}) { product in // Сортировка по алфавиту
                    if !products.contains(product) && (product.name!.lowercased().contains(textFieldText.lowercased()) || textFieldText == "") {
                        Text(product.name!)
                            .onTapGesture {
                                product_vm.addProductToMeal(product: product, meal: meal)
                            }
                    }
                }
            }
            .listStyle(.plain)
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
