//
//  IncomeExpense.swift
//  Finlogue
//
//  Created by Burak Gül on 2.03.2025.
//

import SwiftUI
enum IncomeExpenseTabs: String, CaseIterable,Hashable {
    case income,expense
    var name: String {
        self.rawValue.capitalized
    }
}
struct IncomeExpense: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedTab: IncomeExpenseTabs = .income
    @State var amountText: String = ""
    
    @StateObject var viewModel: IncomeExpenseViewModel = .init()
    var body: some View {
        NavigationStack {
            VStack{
                segmentView
                    .padding()
                contentView
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Transaction")
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
    private var amountTextView: some View {
        HStack(alignment: .bottom, spacing: 4) {
            Spacer()
            TextField("0", text: $amountText)
                .font(.largeTitle)
                
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var segmentView: some View {
        Picker("", selection: $selectedTab) {
            ForEach(IncomeExpenseTabs.allCases, id: \.self) {
                Text($0.name)
            }
        }
        .pickerStyle(.segmented)
    }
    
    private var incomeView: some View {
        IncomeCreateView(viewModel: viewModel.incomeCreateViewModel)
    }
    
    private var expenseView: some View {
        ExpenseCreateView(viewModel: viewModel.expenseCreateViewModel)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch selectedTab {
        case .income:
            incomeView
        case .expense:
            expenseView
        }
    }
    

    

}

#Preview {
    IncomeExpense()
    
}
