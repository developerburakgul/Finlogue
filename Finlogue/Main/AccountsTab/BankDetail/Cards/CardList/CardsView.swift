//
//  CardsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct CardsView: View {
    @State var isShowAddCardView: Bool = false
    @ObservedObject var viewModel: CardsViewModel
    var body: some View {
        let _ = Self._printChanges()
        VStack {
            
            NavigationLink {
                CreateCardView(viewModel: viewModel.createCardViewModel)
                    .onDisappear {
                        viewModel.fetchCards()
                    }
            } label: {
                addCardButton
                    .padding(.top)
            }
            .foregroundColor(Color.black)

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
//            ForEach(viewModel.cards, id: \.self) { item in
//                CardView(cardModel: viewModel.cards[0] , showCardDetailLogo: false)

            ForEach(viewModel.cards, id: \.hashValue) { item in
                CardView(cardModel: item, showCardDetailLogo: true)
            }
        }
    }
}

//#Preview("1") {
//    NavigationStack {
//        CardsView(bank: Bank.getRandomBank())
//    }
//    
//}
#Preview("2") {
    var cardsViewModel = CardsViewModel(bank: Bank.getRandomBank())
    NavigationStack {
        CardsView(viewModel: cardsViewModel)
    }
}
