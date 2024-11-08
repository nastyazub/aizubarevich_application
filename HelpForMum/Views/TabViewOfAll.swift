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
            
            ListView()
                .tabItem {
                    Image(systemName: "menucard")
                }
            
            MealsView()
                .tabItem {
                    Image(systemName: "fork.knife")
                }
            
            ContactWithDeveloperView()
                .tabItem {
                    Image(systemName: "mail.fill")
                }
        }
    }
}

#Preview {
    TabViewOfAll()
        .environment(FoodIntakeViewModel())
        .environment(TimeOfFoodViewModel())
        .environment(ProductViewModel())
        .environment(Analytics())
        .environment(HeightViewModel())
        .environment(WeightViewModel())
        .environment(MealViewModel())
}
