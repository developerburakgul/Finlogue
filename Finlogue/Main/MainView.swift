//
//  MainView.swift
//  Finlogue
//
//  Created by Burak Gül on 14.01.2025.
//

import SwiftUI

enum Tabs: String, CaseIterable, Hashable{
    
    
    case home, dashboard, add, accounts, profile
    
    var nonselectedImage: String {
        switch self {
        case .home:
            return "house"
        case .dashboard:
            return "chart.pie"
        case .add:
            return "plus"
        case .accounts:
            return "wallet.bifold"
        case .profile:
            return "person"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .home:
            return "house.fill"
        case .dashboard:
            return "chart.pie.fill"
        case .add:
            return "plus.circle.fill"
        case .accounts:
            return "wallet.bifold.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    var title: String {
        return self.rawValue.capitalized
    }
    
    
}
struct MainView: View {
    @State var selectedTab: Tabs = .home
    @State var isShowAddSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(Tabs.home)
                dashboardView
                    .tag(Tabs.dashboard)
                BankListView()
                    .tag(Tabs.accounts)
                
                SettingsView()
                    .tag(Tabs.profile)
            }
            .sheet(isPresented: $isShowAddSheet) {

            }
            
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.1))
                .frame(width: .infinity, height: 70)
                .padding(.horizontal)
                .overlay {
                    
                    HStack(alignment: .center,spacing: 16) {
                        ForEach(Tabs.allCases, id: \.self) { item in
                            if item != .add {
                                Button {
                                    selectedTab = item
                                } label: {
                                    CustomTabItem(item: item,isActive: (selectedTab == item))
                                }
                                
                            } else {
                                Button {
                                    isShowAddSheet = true
                                } label: {
                                    CustomTabItem(item: item, isActive: false)
                                }
                                .frame(width: 65, height: 65)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 0.8)
                                .offset(y: 0)

                            }
                        }
                        
                    }
                    .padding()
                    .frame(height: 65)
                }
        }
    }
    func CustomTabItem(item: Tabs, isActive: Bool) -> some View{
        VStack(alignment: .center,spacing: 4){
            
            Image(systemName: isActive ? item.selectedImage : item.nonselectedImage)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 15, height: 15)
                .imageScale(isActive ? .large : .small)
            
            
            Text(item.rawValue.capitalized)
                .font(.caption)
                .foregroundColor(isActive ? .black : .gray)
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
