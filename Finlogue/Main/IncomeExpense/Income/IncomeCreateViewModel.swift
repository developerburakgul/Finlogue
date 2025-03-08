//
//  IncomeCreateViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 5.03.2025.
//

import Foundation

class IncomeCreateViewModel: ObservableObject {
    @Published
    var accounts: [Account]
//    @Published
//    var defaultAccount = Account.getRandomAccount(time: 20)[4]
    
    private var service: IncomeCreateServiceProtocol = IncomeCreateService(modelContainer: CustomModelContainer.container)
    

    init(accounts: [Account]) {
        self.accounts = accounts
    }
    

    func createOneTimeIncome(
        name: String,
        amount: String,
        account: Account,
        transactionDate: Date
    ) {
        
        guard let amount = Double(amount) else { return  }
        let income = Income(
            name: name,
            amount: amount,
            transactionDate: transactionDate,
            isRecurring: false,
            isReceived: true,
            expectedDate: nil,
            frequency: nil,
            linkedAccount: account
        )
        
        print(income)
        dump(income)
        
        Task {
            try await service.addIncome(income)
        }
        
    }
}
