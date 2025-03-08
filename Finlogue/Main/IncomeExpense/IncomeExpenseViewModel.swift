//
//  IncomeExpenseViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 5.03.2025.
//

import Foundation

class IncomeExpenseViewModel: ObservableObject {
    
    @Published var incomeCreateViewModel: IncomeCreateViewModel
    private var service: IncomeListServiceProtocol
    
    init() {
        self.service = IncomeExpenseService(modelContainer: CustomModelContainer.container)
        self.incomeCreateViewModel = .init(accounts: [])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.loadAccounts()
        }
    }
    
    func loadAccounts() {
        Task { @MainActor in
            do {
                let fetchedAccounts = try await service.getAllCashAccounts()
                incomeCreateViewModel.accounts = fetchedAccounts
                print("Accounts successfully loaded: \(fetchedAccounts)")
            } catch {
                print("Error loading accounts: \(error)")
            }
        }
    }
    
}
