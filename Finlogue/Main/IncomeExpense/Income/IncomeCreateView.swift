//
//  IncomeCreateView.swift
//  Finlogue
//
//  Created by Burak Gül on 2.03.2025.
//

import SwiftUI
enum IncomeType: String, CaseIterable, Identifiable {
    var id: Self {
        return self
    }
    case oneTime,continuous
}

struct IncomeCreateView: View {
    @ObservedObject var viewModel: IncomeCreateViewModel
    
    
    @State var selectedIncomeType: IncomeType = .oneTime
    @State var incomeName: String = ""
    @State var incomeAmount: String = ""
    @State var transactionDate: Date = .now
    @State var selectedAccount: Account = Account.getRandomAccount(time: 20)[4]
    @State var firstIncomeExpectedDate: Date = .now
    @State var incomeFrequency: IncomeFrequency = .monthly
    
    var isEnabled: Bool {
        isEnableOneTimeIncome || isEnableContiniousIncome
    }
    
    var isEnableOneTimeIncome: Bool {
        selectedIncomeType == .oneTime
        && !incomeName.isEmpty
        && !incomeAmount.isEmpty
    }
    
    var isEnableContiniousIncome: Bool {
        selectedIncomeType == .continuous
        && !incomeName.isEmpty
        && !incomeAmount.isEmpty
    }
    var body: some View {
        
        ScrollView {
            
            incomeNameInput
            
            incomeAmountInput
            incomeTypeSelection
            accountSelection
            if selectedIncomeType == .oneTime {
                transactionDateInput
            }
            if selectedIncomeType == .continuous {
                incomeFreqeuencySelection
                firstIncomeExpectedDateInput
            }
            Spacer()
            
            Button {
                createIncome()
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

    
    private var incomeNameInput: some View {
        CustomView2(
            title: "Income Input") {
                EmptyView()
            } content: {
                TextField("Income Name", text: $incomeName)
            }
    }
    
    private var incomeAmountInput: some View {
        CustomView2(
            title: "Amount") {
                EmptyView()
            } content: {
                TextField("Income Amount", text: $incomeAmount)
            }
    }
    
    private var incomeTypeSelection: some View {
        Menu {
            Picker("Income Type Selection", selection: $selectedIncomeType) {
                ForEach(IncomeType.allCases) { item in
                    Text(item.rawValue)
                }
                .foregroundColor(Color.red)
            }
        } label: {
            CustomView2(
                title: "Income Type Selection") {
                    EmptyView()
                } content: {
                    Text(selectedIncomeType.rawValue)
                }
        }
    }
    
    private var accountSelection: some View {
        Menu {
            Picker("Account Selection", selection: $selectedAccount) {
                ForEach(viewModel.accounts) { item in
                    Text(item.name)
                        .tag(item)
                }
            }
        } label: {
            CustomView2(
                title: "Account  Selection") {
                    EmptyView()
                } content: {
                    Text(selectedAccount.name)
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
    
    private var incomeFreqeuencySelection: some View {
        Menu {
            Picker("Income Frequency", selection: $incomeFrequency) {
                ForEach(IncomeFrequency.allCases) { frequency in
                    Text(frequency.name)
                        .tag(frequency)
                }
            }
        } label: {
            CustomView2(
                title: "Income Frequency") {
                    EmptyView()
                } content: {
                    Text(incomeFrequency.name)
                }
        }
    }
    
    private var firstIncomeExpectedDateInput: some View {
        CustomView2(
            title: "First Income Expected Date") {
            } content: {
                DatePicker("First Income Expected Date", selection: $firstIncomeExpectedDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
            }
    }
    
    private func createIncome() {
        //MARK: - TODO
        if selectedIncomeType == .oneTime {
            viewModel.createOneTimeIncome(
                name: incomeName,
                amount: incomeAmount,
                account: selectedAccount,
                transactionDate: transactionDate
            )
        }
    }
}


#Preview {
    IncomeCreateView(viewModel: IncomeCreateViewModel())
}
