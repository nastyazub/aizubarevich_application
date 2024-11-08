//
//  AddHeightView.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

import SwiftUI

struct AddHeightView: View {
    
    @State var textFieldText: String = ""
    @Environment(HeightViewModel.self) var height_vm
    @Environment(\.dismiss) var dismiss
    
    let date: Date
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    TextField("Рост в сантиметрах...", text: $textFieldText)
                        .font(.title2)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("см")
                }
                
                
                Button("Готово") {
                    if textFieldText.count > 0 {
                        if let height = Int(textFieldText) {
                            if height >= 0 {
                                height_vm.addHeight(height: height, date: date)
                                dismiss()
                            }
                        }
                        
                    }
                    
                }
                .font(.title2)
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("Добавление роста")
        }
    }
}

#Preview {
    AddHeightView(date: Date())
        .environment(HeightViewModel())
}
