//
//  MainView.swift
//  Finlogue
//
//  Created by Burak Gül on 14.01.2025.
//

import SwiftUI

enum Tabs: String, CaseIterable, Hashable{
    
    
    case home, dashboard, add, accounts, profile
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .dashboard:
            return "chart.pie"
        case .add:
            return "plus"
        case .accounts:
            return "wallet.bifold.fill"
        case .profile:
            return "person"
        }
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
    
    
}
struct MainView: View {
    @State var selectedTab: Tabs = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(Tabs.home)
                dashboardView
                    .tag(Tabs.dashboard)
                addView
                    .tag(Tabs.add)
                BankListView()
                    .tag(Tabs.accounts)
                
                SettingsView()
                    .tag(Tabs.profile)
            }
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.black.opacity(0.1))
                .frame(width: .infinity, height: 70)
                .padding(.horizontal)
                .overlay {
                    HStack(alignment: .center,spacing: 24) {
                        ForEach(Tabs.allCases, id: \.self) { item in
                            Button {
                                selectedTab = item
                            } label: {
                                CustomTabItem(imageName: item.imageName, title:item.title , isActive: (selectedTab == item))
                            }

                        }
                    }
                    .frame(height: 65)
                }
            
            
        }
    }
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
            VStack(alignment: .center,spacing: 4){
                
                Image(systemName: imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isActive ? .green : .black)
                    .frame(width: 15, height: 15)
                   
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(isActive ? .green : .black)
                    
            }
            
        }
    
    private var dashboardView: some View {
        Text("Dashboard")
    }    
    private var addView: some View {
        Text("Add")
    }
    
//    TabView{
//        
//        Tab("Home", systemImage: "house") {
//            HomeView()
//                .tag(0)
//        }
//        
//        Tab("Dashboard", systemImage: "chart.pie") {
//            settingsView
//                .tag(1)
//        }
//    
//        
//        Tab("Accounts", systemImage: "wallet.bifold.fill") {
//            BankListView()
//                .tag(2)
//        }
//        
//        Tab("Profile", systemImage: "person") {
//            SettingsView()
//                .tag(3)
//        }
//        
//        
//    }
//    .tabViewStyle(.tabBarOnly)
}

#Preview {
    MainView()
}
