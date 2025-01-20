//
//  Bank.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import Foundation
import SwiftData

@Model
class Bank: Identifiable {
    internal var id: UUID 
    private(set) var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
