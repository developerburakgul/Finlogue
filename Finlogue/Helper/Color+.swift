//
//  Color+.swift
//  Finlogue
//
//  Created by Burak Gül on 9.02.2025.
//

import Foundation
import SwiftUI

// MARK: - Color ⇄ Data Dönüşümleri
extension Color {
    func toData() -> Data {
        let uiColor = UIColor(self)
        do {
            return try NSKeyedArchiver.archivedData(
                withRootObject: uiColor,
                requiringSecureCoding: false
            )
        } catch {
            print("Color → Data dönüşüm hatası: \(error)")
            return Data() // Fallback boş data
        }
    }
    
    static func fromData(_ data: Data) -> Color {
        do {
            guard let uiColor = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: data
            ) else {
                return .white // Varsayılan renk
            }
            return Color(uiColor)
        } catch {
            print("Data → Color dönüşüm hatası: \(error)")
            return .white // Fallback rengi
        }
    }
}
