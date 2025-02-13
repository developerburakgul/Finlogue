//
//  AccountsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct AccountsView: View {
    var bank: Bank
    
    init(bank: Bank) {
        self.bank = bank
    }
    
    var body: some View {
        if countOfAllAccountTypes() == 0 {
            emptyView
        } else {
            accountListView
        }
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            ContentUnavailableView("Add bank account", systemImage: "dollarsign.bank.building", description: Text("Descripiton"))
            Spacer()
        }
    }
    
    private var accountListView: some View {
        List {
            ForEach(AccountType.allCases, id: \.self) { accountType in
                if isThereAccount(type: accountType) {
                    Section(getAccountTypeHeaderText(accountType)) {
                        ForEach(bank.accounts) { account in
                            if account.accountType == accountType {
                                AccountView(account: account)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getAccountTypeHeaderText(_ accountType: AccountType) -> String {
        let accountCount = countOf(accountType: accountType)
        switch accountType {
        case .cashAccount:
            return "Vadesiz Hesaplarım" + (accountCount >= 1 ? " (\(accountCount))" : "")
        case .investmentAccount:
            return "Yatırım Hesaplarım" + (accountCount >= 1 ? " (\(accountCount))" : "")
        }
    }
    
    func countOf(accountType: AccountType) -> Int {
        return bank.accounts.filter { $0.accountType == accountType }.count
    }
    
    func countOfAllAccountTypes() -> Int {
        return bank.accounts.count
    }
    
    func isThereAccount(type: AccountType) -> Bool {
        bank.accounts.contains { $0.accountType ==  type }
    }
    
}

#Preview {
    return AccountsView(bank: Bank.getRandomBank(accountCount: 1))
}
