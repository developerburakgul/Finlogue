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
            .navigationDestination(for: Bank.self) { bank in
                BankView(bank: bank)
            }
            .navigationTitle("My Banks")
            .safeAreaInset(edge: .bottom, alignment: .center) {
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
                .padding()
            }
        }
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            ContentUnavailableView("Add bank account", systemImage: "dollarsign.bank.building", description: Text("Descripiton"))
            Spacer()
        }
    }
    
    private var bankListView: some View {
        List {
            ForEach(banks) { bank in
                NavigationLink(value: bank) {
                    BankListItemView(bank: bank)
                }
            }
            .onDelete(perform: deleteBank)
        }
//        .listStyle()
    }
    
    private func deleteBank(at offsets: IndexSet) {
        for index in offsets {
            let deleteItem = banks[index]
            withAnimation {
                context.delete(deleteItem)
            }
        }
    }
}

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

#Preview {
    NavigationStack {
        BankListView()
    }
}
