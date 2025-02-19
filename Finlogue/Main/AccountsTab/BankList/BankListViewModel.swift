//
//  BankListViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 16.02.2025.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class BankListViewModel: ObservableObject {
    @Published public private(set) var banks: [Bank] = []
    
    private var bankService: BankServiceProtocol
    
    init(bankService: BankServiceProtocol = BankService(modelContainer: CustomModelContainer.container)) {
        self.bankService = bankService
        loadBanks()
    }
    
    //MARK: - Computed Properties
    var bankListIsEmpty: Bool {
        banks.isEmpty
    }
    
    func loadBanks() {
        Task { @MainActor in
            banks = try await bankService.getBanks()
        }
    }
    
    private func delete(_ bank: Bank) {
        Task { @MainActor in
            try await bankService.delete(bank)
        }
        
    }
    
    func deleteBank(at offsets: IndexSet) {
        for index in offsets {
            let deleteItem = banks[index]
            banks.remove(at: index)
            withAnimation {
                delete(deleteItem)
            }
        }
    }
}
