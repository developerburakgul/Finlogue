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
    var showCardDetailLogo: Bool = true
    init(card: Card, showCardDetailLogo: Bool = true) {
        self.card = card
        self.showCardDetailLogo = showCardDetailLogo
    }
    
    var body: some View {
        ZStack {
            VisualEffectView(
                effect: UIBlurEffect(style: .dark)
            )
            
            // Renk overlay
//            Color(card.overlayColor)
            
            // İçerik
            content
        }
        .sheet(isPresented: $isGoToCreateCard) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.red)
                .frame(maxWidth: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(height: 200)
        .padding()
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            Spacer()
            cardNumberSection
            Spacer()
            footer
        }
        .padding()
        .frame(height: 200)
//        .foregroundColor(card.textColor)
    }
    
    private var headerView: some View {
        HStack {
            if showCardDetailLogo {
                Image(systemName: "chart.bar.xaxis")
                    .imageScale(.large)
                    .onTapGesture {
                        isGoToCreateCard = true
                    }
            }
            Spacer()
            Text(card.cardType.name)
                .bold()
        }
    }
    
    private var cardNumberSection: some View {
        HStack {
            if let cardNumber = card.cardNumber {
                Text(cardNumber)
                    .font(.title2)
                    .bold()
                Image(systemName: "document.on.document")
                    .imageScale(.small)
                Spacer()
            }
            
        }
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
                Text(card.currentBalance.formatted())
                    .bold()
                    .font(.title3)
            }
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom, spacing: 0) {
            currentBalance
            Spacer()
            Text(DateFormatter.expireDateString(for: card.expireDate))
                .bold()
        }
    }
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            HStack {
//                Image(systemName: "chart.bar.xaxis")
//                    .imageScale(.large)
//                    .onTapGesture {
//                        isGoToCreateCard = true
//                    }
//                Spacer()
//                Text(card.cardType.name)
//                    .bold()
//            }
//            Spacer()
//            HStack {
//                if let cardNumber = card.cardNumber {
//                    Text(cardNumber)
//                        .font(.title2)
//                        .bold()
//                    Image(systemName: "document.on.document")
//                        .imageScale(.small)
//                    Spacer()
//                }
//                
//            }
//            Spacer()
//            HStack(alignment: .bottom, spacing: 0) {
//                currentBalance
//                Spacer()
//                Text(card.expireDateString)
//                    .bold()
//            }
//        }
//        .sheet(isPresented: $isGoToCreateCard) {
//            RoundedRectangle(cornerRadius: 3)
//                .fill(Color.red)
//                .frame(maxWidth: .infinity)
//        }
//        .padding()
//        .frame(height: 200)
//        .background(
//            VisualEffectView(
//                effect: UIBlurEffect(
//                    style: .systemThinMaterialDark
//                )
//            )
//            .clipShape(RoundedRectangle(cornerRadius: 16))
//        )
//        .padding() // Dış padding
//        
//    }
    

    

}



//#Preview {
//    CardView(card: Card.getRandomCard())
//}
