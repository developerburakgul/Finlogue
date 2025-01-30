//
//  CardsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { item in
                CardView(card: Card.getRandomCard())
            }
        }
    }
}

#Preview("1") {
    CardsView()
}
#Preview("2") {
    BankView(
        bank: Bank(name: "Deneme")
    )
}
