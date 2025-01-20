//
//  BankListView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI
import SwiftData

struct BankListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Bank.name) private var banks: [Bank]
    @State private var isShowCreateBankView: Bool = false
    
    //MARK: - Computed properties
    private var banksIsEmpty: Bool {
        banks.isEmpty
    }
    var body: some View {
        NavigationStack {
            Group{
                if banksIsEmpty {
                    emptyView
                } else {
                    bankListView
                }
            }
            .sheet(isPresented: $isShowCreateBankView) {
                CreateBankView()
                    .presentationDetents([.fraction(0.33)])
            }
            
            .navigationTitle("My Banks")
        }
        
        
        
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            ContentUnavailableView("Add bank account", systemImage: "dollarsign.bank.building", description: Text("Descripiton"))
            
            Button {
                isShowCreateBankView = true
            } label: {
                Circle()
                    .fill(Color.black)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    )
            }
            Spacer()

        }
        
        
    }
    
    private var bankListView: some View {
        List {
            ForEach(banks) { bank in
                Text(bank.name)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BankListView()
    }
}
