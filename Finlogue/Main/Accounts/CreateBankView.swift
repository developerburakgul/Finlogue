//
//  CreateBankView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct CreateBankView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var name: String = ""
    
    private var isDisableCreateButton: Bool {
        name.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter your bank name here ...", text: $name)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        //MARK: - TODO
                        let bank = Bank(name: name)
                        context.insert(bank)
                        dismiss()
                    }
                    .disabled(isDisableCreateButton)
                }
            }
        }
    }
}

#Preview {
    CreateBankView()
}
