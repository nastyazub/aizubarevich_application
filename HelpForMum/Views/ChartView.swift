//
//  ChartView.swift
//  HelpForMum
//
//  Created by Настя on 05.11.2024.
//

// Страница отображения графиков роста и веса.

import SwiftUI
import Charts

// MARK: ГЛАВНАЯ
// Сама страница
struct ChartView: View {
    
    @State var showHeight: Bool = true
    @State var showWeight: Bool = true

    var body: some View {
        NavigationStack {
            ScrollView {
                
                if showHeight {
                    Text("Рост")
                        .padding(30)
                    ChartHeight() // График роста
                }
                if showWeight {
                    Text("Вес")
                        .padding(30)
                    ChartWeight() // График веса
                }
            }
            .navigationTitle("Графики роста и веса")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu { // Здесь выбирается режим. По умолчанию - "Рост и вес"
                        Button("Рост") {
                            showHeight = true
                            showWeight = false
                        }
                        
                        Button("Вес") {
                            showHeight = false
                            showWeight = true
                        }
                        
                        Button("Рост и вес") {
                            showHeight = true
                            showWeight = true
                        }
                        
                    } label: {
                        Text("Режим")
                    }
                }
            }
        }
    }
}

// MARK: ГРАФИК РОСТА

struct ChartHeight: View {
    
    // Среда
    @Environment(HeightViewModel.self) var height_vm
    
    let calendar = Calendar.current
    
    @State var heights: [HeightEntity] = []
    @State var chartSelection: Date? // Если выбирается точка на графике, то дата - chartSelection
    
    var body: some View {
        if height_vm.heights.isEmpty {
            Text("Пока нет значений роста")
                .foregroundStyle(Color.secondary)
                .frame(height: 300)
        } else {
            Chart(heights.sorted() {$0.date! < $1.date!}) { height in
                LineMark( // Линейная диаграмма
                    x: .value("Day", height.date!, unit: .day),
                    y: .value("Height", height.height)
                )
                .symbol(.circle)
                .interpolationMethod(.catmullRom)
                
                if let chartSelection {
                    let chartSelectionString = calendar.dateComponents([.day, .month, .year], from: chartSelection)
                    let chartSelectionSort = calendar.date(from: chartSelectionString) // Для того, чтобы по charSelection можно было найти рост
                    
                    if height.date == chartSelectionSort {
                        RuleMark(x: .value("Day", chartSelection, unit: .day))
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .annotation(
                                position: .top,
                                overflowResolution: .init(x: .fit, y: .disabled)
                            ) {
                                Text("\(height.height) см")
                                    .frame(width: 100)
                                    .padding(.vertical)
                                    .background {
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundStyle(Color.blue.opacity(0.6))
                                    }
                            }
                    }
                }
            }
            .chartXSelection(value: $chartSelection)
            .frame(height: 300)
            .padding()
            .onAppear {
                heights = height_vm.heights
            }
        }
    }
}

// MARK: ГРАФИК ВЕСА

struct ChartWeight: View {
    
    // Среда
    @Environment(WeightViewModel.self) var weight_vm
    
    let calendar = Calendar.current
    
    @State var weights: [WeightEntity] = []
    @State var chartSelection: Date? // Если выбирается точка на графике, то дата - chartSelection
    
    var body: some View {
        if weight_vm.weights.isEmpty {
            Text("Пока нет значений веса")
                .foregroundStyle(Color.secondary)
                .frame(height: 300)
        } else {
            Chart(weights.sorted() {$0.date! < $1.date!}) { weight in
                LineMark( // Линейная диаграмма
                    x: .value("Day", weight.date!, unit: .day),
                    y: .value("Weight", weight.weight)
                )
                .symbol(.circle)
                .interpolationMethod(.catmullRom)
                
                if let chartSelection {
                    let chartSelectionString = calendar.dateComponents([.day, .month, .year], from: chartSelection)
                    let chartSelectionSort = calendar.date(from: chartSelectionString) // Для того, чтобы по charSelection можно было найти вес
                    
                    if weight.date == chartSelectionSort {
                        RuleMark(x: .value("Day", chartSelection, unit: .day))
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .annotation(
                                position: .top,
                                overflowResolution: .init(x: .fit, y: .disabled)
                            ) {
                                Text("\(weight.weight, specifier: "%.3f") кг")
                                    .frame(width: 100)
                                    .padding(.vertical)
                                    .background {
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundStyle(Color.blue.opacity(0.6))
                                    }
                            }
                    }
                }
            }
            .chartXSelection(value: $chartSelection)
            .frame(height: 300)
            .padding()
            .onAppear {
                weights = weight_vm.weights
            }
        }
        
        
    }
}

#Preview {
    ChartView()
        .environment(HeightViewModel())
        .environment(WeightViewModel())
}
