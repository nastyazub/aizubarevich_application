//
//  ListView.swift
//  HelpForMum
//
//  Created by Настя on 02.11.2024.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ReactionsView()
                } label: {
                    Text("Реакции")
                }
                
                NavigationLink {
                    ChartView()
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
