//
//  CreateCardView.swift
//  Finlogue
//
//  Created by Burak Gül on 3.02.2025.
//

import SwiftUI

struct CreateCardView: View {
    
    enum FocusableTextFields: Hashable {
        case cardNumber, expireDate, cvv
    }
    @State var cardNumber: String = "Burak"
    @State var expireDate: String = ""
    @State var cvv: String = ""
    @FocusState var focusedTextField: FocusableTextFields?
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            cardNumberView
            HStack {
                expireDateView
                Spacer()
                cvvView
            }
        }
    }
    
    private var cardNumberView: some View {
        BGTextField(
            text: Binding(
                get: { cardNumber },
                set: { newValue, _ in
                    cardNumber = "2"
                }
            ),
            title: "Card Number",
            placeholder: "**** **** **** ****"
        )
        .focused($focusedTextField, equals: .cardNumber)
        .keyboardType(.decimalPad)
        .submitLabel(.go)
        .onSubmit {
            // validate for card number for example has it 16 digit
            nextFocusState()
            
        }
        
    
    }
    
    private var expireDateView: some View {
        BGTextField(
            text: $expireDate,
            title: "Expire Date",
            placeholder: "MM/YY",
            image: Image(systemName: "calendar")) {
                print("Burak")
            }
            .focused($focusedTextField, equals: .expireDate)
            .onSubmit {
                nextFocusState()
            }
            
    }
    
    private var cvvView: some View {
        BGTextField(
            text: $cvv,
            title: "Cvv",
            placeholder: "***",
            image: Image(systemName: "info.circle")) {
                print("Burak")
            }
            .focused($focusedTextField, equals: .cvv)
            .onSubmit {
                nextFocusState()
            }
    }
    
    
    private func nextFocusState() {
        switch focusedTextField {
        case .cardNumber:
            focusedTextField = .expireDate
        case .expireDate:
            focusedTextField = .cvv
        case .cvv:
            focusedTextField = nil
        case nil:
            focusedTextField = nil
        }
    }
    



    
    
}

#Preview {
    CreateCardView()
}
