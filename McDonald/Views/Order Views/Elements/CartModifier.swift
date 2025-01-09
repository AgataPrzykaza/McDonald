//
//  CartModifier.swift
//  McDonald
//
//  Created by Agata Przykaza on 09/01/2025.
//

import SwiftUI

struct CartModifier: ViewModifier {
    
    @Environment(OrderViewModel.self) var orderModel
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottomTrailing, content: {
                Button {
                    orderModel.navigationPath.append(ViewState.cart)
                } label: {
                    CartIconView()
                }

                
               
            })
    }
}


