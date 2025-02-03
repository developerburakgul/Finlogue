//
//  CardView.swift
//  Finlogue
//
//  Created by Burak Gül on 28.01.2025.
//
import Foundation
import SwiftUI

struct CardView: View {
    @State var isGoToCreateCard: Bool = false
    let card: Card
    init(card: Card) {
        self.card = card
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "chart.bar.xaxis")
                    .imageScale(.large)
                    .onTapGesture {
                        isGoToCreateCard = true
                    }
                Spacer()
                Text(card.cardType.name)
                    .bold()
            }
            Spacer()
            HStack {
                Text(card.cardNumber)
                    .font(.title2)
                    .bold()
                Image(systemName: "document.on.document")
                    .imageScale(.small)
                Spacer()
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 0) {
                currentBalance
                Spacer()
                Text(card.expireDateString)
                    .bold()
            }
            
            
        }
        .sheet(isPresented: $isGoToCreateCard) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.red)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(height: 200)
        .background(
            VisualEffectView(
                effect: UIBlurEffect(
                    style: .systemThinMaterialDark
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .padding() // Dış padding
        
    }
    
    @ViewBuilder
    private var currentBalance: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Current Balance")
                .font(.caption)
                .bold()
            HStack(alignment: .top, spacing: 0) {
                Text("$")
                    .font(.caption2)
                Text("5,000.14")
                    .bold()
                    .font(.title3)
            }
        }
    }
}
#Preview {
    CardView(card: Card.getRandomCard())
}
