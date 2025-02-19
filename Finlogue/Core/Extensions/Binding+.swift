//
//  Binding+.swift
//  Finlogue
//
//  Created by Burak Gül on 9.02.2025.
//

import Foundation
import SwiftUI


public extension Binding {
    func didSet(execute: @escaping (_ oldValue: Value, _ newValue: Value) -> Void) -> Binding {
        return Binding (
            get: {
                return self.wrappedValue
            },
            set: {
                let oldValue = self.wrappedValue
                self.wrappedValue = $0
                execute(oldValue, self.wrappedValue)
            }
        )
        
    }
    
    func unwrap<T>(defaultValue: T) -> Binding<T> where Value == T? {
        return Binding<T>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}


