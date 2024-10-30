//
//  TabView.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//

import SwiftUI

struct TabViewOfAll: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                }
        }
    }
}

#Preview {
    TabViewOfAll()
        .environment(FoodIntakeViewModel())
        .environment(TimeOfFoodViewModel())
        .environment(ProductViewModel())
}
