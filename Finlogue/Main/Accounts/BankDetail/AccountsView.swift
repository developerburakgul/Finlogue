//
//  AccountsView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct AccountsView: View {
    var body: some View {
        List {
            Section("Vadesiz Hesaplarım (10)") {
                ForEach(0..<10) { int in
                    Text("\(int)")
                }
            }
            Section("Yatırım Hesaplarım") {
                ForEach(0..<3) { int in
                    Text("\(int)")
                }
            }
        }
    }
}

#Preview {
    AccountsView()
}
