//
//  FinlogueApp.swift
//  Finlogue
//
//  Created by Burak Gül on 12.01.2025.
//

import SwiftUI
import SwiftData

@main
struct FinlogueApp: App {
    var body: some Scene {
        WindowGroup {
            IntroView()
        }
        .modelContainer(for: Bank.self)
    }
}
