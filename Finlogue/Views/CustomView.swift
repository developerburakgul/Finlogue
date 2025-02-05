//
//  CustomView.swift
//  Finlogue
//
//  Created by Burak Gül on 5.02.2025.
//

import SwiftUI

struct CustomView<ImageContent: View, MainContent: View>: View {
    
    @Binding var focusState: Bool
    var title: String = "Title"
    var focusBorderColor: Color = .black
    var unFocusBorderColor: Color = .gray
    var imageContent: ImageContent?
    var content: MainContent
    
    init(
        focusState: Binding<Bool>,
        title: String,
        focusBorderColor: Color = Color(uiColor: UIColor.label),
        unFocusBorderColor: Color = Color(uiColor: UIColor.secondaryLabel),
        @ViewBuilder imageContent: () -> ImageContent?,
        @ViewBuilder content: () -> MainContent
    ) {
        self._focusState = focusState
        self.title = title
        self.focusBorderColor = focusBorderColor
        self.unFocusBorderColor = unFocusBorderColor
        self.imageContent = imageContent()
        self.content = content()
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                content
                if let imageContent {
                    Spacer()
                    imageContent
                }
            }
            .padding()
            
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        focusState ? focusBorderColor : unFocusBorderColor,
                        lineWidth: 1
                    )
                    
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(
                    focusState
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
    
    @Previewable @State var isFocused: Bool = false
    @Previewable @State var text: String = ""
    CustomView(
        focusState: $isFocused,
        title: "Username",
        focusBorderColor: .black,
        unFocusBorderColor: .gray
        ) {
            Image(systemName: "apple.logo")
                .foregroundColor(isFocused ? .black : .gray)
                .onTapGesture {
                    isFocused.toggle()
                }
        } content: {
            TextField("Enter username here...", text: $text)
                .onChange(of: text) { _ ,_ in
                    isFocused = !text.isEmpty
                }
        }

}
