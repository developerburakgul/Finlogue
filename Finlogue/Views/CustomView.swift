//
//  CustomView.swift
//  Finlogue
//
//  Created by Burak Gül on 5.02.2025.
//

import SwiftUI
enum CustomFocusState {
    case unFocus,focus,done
    
    var borderColor: Color {
        switch self {
        case .unFocus:
            Color(uiColor: UIColor.secondaryLabel)
        case .focus:
            Color(uiColor: UIColor.label)
        case .done:
            Color(uiColor: UIColor.systemGreen)
        }
    }
    var foreGroundColor: Color {
        switch self {
        case .unFocus:
            Color(uiColor: UIColor.secondaryLabel)
        case .focus:
            Color(uiColor: UIColor.label)
        case .done:
            Color(uiColor: UIColor.systemGreen)
        }
    }
}

struct CustomView<ImageContent: View, MainContent: View>: View {
    var title: String
    var item: FocusableItems // Hangi alan olduğu (ör: .cardNumber)
    var focus: FocusState<FocusableItems?>.Binding // Ana view'dan gelen odak state'i
    var isValid: Bool
    var imageContent: ImageContent?
    var content: MainContent
    
    init(
        title: String,
        item: FocusableItems,
        focus: FocusState<FocusableItems?>.Binding,
        isValid: Bool,
        @ViewBuilder imageContent: () -> ImageContent?,
        @ViewBuilder content: () -> MainContent
    ) {
        self.title = title
        self.item = item
        self.focus = focus
        self.isValid = isValid
        self.imageContent = imageContent()
        self.content = content()
    }
    
    var borderColor: Color {
        if focus.wrappedValue == item {
            return .black
        } else if isValid {
            return .green
        } else {
            return .gray
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                content
                    .focused(focus, equals: item) // ⚠️ Düzeltildi
                    .foregroundColor(borderColor)
                
                if let imageContent {
                    Spacer()
                    imageContent
                        .foregroundColor(borderColor)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            }
            .onTapGesture {
                focus.wrappedValue = item
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(borderColor)
                .padding(.horizontal, 4)
                .background(Color(UIColor.systemBackground))
                .offset(x: 0, y: -8)
                .scaleEffect(0.9, anchor: .trailing)
        }
        .padding()
    }
}

#Preview {
    @Previewable @FocusState var focusedItem: FocusableItems? // 🔑 FocusState tanımı
    @Previewable @State var text: String = ""
    @Previewable @State var text2: String = ""
    @Previewable  @State var selectedCardType: CardType?
    


    Menu {
        Picker("", selection: $selectedCardType) {
            ForEach(CardType.allCases, id: \.self) { type in
                Text(type.name).tag(type)
            }
        }
    } label: {
        CustomView(
            title: "Select Card Type",
            item: .cardType,
            focus: $focusedItem,
            isValid: selectedCardType != nil) {
                HStack {
                    Image(systemName: "creditcard.and.123")
                    if selectedCardType != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
            } content: {
                Text(selectedCardType?.name ?? "Select Card Type")
            }

    }
    

    
    CustomView(
        title: "Card Number",
        item: .cardNumber,
        focus: $focusedItem, // ✅ Doğru tip: FocusState.Binding
        isValid: !text.isEmpty,
        imageContent: {
            Image(systemName: "checkmark.circle.fill")
        },
        content: {
            TextField("**** **** **** ****", text: $text)
        }
    )
    CustomView(
        title: "Limit",
        item: .cardLimit,
        focus: $focusedItem, // ✅ Doğru tip: FocusState.Binding
        isValid: !text2.isEmpty,
        imageContent: {
            Image(systemName: "checkmark.circle.fill")
        },
        content: {
            TextField("7500", text: $text2)
        }
    )
    

    
    
}


//@Binding var focusState: CustomFocusState
//    var title: String = "Title"
//    var foregroundColor: Color?
//    var imageContent: ImageContent?
//    var content: MainContent
//    init(
//        focusState: Binding<CustomFocusState>,
//        title: String,
//        foregroundColor: Color? = nil,
//        @ViewBuilder imageContent: () -> ImageContent?,
//        @ViewBuilder content: () -> MainContent
//    ) {
//        self._focusState = focusState
//        self.title = title
//        self.foregroundColor = foregroundColor
//        self.imageContent = imageContent()
//        self.content = content()
//    }
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            HStack {
//                content
//                    .foregroundColor(
//                        foregroundColor != nil
//                        ? foregroundColor
//                        : focusState.foreGroundColor
//                    )
//                if let imageContent {
//                    Spacer()
//                    imageContent
//                        .foregroundColor(
//                            foregroundColor != nil
//                            ? foregroundColor
//                            : focusState.foreGroundColor
//
//                        )
//                }
//            }
//            .padding()
//            .overlay {
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(
//                        foregroundColor != nil
//                        ? foregroundColor!
//                        : focusState.foreGroundColor,
//                        lineWidth: 1
//                    )
//            }
//
//            Text(title)
//                .font(.caption)
//                .foregroundColor(
//                    foregroundColor != nil
//                    ? foregroundColor!
//                    : focusState.foreGroundColor
//                )
//                .padding(.horizontal, 4)
//                .background(Color(UIColor.systemBackground))
//                .offset(x: 0, y: -8)
//                .scaleEffect(0.9, anchor: .trailing)
//        }
//        .padding()
//    }
