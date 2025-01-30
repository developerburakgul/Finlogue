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
    @Attribute var netAmount: Double
    var iconName: String = "heart"
    
    init(id: UUID = UUID(), name: String, netAmount: Double = 0) {
        self.id = id
        self.name = name
        self.netAmount = netAmount
    }
    
    static func == (lhs: Bank, rhs: Bank) -> Bool {
           lhs.id == rhs.id
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
}
