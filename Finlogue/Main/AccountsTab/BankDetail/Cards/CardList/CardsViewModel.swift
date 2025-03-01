//
//  CardsViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation

class CardsViewModel: ObservableObject {
    
    @Published var bank: Bank
    @Published var cards: [any CardModelProtocol] = []
    
    var createCardViewModel: CreateCardViewModel
    let service: CardListServiceProtocol
    init(bank: Bank) {
        self.bank = bank
        self.createCardViewModel = CreateCardViewModel(bank: bank)
        self.service = CardService(modelContainer: CustomModelContainer.container)
        fetchCards()
    }
    
    func fetchCards() {
        Task {
            self.cards = try await service.fetchCards(for: bank)
        }
    }
}



