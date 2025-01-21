//
//  BankView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI
import SwiftData

struct BankView: View {
    let bank: Bank
    @State var selectedTab: String = "Accounts"
    var tabs: [String] = ["Accounts", "Cards"]
    var body: some View {
        
            
            Picker("Bank", selection: $selectedTab) {
                ForEach(tabs, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal, 32)
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TabView(selection: $selectedTab) {
                AccountsView()
                    .tag("Accounts")
                CardsView()
                    .tag("Cards")
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Kaydırma desteği

//        Text(bank.name)
    }
}

#Preview {
    BankView(
        bank: Bank(name: "Deneme")
    )
}
