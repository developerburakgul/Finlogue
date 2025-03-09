//
//  IncomeExpenseViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 5.03.2025.
//

import Foundation

class IncomeExpenseViewModel: ObservableObject {
    
    @Published var incomeCreateViewModel: IncomeCreateViewModel
    @Published var expenseCreateViewModel: ExpenseCreateViewModel
    private var service: IncomeListServiceProtocol
    
    init() {
        self.service = IncomeExpenseService(modelContainer: CustomModelContainer.container)
        self.incomeCreateViewModel = .init(accounts: [])
        self.expenseCreateViewModel = .init(paymentSources: [])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.loadAccounts()
            self?.loadPaymentSources()
        }
    }
    
    private func loadAccounts() {
        Task { @MainActor in
            do {
                let fetchedAccounts = try await service.getAllCashAccounts()
                incomeCreateViewModel.accounts = fetchedAccounts
            } catch {
                print("Error loading accounts: \(error)")
            }
        }
    }
    
    private func loadPaymentSources() {
        Task { @MainActor in
            do {
                let cashAccounts = try await service.getAllCashAccounts()
                let debitCards = try await service.getAllDebitCards()
                let creditCards = try await service.getAllCreditCards()
                
                let selectablePaymentSources: [SelectablePaymentSource] =
                cashAccounts
                    .map { SelectablePaymentSource.cashAccount($0)}
                + debitCards
                    .map {SelectablePaymentSource.debitCard($0)}
                + creditCards
                    .map {SelectablePaymentSource.creditCard($0)}
                
                expenseCreateViewModel.paymentSources = selectablePaymentSources
            } catch {
                print("Error loading accounts: \(error)")
            }
        }
    }
    
}
