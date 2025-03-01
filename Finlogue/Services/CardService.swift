//
//  CardService.swift
//  Finlogue
//
//  Created by Burak Gül on 28.02.2025.
//

import Foundation
import SwiftData

protocol CreateCardServiceProtocol {
    func create(_ debitCard: DebitCard) async throws
    func create(_ creditCard: CreditCard) async throws
    func loadBankAccounts(from bank: Bank) async throws -> [Account]
}

protocol CardListServiceProtocol {
    func fetchCards(for bank: Bank) async throws -> [any CardModelProtocol]
}

@ModelActor
actor CardService: CreateCardServiceProtocol, CardListServiceProtocol{

    
    
    
    func create(_ debitCard: DebitCard) async throws {
        
        do {
            await modelContainer.mainContext.insert(debitCard)
            try await modelContainer.mainContext.save()
        } catch  {
            print("Error happens : \(error)")
        }
    }
    
    func create(_ creditCard: CreditCard) async throws {
        do {
            await modelContainer.mainContext.insert(creditCard)
            try await modelContainer.mainContext.save()
        } catch  {
            print("Error happens : \(error)")
        }
    }
    
    @MainActor
    func loadBankAccounts(from bank: Bank) async throws -> [Account] {
        let itemCompare: String = AccountType.cashAccount.name
        do {
            var accounts  = try modelContainer.mainContext.fetch(FetchDescriptor<Account>())
            accounts = accounts.filter {
                $0.accountType == .cashAccount && $0.bank! == bank
            }
            return accounts
            
        } catch  {
            print("Error happens : \(error)")
            return []
        }
    }
    
    func fetchCards(for bank: Bank) async throws -> [any CardModelProtocol] {
        var cardsArray: [any CardModelProtocol] = []
        do {
            var debitCards = try await fetchDebitCards(for: bank)
            cardsArray.append(contentsOf: debitCards)
        } catch  {
            print("Error happens on Fetch Debit Cards \(error)")
        }
        
        cardsArray.append(contentsOf: fetchCreditCards(for: bank))
        return cardsArray
    }
    
    private func fetchDebitCards(for bank: Bank) async throws -> [DebitCard] {
        do {
            
                var bankAccounts = try await loadBankAccounts(from: bank)
                var debitCards: [DebitCard] = []
                bankAccounts.forEach {
                    debitCards.append(contentsOf: $0.debitCards)
                }
                return debitCards
            
            
        } catch  {
            print("Error happens on fetchDebitCards : \(error)")
        }
        return []
    }
    private func fetchCreditCards(for bank: Bank) -> [CreditCard] {
        return bank.creditCards
    }
    
    
    
}


