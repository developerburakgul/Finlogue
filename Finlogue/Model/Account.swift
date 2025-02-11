//
//  Account.swift
//  Finlogue
//
//  Created by Burak Gül on 11.02.2025.
//

import Foundation
import SwiftData

@Model
class Account {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var accountType: AccountType
    var bank: Bank?
    var bankCards: [BankCard] = []
    
    init(name: String, accountType: AccountType, bank: Bank? = nil, bankCards: [BankCard]) {
        self.id = UUID()
        self.name = name
        self.accountType = accountType
        self.bank = bank
        self.bankCards = bankCards
    }
    
}



@Model
class BankCard {
    @Attribute(.unique)
    var id: UUID
    var linkedAccount: Account?
    var cardNumber: String?
    var expireDate: Date?
    var cvv: String?
    var currentBalance: Double
    
    init(
        linkedAccount: Account? = nil,
        cardNumber: String? = nil,
        expireDate: Date? = nil,
        cvv: String? = nil,
        currentBalance: Double = 0
    ) {
        self.id = UUID()
        self.linkedAccount = linkedAccount
        self.cardNumber = cardNumber
        self.expireDate = expireDate
        self.cvv = cvv
        self.currentBalance = currentBalance
    }
}

@Model
class CreditCard {
    @Attribute(.unique) var id: UUID
    var cardNumber: String?
    var limit: Double
    var expireDate: Date?
    var bank: Bank?

    init(
        cardNumber: String?,
        limit: Double,
        dueDate: Date,
        bank: Bank?
    ) {
        self.id = UUID()
        self.cardNumber = cardNumber
        self.limit = limit
        self.expireDate = expireDate
        self.bank = bank
    }
}

enum AccountType: String, CaseIterable {
    case cashAccount, investmentAccount
}

enum CardType: String, CaseIterable {
    case credit, debit
    var name: String {
        self.rawValue.capitalized
    }
}

class Card {
    var cardType: CardType = .credit
    var cardNumber: String?
    var currentBalance: Double = 0
    var expireDate: Date?
}
