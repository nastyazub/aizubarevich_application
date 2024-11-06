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
                    List {
                        NavigationLink {
                            
                        } label: {
                            Text("Добавить")
                        }
                        
                        NavigationLink {
                            ChartView()
                        } label: {
                            Text("Посмотреть графики")
                        }


                    }
                } label: {
                    Text("Рост и вес")
                }

            }
        }
    }
}

#Preview {
    ListView()
}
