//
//  OrderTypeView.swift
//  McDonald
//
//  Created by Agata Przykaza on 15/01/2025.
//

import SwiftUI

struct OrderTypeView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    var body: some View {
        
        ScrollView{
            VStack{
                
                Text("Jaki rodzaj zamówienia ?")
                    .font(.title)
                    .bold()

                HStack{
                    
                   

                    
                    VStack{
                        Rectangle()
                            .frame(height: 150)
                        
                        Text("Na miejscu")
                        
                    }
                    
                    VStack{
                        Rectangle()
                            .frame(height: 150)
                        
                        Text("Na wynos")
                    }
                    
                }
                .padding()
                .padding(.top,50)
                
            }
            .padding(.top,70)
        }
    }
}

#Preview {
    OrderTypeView()
        .environment(OrderViewModel())
}
