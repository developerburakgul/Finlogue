//
//  ExpenseCreateView.swift
//  Finlogue
//
//  Created by Burak Gül on 8.03.2025.
//

import SwiftUI

enum SelectablePaymentSource: Identifiable, Hashable {
    case cashAccount(Account)
    case debitCard(DebitCard)
    case creditCard(CreditCard)

    var id: UUID {
        switch self {
        case .cashAccount(let account):
            return account.id
        case .debitCard(let debitCard):
            return debitCard.id
        case .creditCard(let creditCard):
            return creditCard.id
        }
    }

    var displayName: String {
        switch self {
        case .cashAccount(let account):
            return "Vadesiz Hesap - \(account.name)"
        case .debitCard(let debitCard):
            return "Debit Card - \(debitCard.cardNumber ?? "**** **** **** ****")"
        case .creditCard(let creditCard):
            return "Credit Card - \(creditCard.cardNumber ?? "**** **** **** ****")"
        }
    }
}

enum ExpenseType: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    case oneTime,continuous
}

struct ExpenseCreateView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExpenseCreateViewModel
    
    
    
    @State var expenseName: String = ""
    @State var expenseAmount: String = ""
    @State var selectedExpenseType: ExpenseType = .oneTime
    @State var transactionDate: Date = .now
    @State var firstExpensePaymentDate: Date = .now
    @State var afterDayCountFromFirstPayment: Int = 0
    @State var expenseFreqeunency: ExpenseFrequency = .monthly
    @State var selectedPaymentSource: SelectablePaymentSource? = nil
    var isEnabled: Bool {
        isEnableOneTimeIncome || isEnableContiniousIncome
    }
    
    var isEnableOneTimeIncome: Bool {
        selectedExpenseType == .oneTime
        && !expenseName.isEmpty
        && !expenseAmount.isEmpty
    }
    
    var isEnableContiniousIncome: Bool {
        selectedExpenseType == .continuous
        && !expenseName.isEmpty
        && !expenseAmount.isEmpty
    }
    var body: some View {
        
        ScrollView {
            
            expenseNameInput
            
            expenseAmountInput
            expenseTypeSelection
            paymentSourceSelection
            if selectedExpenseType == .oneTime {
                transactionDateInput
            }
            if selectedExpenseType == .continuous {
                expenseFreqeuencySelection
                firstExpensePaymentDateInput
                afterDayCountFromFirstExpenseView
            }
            Spacer()
            
            Button {
                createExpense()
            } label: {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,8)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(isEnabled ? Color.green : Color.gray)
                    )
            }
            .padding(.horizontal)
        }
    }

    
    private var expenseNameInput: some View {
        CustomView2(
            title: "Expense Input") {
                EmptyView()
            } content: {
                TextField("Expense Name", text: $expenseName)
            }
    }
    
    private var expenseAmountInput: some View {
        CustomView2(
            title: "Amount") {
                EmptyView()
            } content: {
                TextField("Expense Amount", text: $expenseAmount)
            }
    }
    
    private var expenseTypeSelection: some View {
        Menu {
            Picker("Expense Type Selection", selection: $selectedExpenseType) {
                ForEach(ExpenseType.allCases) { item in
                    Text(item.rawValue)
                }
                .foregroundColor(Color.red)
            }
        } label: {
            CustomView2(
                title: "Expense Type Selection") {
                    EmptyView()
                } content: {
                    Text(selectedExpenseType.rawValue)
                }
        }
    }
    
    private var paymentSourceSelection: some View {
        Menu {
            Picker("", selection: $selectedPaymentSource) {
                ForEach(viewModel.paymentSources) { item in
                    Text(item.displayName)
                        .tag(item)
                }
            }
        } label: {
            CustomView2(
                title: "Payment Source Selection") {
                    EmptyView()
                } content: {
                    Text(selectedPaymentSource?.displayName ?? "Select Account")
                }
        }
    
    }
    
    private var afterDayCountFromFirstExpenseView: some View {
        Menu {
            Picker("", selection: $afterDayCountFromFirstPayment) {
                ForEach(0..<30) { item in
                    Text("\(item)")
                        .tag(item)
                }
            }
        } label: {
            CustomView2(
                title: "After Day Count From First Expense") {
                    EmptyView()
                } content: {
                    Text("\(afterDayCountFromFirstPayment)")
                }
        }
    
    }
    
    private var transactionDateInput: some View {
        CustomView2(
            title: "Date") {
                EmptyView()
            } content: {
                DatePicker("Transaction Date", selection: $transactionDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
            }
    }
    
    private var expenseFreqeuencySelection: some View {
        Menu {
            Picker("Expense Frequency", selection: $expenseFreqeunency) {
                ForEach(ExpenseFrequency.allCases) { frequency in
                    Text(frequency.name)
                        .tag(frequency)
                }
            }
        } label: {
            CustomView2(
                title: "Expense Frequency") {
                    EmptyView()
                } content: {
                    Text(expenseFreqeunency.name)
                }
        }
    }
    
    private var firstExpensePaymentDateInput: some View {
        CustomView2(
            title: "First Expense Payment  Date") {
            } content: {
                DatePicker("First Expense Payment Date", selection: $firstExpensePaymentDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
            }
    }
    
    private func createExpense() {
        guard let selectedPaymentSource = selectedPaymentSource else { return }
        
        //MARK: - TODO
        if selectedExpenseType == .oneTime {
            viewModel.createOneTimeExpense(
                name: expenseName,
                amount: expenseAmount,
                selectablePaymentSource: selectedPaymentSource,
                transactionDate: transactionDate
            )
        } else if selectedExpenseType == .continuous {
            viewModel.createContiniousExpense(
                name: expenseName,
                amount: expenseAmount,
                selectablePaymentSource: selectedPaymentSource,
                transactionDate: transactionDate,
                firstExpensePaymentDate: firstExpensePaymentDate,
                expenseFreqeunency: expenseFreqeunency,
                afterDayCountFromFirstPayment: afterDayCountFromFirstPayment
            )
        }
        
        dismiss()
    }
}

//#Preview {
//    ExpenseCreateView(viewModel: ExpenseCreateViewModel())
//}
