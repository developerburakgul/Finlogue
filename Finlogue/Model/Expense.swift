//
//  Expense.swift
//  Finlogue
//
//  Created by Burak Gül on 8.03.2025.
//


import Foundation
import SwiftData

enum PaymentSource: Codable {
    case cashAccount
    case debitCard
    case creditCard
}

@Model
class OneTimeExpense: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var transactionDate: Date
    var isPaid: Bool //gider için, ödemenin yapılıp yapılmadığını belirler
    var paymentSourceID: UUID
    var paymentSource: PaymentSource // Ödemenin hangi kaynaktan yapıldığı
    
    init(
        name: String,
        amount: Double,
        transactionDate: Date = .now,
        isPaid: Bool = true,
        paymentSourceID: UUID,
        paymentSource: PaymentSource
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.transactionDate = transactionDate
        self.isPaid = isPaid
        self.paymentSourceID = paymentSourceID
        self.paymentSource = paymentSource
    }
}

@Model
class ContiniousExpense: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var transactionDate: Date?
    var isPaid: Bool //gider için, ödemenin yapılıp yapılmadığını belirler
    var paymentSourceID: UUID
    var paymentSource: PaymentSource // Ödemenin hangi kaynaktan yapıldığı
    var expenseFirstPaymentDate: Date //
    var afterDayCountFromFirstPayment: Int
    var frequency: ExpenseFrequency
    
    init(
        name: String,
        amount: Double,
        transactionDate: Date? = nil,
        isPaid: Bool = false,
        paymentSourceID: UUID,
        paymentSource: PaymentSource,
        firstPaymentDate: Date,
        frequency: ExpenseFrequency,
        afterDayCountFromFirstPayment: Int
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.transactionDate = transactionDate
        self.isPaid = isPaid
        self.paymentSourceID = paymentSourceID
        self.paymentSource = paymentSource
        self.expenseFirstPaymentDate = firstPaymentDate
        self.frequency = frequency
        self.afterDayCountFromFirstPayment = afterDayCountFromFirstPayment
    }
}

enum ExpenseFrequency: String, CaseIterable, Identifiable, Codable {
    case weekly,monthly, firstDayOnMonth, lastDayOnMonth
    
    var id: Self {
        return self
    }
    
    var name: String {
        return rawValue.capitalized
    }
}
