//
//  ExpenseCreateViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 8.03.2025.
//

import Foundation

class ExpenseCreateViewModel: ObservableObject {
    @Published var paymentSources: [SelectablePaymentSource]
    
    private let service: ExpenseCreateServiceProtocol
    init(paymentSources: [SelectablePaymentSource]) {
        self.paymentSources = paymentSources
        self.service = ExpenseCreateService(modelContainer: CustomModelContainer.container)
    }
    
    
    func createOneTimeExpense(
        name: String,
        amount: String,
        selectablePaymentSource: SelectablePaymentSource,
        transactionDate: Date
    ) {
        guard let amount = Double(amount) else { return  }
        let source: (id: UUID, paymentSource: PaymentSource) =  switch selectablePaymentSource {
        case .cashAccount(let account):
            (account.id, PaymentSource.cashAccount)
        case .debitCard(let debitCard):
            (debitCard.id, PaymentSource.debitCard)
        case .creditCard(let creditCard):
            (creditCard.id, PaymentSource.creditCard)
        }
        
        let oneTimeExpense = OneTimeExpense(
            name: name,
            amount: amount,
            transactionDate: transactionDate,
            isPaid: true,
            paymentSourceID: source.id,
            paymentSource: source.paymentSource
        )
        
        Task {
            try await service.addOneTimeExpense(oneTimeExpense)
        }
        
    }
    
    func createContiniousExpense(
        name: String,
        amount: String,
        selectablePaymentSource: SelectablePaymentSource,
        transactionDate: Date,
        firstExpensePaymentDate: Date,
        expenseFreqeunency: ExpenseFrequency,
        afterDayCountFromFirstPayment: Int
    ) {
        guard let amount = Double(amount) else { return  }
        let source: (id: UUID, paymentSource: PaymentSource) =  switch selectablePaymentSource {
        case .cashAccount(let account):
            (account.id, PaymentSource.cashAccount)
        case .debitCard(let debitCard):
            (debitCard.id, PaymentSource.debitCard)
        case .creditCard(let creditCard):
            (creditCard.id, PaymentSource.creditCard)
        }
        
        
        let continiousExpense = ContiniousExpense(
            name: name,
            amount: amount,
            transactionDate: transactionDate,
            isPaid: false,
            paymentSourceID: source.id,
            paymentSource: source.paymentSource,
            firstPaymentDate: firstExpensePaymentDate,
            frequency: expenseFreqeunency,
            afterDayCountFromFirstPayment: afterDayCountFromFirstPayment
        )
        
        Task {
            try await service.createContiniousExpense(continiousExpense)
        }
        
    }

}
