//
//  AccountsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct AccountsView: View {
    @State var shouldShowCreateAccountView: Bool = false
    @ObservedObject var viewModel: AccountsViewModel
    var body: some View {
        let _ = Self._printChanges()
        Group {
            if viewModel.countOfAllAccountTypes() == 0 {
                emptyView
            } else {
                accountListView
            }
        }
        .sheet(isPresented: $shouldShowCreateAccountView) {
            CreateAccountView(viewModel: viewModel.createAccountViewModel)
                .presentationDetents([.fraction(0.33)])
                .onDisappear {
                    viewModel.loadAccounts()
                }
        }
        .navigationDestination(for: Bank.self) { bank in
//            BankView(bank: bank)
        }
        .toolbar {
            Button {
                shouldShowCreateAccountView = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .foregroundColor(Color.black)
            }

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
                if viewModel.isThereAccount(type: accountType) {
                    Section(getAccountTypeHeaderText(accountType)) {
                        getAccountViews(accountType: accountType)
                    }
                }
            }
        }
        .scrollIndicators(.never)
//        Text("Burak")
        
    }
    
    func getAccountViews(accountType: AccountType) -> some View{
        return ForEach(viewModel.accounts) { account in
            if account.accountType == accountType {
                AccountView(account: account)
            }
        }
    }
    
    func getAccountTypeHeaderText(_ accountType: AccountType) -> String {
        let accountCount = viewModel.countOf(accountType: accountType)
        switch accountType {
        case .cashAccount:
            return "Vadesiz Hesaplarım" + (accountCount >= 1 ? " (\(accountCount))" : "")
        case .investmentAccount:
            return "Yatırım Hesaplarım" + (accountCount >= 1 ? " (\(accountCount))" : "")
        }
    }
    

    

    

    
}

#Preview {
    NavigationStack {
        AccountsView(viewModel: AccountsViewModel(bank: Bank.getRandomBank()))
            
    }
}
