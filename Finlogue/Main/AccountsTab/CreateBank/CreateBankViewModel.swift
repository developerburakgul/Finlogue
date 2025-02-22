//
//  CreateBankViewModel.swift
//  Finlogue
//
//  Created by Burak Gül on 22.02.2025.
//

import Foundation

class CreateBankViewModel: ObservableObject {
    @Published var name: String = ""
    private var bankService: CreateBankServiceProtocol
    
    init(bankService: CreateBankServiceProtocol = BankService(modelContainer: CustomModelContainer.container)) {
        self.bankService = bankService
    }
    
    var isEmptyName: Bool {
        name.isEmpty
    }
    
    func create(_ bank: Bank)  {
        //
        Task {
             try await bankService.add(bank)
        }
        
    }
    
    
}
