//
//  Income.swift
//  Finlogue
//
//  Created by Burak Gül on 5.03.2025.
//
import Foundation
import SwiftData

enum IncomeFrequency: String, CaseIterable, Identifiable, Codable {
    case weekly,monthly, firstDayOnMonth, lastDayOnMonth
    
    var id: Self {
        return self
    }
    
    var name: String {
        return rawValue.capitalized
    }
}
//MARK: - <# Section Heading #>
@Model
class Income: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var amount: Double
    var transactionDate: Date
//    var category: IncomeCategory //MARK: - CATEGORY
    var isRecurring: Bool
    var isReceived: Bool // gelir için, ödemenin yapılıp yapılmadığını belirler
    var expectedDate: Date? // Sürekli gelir için beklenen tarih
    var frequency: IncomeFrequency? // Sürekli gelir için ödeme sıklığı
    var linkedAccount: Account? // Gelirin geldiği hesap
    
    init(
        name: String,
        amount: Double,
        transactionDate: Date,
        isRecurring: Bool = false,
        isReceived: Bool = false,
        expectedDate: Date? = nil,
        frequency: IncomeFrequency? = nil,
        linkedAccount: Account? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.amount = amount
        self.transactionDate = transactionDate
        self.isRecurring = isRecurring
        self.isReceived = isReceived
        self.expectedDate = expectedDate
        self.frequency = frequency
        self.linkedAccount = linkedAccount
    }
}
