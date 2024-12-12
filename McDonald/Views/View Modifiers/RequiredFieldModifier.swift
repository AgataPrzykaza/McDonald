//
//  RequiredFieldModifier.swift
//  McDonald
//
//  Created by Agata Przykaza on 12/12/2024.
//
import SwiftUI

struct RequiredFieldModifier: ViewModifier {
    let isRequired: Bool

    func body(content: Content) -> some View {
        HStack(spacing: 2) {
            if isRequired {
                Text("*")
                    .foregroundColor(.red)
            }
            content
            
        }
    }
}

extension View {
    func requiredField(_ isRequired: Bool = true) -> some View {
        self.modifier(RequiredFieldModifier(isRequired: isRequired))
    }
}
