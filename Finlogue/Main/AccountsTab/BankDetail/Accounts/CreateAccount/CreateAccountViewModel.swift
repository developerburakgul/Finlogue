//
//  CreateAccountViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation
import SwiftData

class CreateAccountViewModel: ObservableObject {
    let bank: Bank
    let service: CreateAccountServiceProtocol
    init(bank: Bank) {
        self.bank = bank
        self.service = AccountService(modelContainer: CustomModelContainer.container)
    }
    
    
    
    func createAccount(name: String, accountType: AccountType) {
        let account = Account(name: name, accountType: accountType, bank: bank)
        Task {
            try await service.create(account)
        }

    }
}




