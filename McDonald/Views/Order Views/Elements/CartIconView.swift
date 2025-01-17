//
//  CartIconView.swift
//  McDonald
//
//  Created by Agata Przykaza on 09/01/2025.
//

import SwiftUI


struct CartIconView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    @Environment(MainViewModel.self) var mViewModel
    
   
    
    var body: some View {
        Image(systemName: "cart.circle.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .foregroundStyle(.orange)
            .padding(12)
            .overlay(alignment: .topTrailing) {
                if let order = orderModel.order, !order.items.isEmpty {
                    Text("\(order.items.count)")
                        .padding(10)
                        .foregroundStyle(.white)
                        .background(.red, in: .circle)
                }
                
                
            }
            .padding(.horizontal,15)
            
           
           
    }
}


