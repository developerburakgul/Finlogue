//
//  IncomeService.swift
//  Finlogue
//
//  Created by Burak Gül on 7.03.2025.
//

import Foundation
import SwiftData

protocol IncomeCreateServiceProtocol {
    func addOneTimeIncome( _ income: OneTimeIncome) async throws
    func createContiniousIncome( _ income: ContiniousIncome) async throws
}




@ModelActor
actor IncomeCreateService: IncomeCreateServiceProtocol {
    func addOneTimeIncome(_ income: OneTimeIncome) async throws {
        

        do {
           await  modelContainer.mainContext.insert(income)
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }
    
    func createContiniousIncome(_ income: ContiniousIncome) async throws {
        
        do {
           await  modelContainer.mainContext.insert(income)
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }
}

protocol IncomeListServiceProtocol {
    func getAllCashAccounts() async throws -> [Account]
    func getAllDebitCards() async throws -> [DebitCard]
    func getAllCreditCards() async throws -> [CreditCard]
}
@ModelActor
actor IncomeExpenseService: IncomeListServiceProtocol {
    func getAllCashAccounts() async throws -> [Account] {
        do {
            var accounts  = try modelContext.fetch(FetchDescriptor<Account>())
            accounts = accounts.filter {
                $0.accountType == .cashAccount
            }
            return accounts
            
        } catch  {
            print("Error happens : \(error)")
            return []
        }
    }
    
    func getAllDebitCards() async throws -> [DebitCard] {
        do {
            var debitCards  = try modelContext.fetch(FetchDescriptor<DebitCard>())
            return debitCards
            
        } catch  {
            print("Error happens : \(error)")
            return []
        }
    }
    
    func getAllCreditCards() async throws -> [CreditCard] {
        do {
            var creditCards  = try modelContext.fetch(FetchDescriptor<CreditCard>())
            return creditCards
            
        } catch  {
            print("Error happens : \(error)")
            return []
        }
    }
}


