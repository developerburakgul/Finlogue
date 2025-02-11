//
//  CreateCardView.swift
//  Finlogue
//
//  Created by Burak Gül on 3.02.2025.
//

import SwiftUI
public enum FocusableItems: Hashable {
    case cardType, cardLimit, cardNumber, expireDate, cvv, backgroundPicker, textColorPicker
}
struct CreateCardView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedCardType: CardType?
    @State var cardLimitText: String = ""
    @State var cardNumberText: String = ""
    @State var cvvText: String = ""
    
    @State private var expireDate: Date?
    @State var isShowExpireDate: Bool = false
    @FocusState var focusedItem: FocusableItems?
    
    @State var backgroundColor: Color = .gray
    @State var textColor: Color = .black
    
   
    
    
    var body: some View {
        cardView
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                cardTypeSelectionView
                if selectedCardType == .credit {
                    cardLimitView
                }
                cardNumberView
                HStack {
                    expireDateView
                        .sheet(isPresented: $isShowExpireDate) {
                            self.expireDatePicker
                                .presentationDetents([.medium])
//                                .presentationDragIndicator(.visible)
                                .edgesIgnoringSafeArea(.all)
                        }
                    
                    Spacer()
                    cvvView
                }
                HStack {
                    backgroundColorPicker
                    textColorPicker
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    if let focused = focusedItem {
                        switch focused {
                        case .cardLimit:
                            Button("Go") {
                                focusedItem = .cardNumber
                            }
                        case .cardNumber:
                            Button("Go") {
                                focusedItem = .expireDate
                                isShowExpireDate = true
                            }
                        case .expireDate:
                            Button("Go") {
                                focusedItem = .cvv
                            }
                        case .cvv:
                            Button("Go") {
                                focusedItem = nil
                            }
                        default:
                            EmptyView()
                        }
                    }
                    
                }
                
                
            }
            .navigationTitle("Add Card")
        }
    }
    
    private var cardView: some View {
        CardView(
            card: Card(
                cardType:
                    selectedCardType == nil ? .debit : selectedCardType!,
                cardNumber: cardNumberText == "" ? "**** **** **** ****" : cardNumberText,
                currentBalance: 0,
                overlayColorData: backgroundColor.toData(),
                textColorData: textColor.toData(),
                expireDate: expireDate
            ),
            showCardDetailLogo: false
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
            if newValue == .credit {
                // Credit seçildiğinde cardLimit'e focus ol
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    focusedItem = .cardLimit
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
                        let formattedValue = formatCardNumber(newValue)
                        if formattedValue != cardNumberText {
                            cardNumberText = formattedValue
                        }
                        
                    }
            }
        
    }
    //
    private var expireDateView: some View {
        
        CustomView(
            title: "Expire Date",
            item: .expireDate,
            focus: $focusedItem,
            isValid: expireDate != nil) {
                Image(systemName: "calendar")
                    .onTapGesture {
                        isShowExpireDate.toggle()
                    }
            } content: {
                Text(DateFormatter.expireDateString(for: expireDate))
                    .onTapGesture {
                        isShowExpireDate.toggle()
                    }
            }
        
        
    }
    
    private var cvvView: some View {
        
        CustomView(
            title: "Cvv",
            item: .cvv,
            focus: $focusedItem,
            isValid: false) {
                Image(systemName: "info.circle")
            } content: {
                TextField("***", text: $cvvText)
                    .keyboardType(.namePhonePad)
                    .focused($focusedItem, equals: .cvv)
            }
        
    }
    
    private var expireDatePicker: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Select Expiration Date")
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button("Done") {
                    isShowExpireDate = false
                    focusedItem = .cvv
                }
                .padding()
            }
            .frame(height: 44) // Fixed height for header
            .background(Color(UIColor.systemGray))
            
            // Picker
            MonthYearWheelPicker(
                monthTitle: .constant("Months"),
                yearTitle: .constant("Years"),
                date: .constant(Date.now)
            )
            .frame(maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.top) // Bu satır önemli
        .focused($focusedItem, equals: .expireDate)
    }
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
    func formatCardNumber(_ number: String) -> String {
        let filtered = number.filter { $0.isNumber}
        var result = ""
        for (index, character) in filtered.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(character)
        }
        if result.count > 19 {
            result = String(result.prefix(19))
        }
        return result
    }
    
}

#Preview {
    NavigationStack {
        CreateCardView()
    }
}
