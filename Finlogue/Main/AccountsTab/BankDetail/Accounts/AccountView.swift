//
//  AccountView.swift
//  Finlogue
//
//  Created by Burak Gül on 13.02.2025.
//

import SwiftUI

struct AccountView: View {
    let account: Account
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(account.name)
                .font(.headline)
            HStack(alignment: .top, spacing: 4) {
                Text("Balance")
                Spacer()
                Text(String(format: "%.2f", account.netAmount))
            }
        }
    }
}

#Preview {
    let accounts = Account.getRandomAccount(time: 20)
    
    return List {
        ForEach(accounts) { account in
            AccountView(account: account)
        }
    }
}
