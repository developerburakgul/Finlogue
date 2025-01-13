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
            
            Tab("Dashboard", systemImage: "chart.pie") {
                settingsView
                    .tag(0)
            }
            
            Tab("Transactions", systemImage: "list.bullet.rectangle") {
                settingsView
                    .tag(1)
            }
            
            Tab("Analytics", systemImage: "chart.bar") {
                settingsView
                    .tag(2)
            }
            
            Tab("Accounts", systemImage: "creditcard") {
                settingsView
                    .tag(3)
            }
            
            Tab("Settings", systemImage: "gear") {
                settingsView
                    .tag(4)
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
