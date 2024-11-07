//
//  ReactionsView.swift
//  HelpForMum
//
//  Created by Настя on 31.10.2024.
//

import SwiftUI

struct ReactionsView: View {
    
    @Environment(ReactionViewModel.self) var reaction_vm
    @Environment(ProductViewModel.self) var product_vm
    @Environment(Analytics.self) var analytics
    @State var reactions: [ReactionEntity] = []
    
    var body: some View {
        NavigationStack {
            if reactions.isEmpty {
                Spacer()
                Text("Пока не добавлено ни одной реакции ни в один из приёмов пищи.")
                    .foregroundStyle(Color.secondary)
                    .padding(.horizontal)
                Spacer()
            } else {
                ScrollView {
                    VStack {
                        ForEach(reactions) { reaction in
                            let countAll = analytics.countAll(reaction: reaction)
                            if countAll != 0 {
                                let countProduct = analytics.countForProduct(reaction: reaction)
                                let h = Double(countProduct.first!.value) / Double(countAll) * 100
                                let k = countProduct.first!.key
                                NavigationLink {
                                    EachReactionView(countProduct: countProduct, countAll: countAll, reaction: reaction)
                                } label: {
                                    RectangleView(reaction: reaction, percent: Int(h), product: k.name!)
                                }
                                
                            }
                        }
                    }
                }
                .navigationTitle("Реакции")
            }
        }
        .onAppear {
            reactions = reaction_vm.reactions
        }
    }
}

struct RectangleView: View {
    let reaction: ReactionEntity
    let percent: Int
    let product: String
    
    var body: some View {
        VStack {
            Text(reaction.name!)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.horizontal)
                .padding(.top)
            
            HStack {
                Text("\(product):")
                    .font(.callout)
                    .foregroundStyle(Color.secondary)
                Text("\(percent)%")
                    .font(.callout)
                    .foregroundStyle(Color.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color("BlackOrWhiteColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .secondary, radius: 10)
        .padding()
    }
}

struct EachReactionView: View {
    
    let countProduct: [Dictionary<ProductEntity, Int>.Element]
    let countAll: Int
    let reaction: ReactionEntity
    
    var table = [(String, Int)]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(countProduct, id: \.key) { el in
                    HStack {
                        let percent = Int(Double(el.value) / Double(countAll) * 100)
                        Text(el.key.name!)
                            .badge("\(percent)%")
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .navigationTitle(reaction.name!)
        }
    }
}

#Preview {
    ReactionsView()
        .environment(ReactionViewModel())
        .environment(Analytics())
        .environment(ProductViewModel())
}

