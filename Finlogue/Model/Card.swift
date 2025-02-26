//
//  Card.swift
//  Finlogue
//
//  Created by Burak Gül on 30.01.2025.
//
import Foundation
import SwiftUI
import SwiftData


enum CardType: String, CaseIterable, Codable {
    case credit, debit
    var name: String {
        self.rawValue.capitalized
    }
}



protocol CardModelProtocol {
    var id: UUID { get } // this property should be unique
    var cardNumber: String? { get set } 
    var expireDate: Date? { get set }
    var cvv: String? { get set }
    var currentBalance: Double { get}
    var overlayColorData: Data { get set}
    var textColorData: Data { get set }
    var cardType: CardType { get set }
}

@Model
class DebitCard: CardModelProtocol{
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
class CreditCard : CardModelProtocol {
    var currentBalance: Double
    
    @Attribute(.unique) var id: UUID
    var cardNumber: String?
    var expireDate: Date?
    var cvv: String?
    var limit: Double
    var bank: Bank?
    var cardType: CardType
    var overlayColorData: Data
    var textColorData: Data

    init(
        cardNumber: String?,
        limit: Double,
        bank: Bank?,
        expireDate: Date? = nil,
        cvv: String? = nil,
        currentBalance: Double = 0.0,
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
        self.cvv = cvv
        self.currentBalance = currentBalance
        
    }
}
class Card {
    var cardType: CardType = .credit
    var cardNumber: String?
    var currentBalance: Double = 0
    var expireDate: Date?
}


