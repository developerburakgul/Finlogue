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
    var cardModel: CardModelProtocol
    var showCardDetailLogo: Bool = true

    init(cardModel: CardModelProtocol, showCardDetailLogo: Bool) {
        self.cardModel = cardModel
        self.showCardDetailLogo = showCardDetailLogo
    }
    
    var body: some View {
        ZStack {
            VisualEffectView(
                effect: UIBlurEffect(style: .dark)
            )
            
            // Renk overlay
            Color(cardModel.overlayColorData.toColor())
            
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
        .foregroundColor(cardModel.textColorData.toColor())
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
            Text("\(cardModel.cardType.name)")
                .bold()
        }
    }
    
    private var cardNumberSection: some View {
        HStack {
            if let cardNumber = cardModel.cardNumber, !cardNumber.isEmpty {
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
                Text(cardModel.currentBalance.formatted())
                    .bold()
                    .font(.title3)
            }
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom, spacing: 0) {
            currentBalance
            Spacer()
            Text(DateFormatter.expireDateString(for: cardModel.expireDate))
                .bold()
        }
    }
}



#Preview("Empty Number") {
    CardView(cardModel: DebitCard(), showCardDetailLogo: false)
}
#Preview {
    CardView(
        cardModel: DebitCard(
            linkedAccount: nil,
            cardNumber: "",
            expireDate: Date.now,
            cvv: "123",
            currentBalance: 123,
            overlayColorData: Color.red.toData(),
            textColorData: Color.white.toData()
        ),
        showCardDetailLogo: false
    )
}
