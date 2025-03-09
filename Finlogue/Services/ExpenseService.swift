//
//  ExpenseService.swift
//  Finlogue
//
//  Created by Burak Gül on 9.03.2025.
//

import Foundation
import SwiftData

protocol ExpenseCreateServiceProtocol {
    func addOneTimeExpense( _ expense: OneTimeExpense) async throws
    func createContiniousExpense( _ expense: ContiniousExpense) async throws
}




@ModelActor
actor ExpenseCreateService: ExpenseCreateServiceProtocol {
    func addOneTimeExpense(_ expense: OneTimeExpense) async throws {
        do {
            await  modelContainer.mainContext.insert(expense)
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }
    
    func createContiniousExpense(_ expense: ContiniousExpense) async throws {
        
        do {
            await  modelContainer.mainContext.insert(expense)
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }
}
