//
//  CreateCardView.swift
//  Finlogue
//
//  Created by Burak Gül on 3.02.2025.
//

import SwiftUI

struct CreateCardView: View {
    @Environment(\.dismiss) var dismiss
    enum FocusableItems: Hashable {
        case cardNumber, expireDate, cvv
    }
    @State var cardNumber: String = ""
    @State var expireDate: String = ""
    @State var cvv: String = ""
    @State var isShowExpireDate: Bool = false
    
    @State private var selectedDate = Date()
    @FocusState var focusedItem: FocusableItems?
    @State var selectedMonth: Months = .january
    @State var selectedYear: Int = Date().getCurrentYear
    
    
    
    @State var selectedCardType: CardType?
    @State var cardLimit: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            cardTypeSelectionView
            cardLimitView
            cardNumberView
            HStack {
                expireDateView
                    .sheet(isPresented: $isShowExpireDate) {
                        self.expireDatePicker
                    }
                Spacer()
                cvvView
            }
            
        }
        .navigationTitle("Add Card")
        
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
                focusState: .constant(true),
                title: "Card Type") {
                    Image(systemName: "creditcard.and.123")
                } content: {
        
                    Text(selectedCardType?.name ?? "Select Card Type")
                }
                
        }

    }
    
    private var cardLimitView: some View {
        CustomView(
            focusState: .constant(false),
            title: "Card Limit") {
                Image("xmark")
            } content: {
                TextField("Enter your card limit", text: $cardLimit)
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            
                            Spacer()
                            Text("Go")
                                .onTapGesture {
                                    // to do go to other field
                                }
                        }
                        
                        
                    }
            }

    }
    
    private var cardNumberView: some View {
        CustomView(
            focusState: .constant(false),
            title: "Card Number") {
            } content: {
                TextField("**** **** **** ****", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            
                            Spacer()
                            Text("Go")
                                .onTapGesture {
                                    // to do go to other field
                                }
                        }
                        
                        
                    }
            }
    }
    
    private var expireDateView: some View {
        
        CustomView(
            focusState: .constant(false),
            title: "Expire Date") {
                Image(systemName: "calendar")
                    .onTapGesture {
                        isShowExpireDate.toggle()
                    }
            } content: {
                Text("Burak")
                    .onTapGesture {
                        isShowExpireDate.toggle()
                    }
            }
        
    }
    
    private var cvvView: some View {
        CustomView(
            focusState: .constant(false),
            title: "Cvv") {
                Image(systemName: "info.circle")
            } content: {
                TextField("***", text: $cvv)
                    .keyboardType(.namePhonePad)
            }
    }
    
    
    private var expireDatePicker: some View {
        ExpireDatePicker(
            selectedMonth: $selectedMonth,
            selectedYear: $selectedYear
        )
    }
    
    
}

#Preview {
    NavigationStack {
        CreateCardView()
    }
}
