//
//  CreateAccountView.swift
//  Finlogue
//
//  Created by Burak Gül on 13.02.2025.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var name: String = ""
    @State var accountType: AccountType = .cashAccount
    let bank: Bank
    
    private var isDisableCreateButton: Bool {
        name.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter Account Name", text: $name)
                Picker("Select Account Type", selection: $accountType) {
                    ForEach(AccountType.allCases, id: \.self) { accountType in
                        Text(accountType.name).tag(accountType)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        //MARK: - TODO
                        let account = Account(name: name, accountType: accountType, bank: bank)
                        bank.accounts.append(account)
                        do {
                            try context.save()
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }
                    .disabled(isDisableCreateButton)
                }
            }
        }
    }
}

//#Preview {
//    CreateAccountView(bank: Bank.getRandomBank(accountCount: 1)[0])
//}
