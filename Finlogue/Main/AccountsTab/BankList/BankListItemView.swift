//
//  BankListItemView.swift
//  Finlogue
//
//  Created by Burak Gül on 19.02.2025.
//
import SwiftUI

struct BankListItemView: View {
    let bank: Bank
    var isPositiveNetAmount: Bool {
        bank.netAmount > 0
    }
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: bank.iconName)
                .imageScale(.large)
            
            Text(bank.name)
                .font(.title2)
                .fontWeight(.medium)
            Spacer()
            Text("\(bank.netAmount)" + " " + "$")
                .foregroundColor(
                    isPositiveNetAmount
                    ? Color(UIColor.systemGreen)
                    : Color(UIColor.systemRed)
                )
                .fontWeight(.bold)
        }
    }
}

#Preview {
    BankListItemView(
        bank: Bank(name: "Garanti Bankası")
    )
}
