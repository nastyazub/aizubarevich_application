//
//  HeightAndWeightView.swift
//  HelpForMum
//
//  Created by Настя on 03.11.2024.
//

import SwiftUI

struct HeightAndWeightView: View {
    @Environment(HeightViewModel.self) var height_vm
    @Environment(WeightViewModel.self) var weight_vm
    let selectedDate: Date
    @State var flag: Bool = true
    @State var listOfHeights = []
    
    var body: some View {
        VStack {
            ForEach(height_vm.heights) { height in
                if height.date == selectedDate {
                    Text("Рост: \(height.height) см")
                }
            }
            
            ForEach(weight_vm.weights) { weight in
                if weight.date == selectedDate {
                    Text("Вес: \(weight.weight, specifier: "%.3f") кг")
                        .padding(3)
                }
            }
            
            HStack {
                NavigationLink {
                    AddHeightView(date: selectedDate)
                } label: {
                    Image(systemName: "figure.arms.open")
                        .font(.title)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                
                NavigationLink {
                    AddWeightView(date: selectedDate)
                } label: {
                    Image(systemName: "scalemass.fill")
                        .font(.title2)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color("BlackOrWhiteColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.secondary,radius: 10)
        .padding()
    }
}

#Preview {
    HeightAndWeightView(selectedDate: Date())
        .environment(HeightViewModel())
        .environment(WeightViewModel())
}
