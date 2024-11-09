//
//  AddProductToFoodIntake.swift
//  HelpForMum
//
//  Created by Настя on 19.10.2024.
//

// Страница добавления продуктов в приём пищи.

import SwiftUI

struct AddProductToFoodIntakeView: View {
    
    // Среды
    @Environment(ProductViewModel.self) var product_vm
    @Environment(\.dismiss) var dismiss
    
    let foodIntake: FoodIntakeEntity // Приём пищи
    
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
                    ForEach(product_vm.products.sorted() {$0.name! < $1.name!}) { product in // Сортировка по алфавиту
                        if let name = product.name {
                            if name.lowercased().contains(textFieldText.lowercased()) || textFieldText == "" { // Проверка соответсвтвия значению в поиске
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

// Кнопка добавления продукта в базу данных
struct AddProductButton: View {
    var body: some View {
        NavigationLink {
            AddProductToBaseView() // Страница добавления продукта в базу данных
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

// Дополнительный view, для того чтобы ввести значение из базы данных
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
