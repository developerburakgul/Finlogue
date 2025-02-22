//
//  CreateBankView.swift
//  Finlogue
//
//  Created by Burak Gül on 21.01.2025.
//

import SwiftUI

struct CreateBankView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: CreateBankViewModel = .init()
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter your bank name here ...", text: $viewModel.name)
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
                        let bank = Bank(name: viewModel.name)
                        viewModel.create(bank)
                        dismiss()
                    }
                    .disabled(viewModel.isEmptyName)
                }
            }
        }
    }
}

//#Preview {
//    CreateBankView()
//}
