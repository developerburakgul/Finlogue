//
//  CreateBankViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 19.02.2025.
//

import Foundation


final class CreateBankViewModel: ObservableObject {
    @Published var name: String = ""
    private var bankService: BankServiceProtocol
    
    init(
        bankService: BankServiceProtocol = BankService(
            modelContainer: CustomModelContainer.container
        )
    ) {
        self.bankService = bankService
    }
    
    func create(_ bank: Bank){
        Task { @MainActor in
            try await bankService.add(bank)
            
        }
    }
}
