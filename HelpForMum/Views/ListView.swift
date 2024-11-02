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
            }
        }
    }
}

#Preview {
    ListView()
}
