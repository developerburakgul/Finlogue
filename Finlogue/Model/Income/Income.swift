//
//  Income.swift
//  Finlogue
//
//  Created by Burak Gül on 5.03.2025.
//
import Foundation
import SwiftData


@Model
class OneTimeIncome: Identifiable{
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var transactionDate: Date
    var isReceived: Bool
    var linkedAccount: Account? // Gelirin geldiği hesap
    
    init(
        name: String,
        amount: Double,
        transactionDate: Date = .now,
        isReceived: Bool = true,
        linkedAccount: Account? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.transactionDate = transactionDate
        self.isReceived = isReceived
        self.linkedAccount = linkedAccount
    }
}

enum IncomeFrequency: String, CaseIterable, Identifiable, Codable {
    case weekly,monthly, firstDayOnMonth, lastDayOnMonth
    
    var id: Self {
        return self
    }
    
    var name: String {
        return rawValue.capitalized
    }
}

@Model
class ContiniousIncome: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var transactionDate: Date?
    var isReceived: Bool
    var linkedAccount: Account? // Gelirin geldiği hesap
    
    
    var expectedDate: Date? // Sürekli gelir için beklenen tarih
    var frequency: IncomeFrequency // Sürekli gelir için ödeme sıklığı
    
    init(
        name: String,
        amount: Double,
        transactionDate: Date? = nil,
        isReceived: Bool = false,
        linkedAccount: Account? = nil,
        expectedDate: Date? = nil,
        frequency: IncomeFrequency
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.transactionDate = transactionDate
        self.isReceived = isReceived
        self.linkedAccount = linkedAccount
        self.expectedDate = expectedDate
        self.frequency = frequency
    }
}
