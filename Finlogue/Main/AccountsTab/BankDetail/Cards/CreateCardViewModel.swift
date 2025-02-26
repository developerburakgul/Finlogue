//
//  CreateCardViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation
class CreateCardViewModel: ObservableObject {


    let bank: Bank
    //   08*25
    // 0825
    // 08/25

    init(bank: Bank) {
        self.bank = bank
    }
    
    func formatCardNumber(_ number: String) -> String {
        let filtered = number.filter { $0.isNumber}
        var result = ""
        for (index, character) in filtered.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(character)
        }
        if result.count > 19 {
            result = String(result.prefix(19))
        }
        return result
    }
    
    func formatExpireDateText(_ numbers: String) -> String {
        let filtered = numbers.filter { $0.isNumber}
        var result = ""
        for (index, character) in filtered.enumerated() {
            if index != 0 && index % 2 == 0 {
                result.append("/")
            }
            result.append(character)
        }
        if result.count > 5 {
            result = String(result.prefix(5))
        }
        return result
    }
    
    func formatCVVText(_ numbers: String) -> String {
        let filtered = numbers.filter { $0.isNumber}
        var result = ""
        if result.count > 3 {
            result = String(result.prefix(5))
        }
        return result

    }
    
    
}
