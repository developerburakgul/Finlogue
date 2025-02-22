//
//  CreateAccountView.swift
//  Finlogue
//
//  Created by Burak Gül on 13.02.2025.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss
//    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: CreateAccountViewModel

//    let bank: Bank
    @State var name: String = ""
    @State var accountType: AccountType = .cashAccount
    
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
                        viewModel.createAccount(name: name, accountType: accountType)
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
