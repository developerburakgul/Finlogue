//
//  Bank.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import Foundation
import SwiftData

@Model
class Bank: Identifiable, Hashable{
    @Attribute(.unique) var id: UUID
    @Attribute var name: String
    //    @Attribute var netAmount: Double // Bu en son computed property olmalı.
    var iconName: String = "heart"
    var accounts: [Account] = []
    var creditCards: [CreditCard] = []
    
    
    
    var netAmount: Double {
        return 0
    }
    
    init(name: String, iconName: String = "heart", accounts: [Account] = [], creditCards: [CreditCard] = []) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.accounts = accounts
        self.creditCards = creditCards
    }
    
    static func == (lhs: Bank, rhs: Bank) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Bank {
    static func getRandomBank() -> Bank {
        Bank(
            name: "Random Bank \(Int.random(in: 1...1000))",
            accounts: Account.getRandomAccount(time: 20)
        )
    }
}
