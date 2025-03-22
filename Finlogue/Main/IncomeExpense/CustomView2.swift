//
//  CustomView.swift
//  Finlogue
//
//  Created by Burak Gül on 4.03.2025.
//

import SwiftUI

struct CustomView2<ImageContent: View, MainContent: View>: View {
    var title: String
    var imageContent: ImageContent?
    var content: MainContent
    
    init(
        title: String,
        @ViewBuilder imageContent: () -> ImageContent?,
        @ViewBuilder content: () -> MainContent
    ) {
        self.title = title
        self.imageContent = imageContent()
        self.content = content()
    }
    
    var borderColor: Color {
        Color.black
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                content
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

    @Previewable @State var text: String = ""
    @Previewable @State var text2: String = ""
    
    

    
    CustomView2(
        title: "Card Number",
        imageContent: {
            Image(systemName: "checkmark.circle.fill")
        },
        content: {
            TextField("**** **** **** ****", text: $text)
        }
    )
    
    CustomView2(
        title: "Limit",
        imageContent: {
            Image(systemName: "checkmark.circle.fill")
        },
        content: {
            TextField("7500", text: $text2)
        }
    )
    

    
    
}
