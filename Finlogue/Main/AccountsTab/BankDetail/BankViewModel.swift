//
//  BankViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 21.02.2025.
//

import Foundation




class BankViewModel: ObservableObject {
    
    private var bank: Bank
    
    @Published
    var accountsViewModel: AccountsViewModel
    @Published
    var cardsViewModel: CardsViewModel
    
    init(bank: Bank) {
        self.bank = bank
        self.accountsViewModel = AccountsViewModel(bank: bank)
        self.cardsViewModel = CardsViewModel(bank: bank)
    }
    
   
    
}


