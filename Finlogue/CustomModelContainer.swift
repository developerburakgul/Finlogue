//
//  CustomModelContainer.swift
//  Finlogue
//
//  Created by Burak Gül on 18.02.2025.
//

import Foundation
import SwiftData

final class CustomModelContainer {
    static let container: ModelContainer = {
        do {
            let schema = Schema([Account.self])
            return try ModelContainer(for: schema, configurations: [])
        } catch {
            fatalError("Unable to initialize ModelContainer: \(error)")
        }
    }()
}
