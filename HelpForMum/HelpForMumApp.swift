//
//  HelpForMumApp.swift
//  HelpForMum
//
//  Created by Настя on 07.08.2024.
//

import SwiftUI

@main
struct HelpForMumApp: App {
    var body: some Scene {
        WindowGroup {
            TabViewOfAll()
                .environment(ProductViewModel())
                .environment(FoodIntakeViewModel())
                .environment(TimeOfFoodViewModel())
                .environment(ReactionViewModel())
                .environment(Analytics())
                .environment(HeightViewModel())
                .environment(WeightViewModel())
                .environment(MealViewModel())
        }
    }
}
