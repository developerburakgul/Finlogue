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
        List {
            Section(AccountType.cashAccount.rawValue) {
                ForEach(bank.accounts) { account in
                    if account.accountType == .cashAccount {
                        Text(account.name)
                    }
                }
            }
            
            Section(AccountType.investmentAccount.rawValue) {
                ForEach(bank.accounts) { account in
                    if account.accountType == .investmentAccount {
                        Text(account.name)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
    
}

#Preview {
    return AccountsView(bank: Bank.getRandomBank())
}
