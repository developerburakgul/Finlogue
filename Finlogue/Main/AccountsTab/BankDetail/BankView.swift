//
//  BankView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI
import SwiftData

struct BankView: View {
    enum Tabs: String, CaseIterable {
        case accounts = "Accounts"
        case cards = "Cards"
    }
    @State var selectedTab: Tabs = .accounts
    @ObservedObject var bankViewModel: BankViewModel
    
    var body: some View {
        let _ = Self._printChanges()
            Picker("Bank", selection: $selectedTab) {
                ForEach(Tabs.allCases, id: \.self) { item in
                    if item == .accounts {
                        Image(systemName: "bahtsign.bank.building")
                    } else {
                        Image(systemName: "creditcard")
                    }
                }
            }
            .padding(.horizontal, 32)
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TabView(selection: $selectedTab) {
                AccountsView(viewModel: bankViewModel.accountsViewModel)
                    .tag(Tabs.accounts)
                
                CardsView(viewModel: bankViewModel.cardsViewModel)
                    .tag(Tabs.cards)
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Kaydırma desteği
    }
}

//#Preview {
//    BankView(
//        bank: Bank(name: "Deneme")
//    )
//}


struct SegmentView: View {
    let title: String
    let image: Image
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
            image
        }
    }
}
