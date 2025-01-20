//
//  MainView.swift
//  Finlogue
//
//  Created by Burak Gül on 14.01.2025.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView{
            
            Tab("Home", systemImage: "house") {
                HomeView()
                    .tag(0)
            }
            
            Tab("Dashboard", systemImage: "chart.pie") {
                settingsView
                    .tag(1)
            }
        
            
            Tab("Accounts", systemImage: "wallet.bifold.fill") {
                BankListView()
                    .tag(2)
            }
            
            Tab("Profile", systemImage: "person") {
                SettingsView()
                    .tag(3)
            }
            
            
        }
        .tabViewStyle(.tabBarOnly)
    }
    
    private var settingsView: some View {
        Text("Settings")
    }
}

#Preview {
    MainView()
}
