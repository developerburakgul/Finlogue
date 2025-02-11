////
////  Card.swift
////  Finlogue
////
////  Created by Burak Gül on 30.01.2025.
////
//import Foundation
//import SwiftUI
//
//
//
//class Card {
//    var cardType: CardType = .credit
//    var cardNumber: String?
//    var currentBalance: Double = 0
//    var expireDate: Date?
//    //MARK: - UI
//    var overlayColorData: Data
//    var textColorData: Data
//    
//    
//    
//    
//    init(
//        cardType: CardType = .credit,
//        cardNumber: String? = nil,
//        currentBalance: Double = 0,
//        overlayColorData: Data = Color.gray.toData(),
//        textColorData: Data = Color.black.toData(),
//        expireDate: Date? = nil
//    ) {
//        self.cardType = cardType
//        self.cardNumber = cardNumber
//        self.currentBalance = currentBalance
//        self.overlayColorData = overlayColorData
//        self.textColorData = textColorData
//        self.expireDate = expireDate
//    }
//    
//    
//    var overlayColor: Color {
//        get { Color.fromData(overlayColorData) }
//        set { overlayColorData = newValue.toData() }
//    }
//    
//    var textColor: Color {
//        get { Color.fromData(textColorData) }
//        set { textColorData = newValue.toData() }
//    }
//    
//
//    
//    
//}
//enum CardType: String, CaseIterable {
//    case credit, debit
//    var name: String {
//        self.rawValue.capitalized
//    }
//}
//
//
//
//extension Card {
//    static func getRandomCard() -> Card {
//        return Card(
//            cardType: .credit,
//            cardNumber: "1234 5678 2467 9826",
//            expireDate: Date.now
//        )
//    }
//    static func getRandomEmptyCard() -> Card {
//        return Card(
//            cardType: .credit,
//            cardNumber: nil,
//            expireDate: nil
//        )
//    }
//}
