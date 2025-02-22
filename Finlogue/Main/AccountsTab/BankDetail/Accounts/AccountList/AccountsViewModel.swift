//
//  AccountsViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//
import Foundation

class AccountsViewModel: ObservableObject {
    
    @Published var accounts: [Account] = []
    private var bank: Bank
    
    var createAccountViewModel: CreateAccountViewModel
    
    init(bank: Bank) {
        self.bank = bank
        accounts = bank.accounts
        self.createAccountViewModel = .init(bank: bank)
    }
    
    func countOfAllAccountTypes() -> Int {
        return bank.accounts.count
    }
    
    func isThereAccount(type: AccountType) -> Bool {
        bank.accounts.contains { $0.accountType ==  type }
    }
    
    func countOf(accountType: AccountType) -> Int {
        return bank.accounts.filter { $0.accountType == accountType }.count
    }
    
    func deleteAccount(at: IndexSet) {
        
    }
    
    func loadAccounts() {
        self.accounts = bank.accounts
    }
}
