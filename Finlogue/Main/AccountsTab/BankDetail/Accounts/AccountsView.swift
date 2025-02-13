//
//  AccountsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct AccountsView: View {
    var bank: Bank
    @State var shouldShowCreateAccountView: Bool = false
    
    init(bank: Bank) {
        self.bank = bank
    }
    
    var body: some View {
        Group {
            if countOfAllAccountTypes() == 0 {
                emptyView
            } else {
                accountListView
            }
        }
        .sheet(isPresented: $shouldShowCreateAccountView) {
            CreateAccountView(bank: bank)
                .presentationDetents([.fraction(0.33)])
        }
        .navigationDestination(for: Bank.self) { bank in
            BankView(bank: bank)
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
                Button {
                    shouldShowCreateAccountView = true
                } label: {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        )
                }
                .padding()
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
        .scrollIndicators(.never)
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
    return NavigationStack {
        AccountsView(bank: Bank.getRandomBank(accountCount: 0))
    }
}
