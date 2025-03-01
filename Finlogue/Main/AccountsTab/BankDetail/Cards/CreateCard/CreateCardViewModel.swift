//
//  CreateCardViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation
class CreateCardViewModel: ObservableObject {
    @Published var bankAccounts: [Account] = []
    private let bank: Bank
    private let service: CreateCardServiceProtocol
    
    init(bank: Bank) {
        self.bank = bank
        self.service = CardService(modelContainer: CustomModelContainer.container)
        loadBankAccounts()
    }
    //MARK: - Private Functions
    private func loadBankAccounts() {
        Task {
            let accounts = try await service.loadBankAccounts(from: bank)
            await MainActor.run {
                self.bankAccounts = accounts
            }
        }
    }
    //MARK: - Public Functions
    
    func formatCardNumber(_ number: String) -> String {
        let filtered = number.filter { $0.isNumber}
        var result = ""
        for (index, character) in filtered.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(character)
        }
        if result.count > 19 {
            result = String(result.prefix(19))
        }
        return result
    }
    
    func formatExpireDateText(_ numbers: String) -> String {
        let filtered = numbers.filter { $0.isNumber}
        var result = ""
        for (index, character) in filtered.enumerated() {
            if index != 0 && index % 2 == 0 {
                result.append("/")
            }
            result.append(character)
        }
        if result.count > 5 {
            result = String(result.prefix(5))
        }
        return result
    }
    
    func formatCVVText(_ numbers: String) -> String {
        let filtered = numbers.filter { $0.isNumber}
        var result = ""
        for (_, character) in filtered.enumerated() {
            result.append(character)
        }
        if result.count > 3 {
            result = String(result.prefix(3))
        }
        return result
    }

    func createDebitCard(
        linkedAccount: Account,
        cardNumberString: String?,
        expireDateString: String?,
        cvvString: String?
    ){
        let debitCard = DebitCard(
            linkedAccount: linkedAccount,
            cardNumber: cardNumberString,
            expireDate: nil, //MARK: - ToDO
            cvv: cvvString,
            currentBalance: 0
        )
        
        Task {
            try await service.create(debitCard)
        }
    }
    func createCreditCard(
        cardNumberString: String?,
        cardLimitText: String,
        expireDateString: String?,
        cvvString: String?
    ){
        let creditCard = CreditCard(
            cardNumber: cardNumberString,
            limit: 0.0, //MARK: - TODO
            bank: bank,
            expireDate: .now, //MARK: - TODO
            cvv: cvvString,
            currentBalance: 0 //MARK: - Todo
        )
        Task {
            try await service.create(creditCard)
        }
        

    }
    
    func updateBankAccounts()  {
        loadBankAccounts()
    }
}
