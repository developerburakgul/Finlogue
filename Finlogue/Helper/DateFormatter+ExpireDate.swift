//
//  DateFormatter+ExpireDate.swift
//  Finlogue
//
//  Created by Burak Gül on 30.01.2025.
//

import Foundation

extension DateFormatter {
    static func expireDateString(for date: Date, locale: Locale = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate("MMyy")
        formatter.dateFormat = formatter.dateFormat.replacingOccurrences(of: "yyyy", with: "yy") 
        return formatter.string(from: date)
    }
}
