//
//  IncomeService.swift
//  Finlogue
//
//  Created by Burak Gül on 7.03.2025.
//

import Foundation
import SwiftData

protocol IncomeCreateServiceProtocol {
    func addIncome( _ income: Income) async throws
}




@ModelActor
actor IncomeCreateService: IncomeCreateServiceProtocol {
    
    func addIncome(_ income: Income) async throws {
        await modelContainer.mainContext.insert(income)

        do {
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }    
}

protocol IncomeListServiceProtocol {
    func getAllCashAccounts() async throws -> [Account]
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
}


