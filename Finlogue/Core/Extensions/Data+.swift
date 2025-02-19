//
//  Data+.swift
//  Finlogue
//
//  Created by Burak Gül on 13.02.2025.
//
import Foundation
import SwiftUI

extension Data {
    func toColor() -> Color {
        do {
            guard let uiColor = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: self
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
