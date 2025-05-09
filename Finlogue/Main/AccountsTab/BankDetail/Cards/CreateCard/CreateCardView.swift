//
//  CreateCardView.swift
//  Finlogue
//
//  Created by Burak Gül on 3.02.2025.
//

import SwiftUI
public enum FocusableItems: Hashable {
    case cardType,cardNumber, cardLimit, linkedBankAccount,  expireDateText, cvv, backgroundPicker, textColorPicker
}
struct CreateCardView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: CreateCardViewModel
    @FocusState var focusedItem: FocusableItems?
    @State var isShowExpireDate: Bool = false
    //MARK: - Common
    @State var backgroundColor: Color = .gray
    @State var textColor: Color = .black
    @State var cardNumberText: String = ""
    @State var selectedCardType: CardType?
    @State var expireDateText: String = ""
    @State var cvvText: String = ""
    //MARK: - Debit
    @State var selectedBankAccount: Account?
    
    var shouldSaveCard: Bool {
        canSaveDebitCard || canSaveCreditCard
    }
    
    var canSaveDebitCard: Bool{
        selectedCardType == .debit
        && selectedBankAccount != nil
    }
    var canSaveCreditCard: Bool{
        selectedCardType == .credit
        && cardLimitText != ""
    }
    
    
    //MARK: - Credit
    @State var cardLimitText: String = ""
    
    
    var body: some View {
        cardView
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                cardTypeSelectionView
                cardNumberView
                if selectedCardType == .credit {
                    cardLimitView
                } else if selectedCardType == .debit {
                    bankAccountSelectionView
                }
                HStack {
                    expireDateView
                    Spacer()
                    cvvView
                }
//                HStack {
//                    backgroundColorPicker
//                    textColorPicker
//                }
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
//                    Spacer()
//                    if let focused = focusedItem {
//                        switch focused {
//                        case .cardLimit:
//                            Button("Go") {
//                                focusedItem = .cardNumber
//                            }
//                        case .cardNumber:
//                            Button("Go") {
//                                focusedItem = .expireDateText
//                                isShowExpireDate = true
//                            }
//                        case .expireDateText:
//                            Button("Go") {
//                                focusedItem = .cvv
//                            }
//                        case .cvv:
//                            Button("Go") {
//                                focusedItem = nil
//                            }
//                        default:
//                            EmptyView()
//                        }
//                    }
                    
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        createCard()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(shouldSaveCard ? Color.green : Color.gray)
                    }
                    .padding()
                    .disabled(!shouldSaveCard)
                    .buttonStyle(.bordered)
                    
                }
                
                
            }
            .navigationTitle("Add Card")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private var cardView: some View {
        return CreatingCardView(
            overlayColor: $backgroundColor,
            textColor: $textColor,
            cardType: $selectedCardType,
            cardNumber: $cardNumberText,
            limitText: $cardLimitText,
            expireDateText: $expireDateText,
            cvvText: $cvvText,
            linkedBankAccount: $selectedBankAccount
        )
        
    }
    
    private var cardTypeSelectionView: some View {
        
        
        Menu {
            Picker("", selection: $selectedCardType) {
                ForEach(CardType.allCases, id: \.self) { type in
                    Text(type.name).tag(type)
                }
            }
        } label: {
            CustomView(
                title: "Card Type",
                item: .cardType,
                focus: $focusedItem,
                isValid: selectedCardType != nil) {
                    Image(systemName: "creditcard.and.123")
                    if selectedCardType != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                } content: {
                    Text(selectedCardType?.name ?? "Select Card Type")
                }
        }
        .onChange(of: selectedCardType) { oldValue, newValue in
        }
        
    }
    
    private var cardNumberView: some View {
        CustomView(
            title: "Card Number",
            item: .cardNumber,
            focus: $focusedItem,
            isValid: cardNumberText.count == 19) {
                if cardNumberText.count == 19{
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if focusedItem == .cardNumber {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                }
            } content: {
                TextField("**** **** **** ****", text: $cardNumberText)
                    .keyboardType(.numberPad)
                    .focused($focusedItem, equals: .cardNumber)
                    .onChange(of: cardNumberText) { oldValue, newValue in
                        let formattedValue = viewModel.formatCardNumber(newValue)
                        if formattedValue != cardNumberText {
                            cardNumberText = formattedValue
                        }
                    }
            }
        
    }
    //
    private var cardLimitView: some View {
        CustomView(
            title: "Card Limit",
            item: .cardLimit,
            focus: $focusedItem,
            isValid: !cardLimitText.isEmpty) {
                if cardLimitText != "" {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                }
            } content: {
                makeVerticalValidationView(
                    errorText: "This Field should not be empty",
                    isValid: cardLimitText != "") {
                        TextField("Enter your card limit", text: $cardLimitText)
                            .keyboardType(.numberPad)
                            .focused($focusedItem, equals: .cardLimit) // Bu satırı ekleyin
                        
                    }
            }
        
        
    }
    
    private var bankAccountSelectionView: some View {
        
        
        Menu {
            Picker("", selection: $selectedBankAccount) {
                ForEach(viewModel.bankAccounts, id: \.self) { type in
                    Text(type.name).tag(type)
                    
                }
            }
        } label: {
            CustomView(
                title: "Linked Bank Account",
                item: .linkedBankAccount,
                focus: $focusedItem,
                isValid: selectedBankAccount != nil) {
                    Image(systemName: "creditcard.and.123")
                    if selectedCardType != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                } content: {
                    Text(selectedBankAccount?.name ?? "Select Bank Account")
                }
        }
        .onChange(of: selectedCardType) { oldValue, newValue in
            
        }
        .onAppear {
            viewModel.updateBankAccounts()
        }
        
    }

    

    //
    private var expireDateView: some View {
        
        CustomView(
            title: "Expire Date",
            item: .expireDateText,
            focus: $focusedItem,
            isValid: !expireDateText.isEmpty) {
                Image(systemName: "calendar")
                    .onTapGesture {
                        isShowExpireDate.toggle()
                    }
            } content: {
                TextField("MM/YY", text: $expireDateText)
                    .keyboardType(.namePhonePad)
                    .focused($focusedItem, equals: .expireDateText)
                    .onChange(of: expireDateText) { oldValue, newValue in
                        let formattedValue = viewModel.formatExpireDateText(newValue)
                        if formattedValue != expireDateText {
                            expireDateText = formattedValue
                        }
                    }
            }
        
        
    }
    
    private var cvvView: some View {
        
        CustomView(
            title: "Cvv",
            item: .cvv,
            focus: $focusedItem,
            isValid: !cvvText.isEmpty) {
                Image(systemName: "info.circle")
            } content: {
                TextField("***", text: $cvvText)
                    .keyboardType(.namePhonePad)
                    .focused($focusedItem, equals: .cvv)
                    .onChange(of: cvvText) { oldValue, newValue in
                        let formattedValue = viewModel.formatCVVText(newValue)
                        if formattedValue != cvvText {
                            cvvText = formattedValue
                        }
                    }

            }
        
    }
    
//    private var expireDatePicker: some View {
//        VStack(spacing: 0) {
//            // Header
//            HStack {
//                Text("Select Expiration Date")
//                    .font(.headline)
//                    .padding()
//                
//                Spacer()
//                
//                Button("Done") {
//                    isShowExpireDate = false
//                    focusedItem = .cvv
//                }
//                .padding()
//            }
//            .frame(height: 44) // Fixed height for header
//            .background(Color(UIColor.systemGray))
//            
//            // Picker
//            MonthYearWheelPicker(
//                monthTitle: .constant("Months"),
//                yearTitle: .constant("Years"),
//                date: .constant(Date.now)
//            )
//            .frame(maxHeight: .infinity)
//        }
//        .edgesIgnoringSafeArea(.top) // Bu satır önemli
//        .focused($focusedItem, equals: .expireDateText)
//    }
    //
    private var backgroundColorPicker: some View {
        
        CustomView(
            title: "Background Color",
            item: .backgroundPicker,
            focus: $focusedItem,
            isValid: false) {
                
            } content: {
                ColorPicker("", selection: $backgroundColor)
            }
        
    }
    private var textColorPicker: some View {
        CustomView(
            title: "Text Color",
            item: .textColorPicker,
            focus: $focusedItem,
            isValid: false) {
            } content: {
                ColorPicker("", selection: $textColor)
            }
    }
    private func makeVerticalValidationView<Content: View> (
        errorText: String,
        isValid: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content()
            if !isValid {
                Text(errorText)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
    
    func createCard() {
        if canSaveDebitCard {
            viewModel.createDebitCard(
                linkedAccount: selectedBankAccount!,
                cardNumberString: cardNumberText,
                expireDateString: expireDateText,
                cvvString: cvvText
            )
            dismiss()
        }
        
        if canSaveCreditCard {
            viewModel.createCreditCard(
                cardNumberString: cardNumberText,
                cardLimitText: cardLimitText,
                expireDateString: expireDateText,
                cvvString: cvvText
            )
            dismiss()
        }
        
    }

    
}

#Preview {
    NavigationStack {
        CreateCardView(viewModel: .init(bank: Bank.getRandomBank()))
    }
}
