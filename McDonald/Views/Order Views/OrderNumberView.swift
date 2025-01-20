//
//  OrderNumberView.swift
//  McDonald
//
//  Created by Agata Przykaza on 20/01/2025.
//

import SwiftUI

struct OrderNumberView: View {
    @Environment(OrderViewModel.self) var orderModel
    var body: some View {
        VStack{
            
            Text("Numer Twojego zamówienia: ")
                .font(.title2)
                .fontWeight(.heavy)
            
            Text(String(orderModel.lastOrderNumber))
                .font(.system(size: 100, weight: .bold))
                .frame(width: 200,height: 100)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)

            
            Button{
                orderModel.rootView = .order
                
                orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
            }label: {
                Text("Przejdź do menu")
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OrderNumberView()
        .environment(OrderViewModel())
}
