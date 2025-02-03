//
//  BGTextField.swift
//  Finlogue
//
//  Created by Burak Gül on 2.02.2025.
//

import SwiftUI



struct BGTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var title: String = "Title"
    var placeholder: String = "PlaceHolder..."
    var focusBorderColor: Color = .black
    var unFocusBorderColor: Color = .gray
    
    var image: Image?
    var imageAction: (() -> Void )?
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            HStack {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .padding()
                
                if image != nil {
                    image
                        .padding()
                        .onTapGesture {
                            imageAction?()
                        }
                }
                
            }
            .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            isFocused
                            ? focusBorderColor
                            : unFocusBorderColor,
                            lineWidth: 1
                        )
                )
            
            Text(title)
                .font(.caption)
                .foregroundColor(
                    isFocused
                    ? focusBorderColor
                    : unFocusBorderColor
                )
                .padding(.horizontal, 4)
                .background(Color(UIColor.systemBackground))
                .offset(x: 0, y: -8)
                .scaleEffect(0.9, anchor: .trailing)
        }
        .padding()
        
        
    }
}

#Preview {
//    @Previewable @State var text = "Burak"
//    BGTextField(text: $text) 
    @Previewable @State var text = ""
    BGTextField(text: $text)
}
