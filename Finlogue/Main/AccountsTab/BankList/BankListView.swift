//
//  BankListView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI
import SwiftData

struct BankListView: View {
    
    @State private var isShowCreateBankView: Bool = false
    @StateObject var viewModel: BankListViewModel = .init()
    
    var body: some View {
        NavigationStack {
            Group{
                if viewModel.bankListIsEmpty {
                    emptyView
                } else {
                    bankListView
                }
            }
            .sheet(isPresented: $isShowCreateBankView) {
                CreateBankView()
                    .presentationDetents([.fraction(0.33)])
                    .onDisappear {
                        viewModel.loadBanks()
                    }
            }
            .navigationDestination(for: Bank.self) { bank in
                BankView(bankViewModel: BankViewModel(bank: bank))
                    
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
            ForEach(viewModel.banks) { bank in
                NavigationLink(value: bank) {
                    BankListItemView(bank: bank)
                }
            }
            .onDelete(perform: viewModel.deleteBank)
        }
//        .listStyle()
    }

}

#Preview {
    NavigationStack {
        BankListView()
    }
}
