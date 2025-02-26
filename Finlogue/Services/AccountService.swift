//
//  CreateAccountServiceProtocol.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//
import Foundation
import SwiftData

protocol CreateAccountServiceProtocol {
    func create(_ account: Account) async throws
}

@ModelActor
actor AccountService: CreateAccountServiceProtocol{
    
    func create(_ account: Account) async throws {
        
        await modelContainer.mainContext.insert(account)
        
        do {
            try await modelContainer.mainContext.save()
        } catch {
            print(error)
        }
    }
}
