//
//  Card.swift
//  Finlogue
//
//  Created by Burak Gül on 30.01.2025.
//
import Foundation
import SwiftUI
import SwiftData



class Card2 {
    var cardType: CardType = .credit
    var cardNumber: String?
    var currentBalance: Double = 0
    var expireDate: Date?
    //MARK: - UI
    var overlayColorData: Data
    var textColorData: Data
    
    init(
        cardType: CardType = .credit,
        cardNumber: String? = nil,
        currentBalance: Double = 0,
        overlayColorData: Data = Color.gray.toData(),
        textColorData: Data = Color.black.toData(),
        expireDate: Date? = nil
    ) {
        self.cardType = cardType
        self.cardNumber = cardNumber
        self.currentBalance = currentBalance
        self.overlayColorData = overlayColorData
        self.textColorData = textColorData
        self.expireDate = expireDate
    }
    
}

extension Card2 {
    static func getRandomCard() -> Card2 {
        return Card2(
            cardType: .credit,
            cardNumber: "1234 5678 2467 9826",
            expireDate: Date.now
        )
    }
    static func getRandomEmptyCard() -> Card2 {
        return Card2(
            cardType: .credit,
            cardNumber: nil,
            expireDate: nil
        )
    }
}

enum CardType: String, CaseIterable, Codable {
    case credit, debit
    var name: String {
        self.rawValue.capitalized
    }
}

@Model
class DebitCard {
    @Attribute(.unique)
    var id: UUID
    var linkedAccount: Account?
    var cardNumber: String?
    var expireDate: Date?
    var cvv: String?
    var currentBalance: Double
    var cardType: CardType
    var overlayColorData: Data
    var textColorData: Data
    
    init(
        linkedAccount: Account? = nil,
        cardNumber: String? = nil,
        expireDate: Date? = nil,
        cvv: String? = nil,
        currentBalance: Double = 0,
        overlayColorData: Data = Color.gray.toData(),
        textColorData: Data = Color.black.toData()
    ) {
        self.id = UUID()
        self.linkedAccount = linkedAccount
        self.cardNumber = cardNumber
        self.expireDate = expireDate
        self.cvv = cvv
        self.currentBalance = currentBalance
        self.cardType = .debit
        self.overlayColorData = overlayColorData
        self.textColorData = textColorData
    }
}

extension DebitCard {
    static func getMockBankCard() -> DebitCard {
        return DebitCard(
            linkedAccount: nil,
            cardNumber: "1234 5678 2467 9826",
            expireDate: Date.now,
            cvv: "123",
            currentBalance: 200,
            overlayColorData: Color.gray.toData(),
            textColorData: Color.black.toData()
        )
    }
}


@Model
class CreditCard {
    @Attribute(.unique) var id: UUID
    var cardNumber: String?
    var limit: Double
    var expireDate: Date?
    var bank: Bank?
    var cardType: CardType
    var overlayColorData: Data
    var textColorData: Data

    init(
        cardNumber: String?,
        limit: Double,
        dueDate: Date,
        bank: Bank?,
        expireDate: Date? = nil,
        overlayColorData: Data = Color.gray.toData(),
        textColorData: Data = Color.black.toData()
    ) {
        self.id = UUID()
        self.cardNumber = cardNumber
        self.limit = limit
        self.expireDate = expireDate
        self.bank = bank
        self.cardType = .credit
        self.overlayColorData = overlayColorData
        self.textColorData = textColorData
        
    }
}
class Card {
    var cardType: CardType = .credit
    var cardNumber: String?
    var currentBalance: Double = 0
    var expireDate: Date?
}
