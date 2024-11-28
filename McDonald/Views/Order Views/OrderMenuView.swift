//
//  OrderMenuView.swift
//  McDonald
//
//  Created by Agata Przykaza on 19/11/2024.
//

import SwiftUI

struct OrderMenuView: View {
    
    @Environment(OrderViewModel.self) var orderModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            Group{
                
                Text("Zamów")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack{
                    
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .clipShape(.circle)
                    
                    
                    VStack(alignment: .leading){
                        
                        Text(orderModel.selectedRestaurant?.name ?? "Brak")
                            .fontWeight(.bold)
                        Text(orderModel.selectedRestaurant?.openHours.first?.1 ?? "Brak godziny")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    Button {
                        orderModel.mapModel.selectedLocation = nil
                        orderModel.navigationPath.append(ViewState.map)
                        orderModel.selectedRestaurant = nil
                        
                        
                    } label: {
                        
                        Text("Zmień restauracje")
                            .underline(color: .blue)
                            .foregroundStyle(.blue)
                    }
                    
                    
                }
            }
            .padding(.bottom)
            
            Divider()
            
            
            VStack{
                Text("Odkryj nasze menu")
                    .bold()
                
                
            }
            
            
            
           
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}



#Preview {
    OrderMenuView()
        .environment(OrderViewModel())
}
