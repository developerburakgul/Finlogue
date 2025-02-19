//
//  BankService.swift
//  Finlogue
//
//  Created by Burak Gül on 18.02.2025.
//

import Foundation
import SwiftData


protocol BankServiceProtocol {
    func getBanks() async throws -> [Bank]
    func delete(_ bank : Bank) async throws
    func add(_ bank: Bank) async throws
}


@ModelActor
actor BankService: BankServiceProtocol {
    @MainActor
    func getBanks() async throws -> [Bank] {
        do {
            let banks = try modelContainer.mainContext.fetch(
                FetchDescriptor<Bank>()
            )
            return banks
        } catch  {
            throw error
        }
    }
    
    
    func delete(_ bank: Bank) throws {
        let bankId = bank.id
        do {
            try modelContext.delete(
                model: Bank.self,
                where: #Predicate {
                    return $0.id == bankId
                }
            )
            try modelContext.save()
        } catch  {
            throw error
        }
    }
    
    func add(_ bank: Bank) async throws {
        modelContext.insert(bank)
        try? modelContext.save()
    }
}
