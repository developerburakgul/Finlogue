//
//  CreatingCardView.swift
//  Finlogue
//
//  Created by Burak Gül on 26.02.2025.
//

import SwiftUI

struct CreatingCardView: View {
    @Binding var overlayColor: Color
    @Binding var textColor: Color
    @Binding var cardType: CardType?
    @Binding var cardNumber: String
    @Binding var limitText: String
    @Binding var expireDateText: String
    @Binding var cvvText: String
    @Binding var linkedBankAccount: Account?
    
    var body: some View {
        ZStack {
            VisualEffectView(
                effect: UIBlurEffect(style: .dark)
            )
            
            // Renk overlay
            Color(overlayColor)
            
            // İçerik
            content
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
        .foregroundColor(textColor)
    }
    
    private var headerView: some View {
        HStack {
            if let linkedBankAccount = linkedBankAccount {
                Text(linkedBankAccount.name)
                    .bold()
            }
            Spacer()
            Text("\(cardType?.name ?? "Card Type")")
                .bold()
            
        }
    }
    
    private var cardNumberSection: some View {
        HStack {
            
            Text(
                cardNumber.isEmpty == true
                ? "**** **** **** ****"
                : cardNumber
                
            )
            .font(.title2)
            .bold()
            Image(systemName: "document.on.document")
                .imageScale(.small)
            Spacer()
            
        }
    }
    
    private var footer: some View {
        HStack(alignment: .top, spacing: 0) {
            currentBalance
            expireDateSection
            
        }
    }
    
    @ViewBuilder
    private var currentBalance: some View {
        
        HStack {
            if cardType == .credit {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Card Limit")
                        .font(.caption)
                        .bold()
                    Text(
                        limitText.isEmpty
                        ? "***"
                        : limitText
                    )
                    .bold()
                    .font(.title3)
                }
                
            }else {
                EmptyView()
            }
            Spacer()
        }
        
    }
    
    private var expireDateSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ExpireDate")
                .font(.caption)
                .bold()
            Text(expireDateText.isEmpty ? "MM/YY" : expireDateText )
                .font(.caption2)
                .bold()
            
        }
    }
    

}




//#Preview {
//    CreatingCardView(
//        overlayColor: <#Binding<Color>#>,
//        textColor: <#Binding<Color>#>
//    )
//}

