//
//  HomeView.swift
//  Finlogue
//
//  Created by Burak Gül on 19.01.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedSegment: HomeViewSegments = .general
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                segmentView
                    .padding(.vertical)
                    .padding(.horizontal, 32)
                Spacer()
                if selectedSegment == .general {
                    GeneralView()
                } else {
                    ComingView()
                }
                Spacer()
            }
            .navigationTitle("Home")
        }
        
    }
    
    private var segmentView: some View {
        Picker("Choose", selection: $selectedSegment) {
            ForEach(HomeViewSegments.allCases, id: \.self) { tab in
                Text(tab.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

private enum HomeViewSegments: String, CaseIterable {
    case general = "Genel"
    case coming = "Yaklaşanlar"
}

#Preview {
    HomeView()
}
