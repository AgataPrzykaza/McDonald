//
//  LocationCardView.swift
//  McDonald
//
//  Created by Agata Przykaza on 17/11/2024.
//

import SwiftUI

enum ButtonPosition{
    case center
    case right
}

struct LocationCardView: View {
    @Environment(OrderViewModel.self) var orderModel
    var restaurant: RestaurantLocation
    var buttonPosition: ButtonPosition
   
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text(restaurant.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Text("odleglosc")
                    .padding(3)
                    .background(.gray.opacity(0.3),in: .rect(cornerRadius: 10))
            }
           
            
            Text(restaurant.address)
                .foregroundStyle(.secondary)
                .frame(width: 300,alignment: .leading)
                .multilineTextAlignment(.leading)
            
            HStack{
                Text("Serwisy")
            }
            
            HStack{
                
                
                Text("Zobacz szczegóły")
                    .underline(color: .blue)
                    .foregroundStyle(.blue)
                
                Spacer()
                
                if buttonPosition == .right{
                    Button{
                        
                        orderModel.selectedRestaurant = restaurant
                      
                        orderModel.rootView = .order
                        
                        orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                        
                        
                    } label: {
                        Text("Zamów tutaj")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .padding(6)
                            .background(.accent.mix(with: .orange, by: 0.2), in: .rect(cornerRadius: 10))
                    
                    }
                    .contentShape(Rectangle())
                }
             
                   

                
            }
            
            if buttonPosition == .center{
                Button{
                    
                    orderModel.selectedRestaurant = restaurant
                    orderModel.rootView = .order
                    
                    orderModel.navigationPath.removeLast(orderModel.navigationPath.count)
                    
                    
                } label: {
                    ButtonView(title: "Zamów tutaj", color: .yellow)
                
                }
            }
          
            
            
        }
        .frame(height: 100)
        .padding([.bottom,.top])
    }
}

#Preview {
    LocationCardView( restaurant: mockRestaurants.first!, buttonPosition: .right)
        .padding()
        .environment(OrderViewModel())
}
