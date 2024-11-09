//
//  TabView.swift
//  HelpForMum
//
//  Created by Настя on 22.09.2024.
//

// View, который является главной страницей приложения. Через него можно перейти во все другие View.

import SwiftUI

struct TabViewOfAll: View {
    var body: some View {
        TabView {
            Home() // Страница с календарём
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            ListView() // Аналитика расположена здесь
                .tabItem {
                    Image(systemName: "menucard")
                }
            
            MealsView() // Посмотреть, добавить, изменить, удалить блюда можно здесь
                .tabItem {
                    Image(systemName: "fork.knife")
                }
            
            ContactWithDeveloperView() // Страница для написания письма по почте разработчику
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
