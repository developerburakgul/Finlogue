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
        let oneTimeIncome = OneTimeIncome(
            name: name,
            amount: amount,
            transactionDate: transactionDate,
            isReceived: true,
            linkedAccount: account
        )
        
        Task {
            try await service.addOneTimeIncome(oneTimeIncome)
        }
        
    }
    
    func createContiniousIncome(
        name: String,
        amount: String,
        account: Account,
        expectedDate: Date,
        frequency: IncomeFrequency
    ) {
        
        guard let amount = Double(amount) else { return  }
        let continiousIncome = ContiniousIncome(
            name: name,
            amount: amount,
            transactionDate: nil,
            isReceived: false,
            linkedAccount: account,
            expectedDate: expectedDate,
            frequency: frequency
        )
        
        Task {
            try await service.createContiniousIncome(continiousIncome)
        }
        
    }
}
