//
//  AddMealView2.swift
//  HelpForMum
//
//  Created by Настя on 31.08.2024.
//

import SwiftUI

struct AddMealView2: View {
    @State var textFieldText: String = ""
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                Text("Добавление блюда")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom)
                
                TextField("Напишите название блюда...", text: $textFieldText)
                    .font(.title2)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                Button("Готово") {
                    //скоро будет
                }
                .font(.title2)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("Добавить новое блюдо") {
                    //скоро будет
                }
                .font(.title2)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.white)
                    .padding()
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            )
        }
    }
}

#Preview {
    AddMealView2()
}
