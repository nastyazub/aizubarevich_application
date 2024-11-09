//
//  ListView.swift
//  HelpForMum
//
//  Created by Настя on 02.11.2024.
//

// Страница, через которую можно перейти к аналитике. И к аналитике реакций и к графикам роста и веса.

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ReactionsView() // Переход к реакциям
                } label: {
                    Text("Реакции")
                }
                
                NavigationLink {
                    ChartView() // Переход к графикам
                } label: {
                    Text("Посмотреть графики")
                }

            }
        }
    }
}

#Preview {
    ListView()
}
