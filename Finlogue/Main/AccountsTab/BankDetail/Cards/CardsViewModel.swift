//
//  CardsViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation

class CardsViewModel: ObservableObject {
    
    @Published var bank: Bank
    @Published var cards: [CardModelProtocol] = [DebitCard.getMockBankCard()]
    
    init(bank: Bank) {
        self.bank = bank
    }
}



