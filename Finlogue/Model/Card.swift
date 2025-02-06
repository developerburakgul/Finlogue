//
//  Card.swift
//  Finlogue
//
//  Created by Burak Gül on 30.01.2025.
//
import Foundation
import SwiftUI



class Card {
    var cardType: CardType = .credit
    var cardNumber: String
    
    private var expireDate: Date
    var expireDateString: String {
        DateFormatter.expireDateString(for: expireDate)
    }
    
    init(cardType: CardType = .credit, cardNumber: String, expireDate: Date) {
        self.cardType = cardType
        self.cardNumber = cardNumber
        self.expireDate = expireDate
    }
    
    
    
}
enum CardType: String, CaseIterable {
    case credit, debit
    var name: String {
        self.rawValue.capitalized
    }
}



extension Card {
    static func getRandomCard() -> Card {
        return Card(
            cardType: .credit,
            cardNumber: "1234 5678 2467 9826",
            expireDate: Date.now
        )
    }
}
