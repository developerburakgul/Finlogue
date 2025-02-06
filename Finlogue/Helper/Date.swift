//
//  Date.swift
//  Finlogue
//
//  Created by Burak Gül on 4.02.2025.
//

import Foundation

extension Date {
    var getCurrentYear: Int {
        return Calendar.current.component(.year, from: .now)
    }
}
