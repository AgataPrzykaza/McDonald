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
                    
                   
                    Button {
                        orderModel.orderType = .onPlace
                        orderModel.navigationPath.append(ViewState.summary)
                        
                        
                    } label: {
                        VStack{
                            Rectangle()
                                .frame(height: 150)
                            
                            Text("Na miejscu")
                            
                        }
                    }
                    .foregroundStyle(.black)


                    
                    Button{
                        
                        orderModel.orderType = .takeAway
                        orderModel.navigationPath.append(ViewState.summary)
                        
                        
                    }label: {
                        VStack{
                            Rectangle()
                                .frame(height: 150)
                            
                            Text("Na wynos")
                        }
                    }
                    .foregroundStyle(.black)
                    
                    
                    
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
