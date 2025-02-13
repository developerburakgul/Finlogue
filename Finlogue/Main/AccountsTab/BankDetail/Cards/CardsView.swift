//
//  CardsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct CardsView: View {
    @State var isShowAddCardView: Bool = false
    let bank: Bank
    var body: some View {
        VStack {
            
            NavigationLink {
                CreateCardView(bank: bank)
            } label: {
                addCardButton
                    .padding(.top)
            }

            cardList
        }
    }
    
    private var addCardButton: some View {
        VStack(spacing: 4) {
            Image(systemName: "plus")
                .imageScale(.large)
            Text("Add Card")
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(
            addCardButtonBackground
        )
        
    }
    
    private var addCardButtonBackground: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(
                Color.black,
                style: StrokeStyle(
                    lineWidth: 1.5,
                    dash: [8]
                )
            )
            .padding(.horizontal)
    }
    
    private var cardList: some View {
        return ScrollView {
            ForEach(0..<10, id: \.self) { item in
//                CardView(card: Card.getRandomCard())
                Text("BB")
            }
        }
    }
}

#Preview("1") {
    NavigationStack {
        CardsView(bank: Bank.getRandomBank())
    }
    
}
#Preview("2") {
    NavigationStack {
        BankView(
            bank: Bank(name: "Deneme")
        )
    }
}
