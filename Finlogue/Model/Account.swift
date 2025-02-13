//
//  Account.swift
//  Finlogue
//
//  Created by Burak Gül on 11.02.2025.
//

import Foundation
import SwiftData
import SwiftUI


enum AccountType: String, CaseIterable,Codable {
    case cashAccount, investmentAccount
    var name: String {
        switch self {
        case .cashAccount:
            "Vadesiz Hesap"
        case .investmentAccount:
            "Yatırım Hesabı"
        }
    }
}

@Model
class Account {
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var accountType: AccountType
    var bank: Bank?
    var debitCards: [DebitCard]
    
    init(name: String, accountType: AccountType, bank: Bank? = nil, bankCards: [DebitCard] = []) {
        self.id = UUID()
        self.name = name
        self.accountType = accountType
        self.bank = bank
        self.debitCards = bankCards
    }
    
    var netAmount: Double {
        return 0
    }
}

extension Account {
    static func getRandomAccount(time: Int) -> [Account] {
        var arr : [Account] = .init()
        if time > 0 {
            for i in 0..<time {
                arr.append(Account(name: "\(i) account", accountType: i % 2 == 0 ? .cashAccount : .investmentAccount ))
            }
        }
        
        return arr
    }
}





